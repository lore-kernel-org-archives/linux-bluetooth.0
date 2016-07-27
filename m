Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5799150B.2040401@littlecraft.io>
References: <5799150B.2040401@littlecraft.io>
From: Jason Gauthier <jagauthier@gmail.com>
Date: Wed, 27 Jul 2016 19:25:00 -0400
Message-ID: <CAHY_EhU3F-DN5N9cUt=BSnd=LH1+05xqSpwCFE-iEr+hoQALYw@mail.gmail.com>
Subject: Re: HFP - No Audio
To: Matthew Waddell <matt@littlecraft.io>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Matthew,

 That was my original email, but no success.  The BT adapter in the
raspberry pi 3 I was using does not show any SCO packets during the
call.  I've moved to an external BT device and I haven't had any
issues with it.

When the call is made, your screen should be *flooded* with SCO
packets.  If not, then you are experiencing the same problem that I've
never found a solution to.

Good luck,

Jason

On Wed, Jul 27, 2016 at 4:09 PM, Matthew Waddell <matt@littlecraft.io> wrote:
> Hi,
>
> I am trying to configure HFP to allow in-call audio to be routed through my
> PC's audio card.  I'm interested to know the current state of support, and
> if anyone has had success in getting it to work.  I have tried various
> combinations of the following components, but have so far been unable to get
> the in-call audio working:
>
> Kernel: 4.4.11, 4.6.4, 4.7 (unstable)
> Bluez: 5.37, 5.7, 5.8, 5.9
> Pulesaudio: 7, 8, 9
> Ofono: 1.7, 1.8, 1.9
> USB Bluetooth Adapters:
>      0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (CSR8510 A10)
>      0a5c:21e8 Broadcom Corp. BCM20702A0 Bluetooth 4.0 (with firmware
> 001.002.014 build 1338)
>
> I've can verify that ofono is able to detect the HFP capabilities of a
> connected device, and to establish a 'modem' to it. Pulseaudio is also
> notified when a call becomes active, and appears to load the appropriate
> loopbacks to route the audio from/to the call through the HFP modem. Hacking
> in some extra debug tracing to pulseaudio, I've verified that pulseaudio
> receives SCO packets from the file descriptor that it receives from ofono.
> Still, I am unable to hear any audio from the call.
>
> Something interesting that I've noticed, however, is that if I look at the
> in-call traffic with hcidump, it looks to me like the payloads of each of
> the SCO packets that are received from the remote device (the phone) are
> either all 0x0000 or 0x0001.  I have not seen cases where it is anything
> other than that.
>
> Does anyone have any suggestions for what might be going on, or how I might
> be able to debug this further?
>
> This post from May sounds like similar circumstances, and possibly even a
> success story:
> http://www.spinics.net/lists/linux-bluetooth/msg67283.html
>
>
> Thanks!
> _matt
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
