Return-Path: <cyrus@holtmann.org>
References: 
Message-ID: <1394913186.89692.YahooMailNeo@web28801.mail.ir2.yahoo.com>
Date: Sat, 15 Mar 2014 19:53:06 +0000 (GMT)
From: Alessandro La Fauci <alafauci@yahoo.it>
Reply-To: Alessandro La Fauci <alafauci@yahoo.it>
Subject: Bluez+PulseAudio: creating audio sink
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I have been struggling to send audio from my laptop (ubuntu) to my headless debian wheezy with 5.1 card via bluetooth.
On debian bluez 4.9 and pulse 4.
I got to the point where bluetooth connection is successfully bond but not audio connection (following an excerpt of pulseaudio log);
org.bluez.AudioSource and AudioSink are connected, but nothing happens for org.bluez.Audio, thus pulse module-bluetooth doesn't see any source.
The full pulse log may be found at this link https://bugs.freedesktop.org/attachment.cgi?id=95844

At this point I'm very lost and I don't know how to proceed, it seems the problem comes from bluez and has nothing to do with pulse.
Thank you in advance for any kind of help

Cheers

----------------------------------- (  20.582|  10.158) D: [pulseaudio] bluetooth-util.c: dbus: interface=org.bluez.Device, path=/org/bluez/2473/hci0/dev_88_53_2E_5C_F0_8E, member=PropertyChanged
(  20.763|   0.180) D: [pulseaudio] bluetooth-util.c: dbus: interface=org.bluez.AudioSource, path=/org/bluez/2473/hci0/dev_88_53_2E_5C_F0_8E, member=PropertyChanged
(  20.763|   0.000) D: [pulseaudio] bluetooth-util.c: Device /org/bluez/2473/hci0/dev_88_53_2E_5C_F0_8E interface org.bluez.AudioSource property 'State' changed to value 'connecting'
(  20.765|   0.002) D: [pulseaudio] bluetooth-util.c: dbus: interface=org.bluez.AudioSink, path=/org/bluez/2473/hci0/dev_88_53_2E_5C_F0_8E, member=PropertyChanged
(  20.766|   0.000) D: [pulseaudio] bluetooth-util.c: Device /org/bluez/2473/hci0/dev_88_53_2E_5C_F0_8E interface org.bluez.AudioSink property 'State' changed to value 'connecting'
(  20.767|   0.000) D: [pulseaudio] bluetooth-util.c: dbus: interface=org.bluez.Audio, path=/org/bluez/2473/hci0/dev_88_53_2E_5C_F0_8E, member=PropertyChanged
(  20.767|   0.000) D: [pulseaudio] bluetooth-util.c: Device /org/bluez/2473/hci0/dev_88_53_2E_5C_F0_8E interface org.bluez.Audio property 'State' changed to value 'connecting'
(  20.900|   0.133) D: [pulseaudio] bluetooth-util.c: dbus: interface=org.bluez.AudioSource, path=/org/bluez/2473/hci0/dev_88_53_2E_5C_F0_8E, member=PropertyChanged
(  20.901|   0.000) D: [pulseaudio] bluetooth-util.c: Device /org/bluez/2473/hci0/dev_88_53_2E_5C_F0_8E interface org.bluez.AudioSource property 'State' changed to value 'connected' -----------------------------------
