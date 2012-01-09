Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1326138887.6454.165.camel@aeonflux>
References: <CAHZ1yC=3Ecj-4-SAHnD93S7_YVF+f_o__Hb2PYFcaoCs_NDoPw@mail.gmail.com>
	<1325893697.6454.113.camel@aeonflux>
	<CAHZ1yCkPoHMA52dxMPp=5g_zibOjQui=ffiSGXR1GAiOqUGciA@mail.gmail.com>
	<1325900406.6454.116.camel@aeonflux>
	<CAHZ1yCkDf9zM3mzvQT-6A+WWY506vtW9Hk8r_RW8+-A-7mcfgA@mail.gmail.com>
	<1326138887.6454.165.camel@aeonflux>
Date: Mon, 9 Jan 2012 12:03:14 -0800
Message-ID: <CAHZ1yCmLV6RS6EA7+p2+VDG05YNSNUxCbo8gLcq2t04Ahn2Kcw@mail.gmail.com>
Subject: Re: Bluetooth 2.1 keyboard not sending keypress notifications
From: Scott James Remnant <keybuk@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jan 9, 2012 at 11:54 AM, Marcel Holtmann <marcel@holtmann.org> wrote:

>> So it turns out that the Mac isn't doing anything special either; it's
>> doing ordinary 2.0 authentication. But the twist is an L2CAP
>> connection and configuration request/response before authentication is
>> requested, this seems to enable the keyboard sending a Vendor Event
>> every time a key is pressed during authentication.
>
> that is what I thought. Get your Packet Logger in OS X running and hope
> that it decodes a bit more. However getting this integrated into BlueZ
> might be a lot trickier. This is nasty stuff.
>
Right now it looks like it's just making a connection to the HID
Interrupt PSM (0x13), and while that connection is open, seeing the
keypresses.

Is there an L2CAP debugger on the Linux side, so I can make sure I'm
replicating what it's doing packetwise?

Scott
-- 
Scott James Remnant | Chrome OS Systems | keybuk@google.com | Google
