Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1510567471.8923.18.camel@hadess.net>
Subject: Re: Can't connect a Xbox one controller
From: Bastien Nocera <hadess@hadess.net>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Anthony Bourguignon <contact@toniob.net>,
        linux-bluetooth@vger.kernel.org
Date: Mon, 13 Nov 2017 11:04:31 +0100
In-Reply-To: <1510240298.2624.23.camel@hadess.net>
References: <1471515072.4976.10.camel@toniob.net> <8760qwy6vv.fsf@intel.com>
         <1471642506.3626.5.camel@toniob.net> <87zio8wcya.fsf@intel.com>
         <1471697662.3650.1.camel@toniob.net> <87inuqw9gs.fsf@intel.com>
         <1510235357.2624.9.camel@hadess.net> <1510237731.2624.19.camel@hadess.net>
         <1510240298.2624.23.camel@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey,

I'm still working on getting some interesting information out of this.
The first thing is:

> ACL Data RX: Handle 256 flags 0x02 dlen 15              #38 [hci0] 7.314671
      L2CAP: Configure Response (0x05) ident 3 len 7
        Source CID: 64
        Flags: 0x0000
        Result: Failure - unknown options (0x0003)
        04                                               .   

This tells us that the pad doesn't like the RFC request (Retransmit and
Flow Control, not Request For Configuration, as I thought it might
mean).

The specification says[1]:
> The remote device proposes Basic L2CAP mode in a Configuration
> Request
> and the local device proposes Enhanced Retransmission mode or
> Streaming mode. The remote device rejects the local device's
> Configuration
> Request by sending a negative Configuration Response proposing Basic
> mode. The local device will send a second Configuration Request
> proposing
> Basic L2CAP mode or disconnect the channel. If the local device sends
> a
> second Configuration Request that does not propose Basic L2CAP mode
> then the remote device will disconnect the channel. If the local
> device rejects
> the remote device's Configuration Request then the remote device will
> disconnect the channel.

And[2]:
> The Basic L2CAP mode is the default. If Basic L2CAP mode is requested
> then all other parameters shall be ignored.
> Enhanced Retransmission mode should be enabled if a reliable channel
> has
> been requested. Enhanced Retransmission mode shall only be sent to an
> L2CAP entity that has previously advertised support for the mode in
> its
> Extended Feature Mask (see Section 4.12).
> Streaming mode should be enabled if a finite L2CAP Flush Time-Out is
> set
> on an L2CAP connection. Streaming mode shall only be sent to a device
> that has previously advertised support for the mode in the Extended
> Feature
> Mask (see Section 4.12).

But the code only ever sets the mode to BASIC if it was basic before,
never trying to upgrade the mode:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/bluetooth/l2cap_core.c#n3230

I'm also unclear on whether the current code checks whether the L2CAP
Flush Time-Out is set, which is required for Streaming Mode to be
enabled.

So I think that we should try to set a non-BASIC mode in when setting
the RFC config request in l2cap_build_conf_req() [3], and if the mode
is streaming, but only if L2CAP_CONF_FLUSH_TO is non-zero. Break out if
the remote device doesn't support ERTM or has a 0 flush timeout.

Am I on the right track?

[1]: BLUETOOTH SPECIFICATION Version 5.0 | Vol 3, Part A
page 1790
[2]: BLUETOOTH SPECIFICATION Version 5.0 | Vol 3, Part A
page 1785
[3]: How do I get the remote feature mask? I couldn't figure it out

On Thu, 2017-11-09 at 16:11 +0100, Bastien Nocera wrote:
> On Thu, 2017-11-09 at 15:28 +0100, Bastien Nocera wrote:
> > 
> 
> <snip>
> > Here's the btmon output of a pairing attempt.
> 
> And this is a pairing attempt with disable_ertm set to 1.
> 
> You will see a gap of about a minute between 2 events:
> @ MGMT Event: Device Disconnected (0x000c) plen
> 8                                                                    
>                                                                     {
> 0x0001} [hci0] 12.103542
>         BR/EDR Address: C8:3F:26:80:BA:71 (Microsoft Corporation)
>         Reason: Connection terminated by local host (0x02)
> > HCI Event: Connect Request (0x04) plen
> > 10                                                                 
> >                                                                    
> >                #77 [hci0] 81.172351
> 
>         Address: C8:3F:26:80:BA:71 (Microsoft Corporation)
>         Class: 0x000508
>           Major class: Peripheral (mouse, joystick, keyboards)
>           Minor class: 0x02
>         Link type: ACL (0x01)
> 
> The pad carried on blinking expecting "something". I turned the pad
> off
> by long pressing on the "XBox" button, and turned it on again. I got
> a
> service authentication request:
> [CHG] Device C8:3F:26:80:BA:71 Connected: yes
> Authorize service
> [agent] Authorize service 00001124-0000-1000-8000-00805f9b34fb
> (yes/no): yes
> 
> And it's now connected and working.
