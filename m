Return-Path: <cyrus@holtmann.org>
Message-ID: <25531.83.160.35.87.1230718419.squirrel@webmail.xs4all.nl>
Date: Wed, 31 Dec 2008 11:13:39 +0100 (CET)
Subject: Bluez disconnect Motorola phone when using in combination with     
      Asterisk
From: "menno" <jongerenchaos@zonnet.nl>
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


I use chan_mobile for incomming and outbound calls in combination with
bluez 4.19. This works well but i
think there is a problem with the audio buffer. Some examples:

Inbound call (from cellphone):
Audio from cellphone to asterisk is delayed (with 1 second and after a
while this will be bigger and bigger)
Audio from asterisk to the cellphone is NOT delayed

Outbound call (to the cellphone):
Audio from cellphone to asterisk is delayed (with 1 second and after a
while this will be bigger and bigger)
Audio from asterisk to the cellphone is NOT delayed

I use:
- Asterisk SVN-trunk-r166731
- CSR BC4(bluetooth dongle)
- 2.6.28-3-server ubuntu kernel
- bluez 4.19 (tar.gz version)
- L6 motorola phones
- Class: 0x200404
- Chan_mobile (
http://svn.digium.com/svn/asterisk-addons/trunk/channels/chan_mobile.c )

I think there is a problem with the buffer. I think he can't loose the
bufferoverflow and the frame size is bigger and bigger or something.

When i use bluez 4.25 the audio is in the begin also delayed (short delay
<0.5 second). But within 1 minute the delay is away for the next 5
minutes! After 5 minutes the delay becomes again higher and higher and
after 20 <> 40 minutes the connection is broken between the bluetooth
phone and asterisk.

How can we resolve this problem (can anybody look at the chan_mobile file
and give a patch so that i can test it)??


