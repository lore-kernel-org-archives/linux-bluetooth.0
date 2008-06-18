Return-Path: <cyrus@holtmann.org>
Message-ID: <008e01c8d113$c65174b0$6e01a8c0@Raymondpc>
From: "colorant" <colorant@163.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
References: <e96e9eeb0806130507u139f58a2sa7094a65f9ecff17@mail.gmail.com>
	<4852914F.6020209@earthlink.net>
Date: Wed, 18 Jun 2008 15:20:23 +0800
MIME-Version: 1.0
Subject: [Bluez-users] Error encounter when connecting A2DP following wiki
	instruction ! How to connect A2DP ?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi

    I try to connect earphone with A2DP on arm board .
    I follow the instruction from 
http://wiki.bluez.org/wiki/HOWTO/AudioDevices

    I encounter error while doing connect saying connect method does not 
exist !

    This is what I did :


~ # ps
  PID  Uid        VSZ Stat Command
  .....
  271 root       1576 SW< /sbin/udevd --daemon
  445 root       1884 SW  /bin/sh /etc/init.d/rc 2
  454 root       1964 SW  /bin/sh
  554 root            SW< [krfcommd]
  563 messagebus   1944 SW  /usr/bin/dbus-daemon --system --fork
  566 root       1416 SW  hciattach -s 921600 /dev/ttyS1 bcsp 921600
  573 root       1564 SW  ./sdpd
  575 root       2520 SW  hcid -d
  578 root       2444 SW  /usr/lib/bluetooth/bluetoothd-service-audio
  579 root       2412 SW  /usr/lib/bluetooth/bluetoothd-service-input
  619 root       1960 RW  ps

 ~ # dbus-send --system --print-reply --dest=org.bluez /org/bluez 
org.bluez.Manager.ActivateService string:audio
method return sender=:1.0 -> dest=:1.8
   string ":1.1"

~ # dbus-send --system --type=method_call --print-reply --dest=org.bluez 
/org/bluez org.bluez.Manager.ActivateService string:audio
method return sender=:1.0 -> dest=:1.9

~ # dbus-send --system --type=method_call --print-reply --dest=":1.1" 
/org/bluez/audio org.bluez.audio.Manager.CreateDevice 
string:00:02:5B:00:C1:A0
method return sender=:1.1 -> dest=:1.10
   string "/org/bluez/audio/device3"
~ #
~ # dbus-send --system --type=method_call --print-reply --dest=":1.1" 
"/org/bluez/audio/device3" org.bluez.audio.Sink.Connect
Error org.freedesktop.DBus.Error.UnknownMethod: Method "Connect" with 
signature "" on interface "org.bluez.audio.Sink" doesn't exist


So I have following questions :

1 . Anyone can help to point out what might be wrong in the above operation 
?

2. Actually I also try the method of modify the /etc/asound.conf to add the 
bluetooth and use aplay directly to play the music, that way also not 
working!

~ # cat /etc/asound.conf
pcm.bluetooth{
        type bluetooth
        device "00:02:5b:00:c1:a0"
        profile "auto"
}
~ # aplay -D bluetooth sample.wav
Segmentation fault
~ #

What might be the reason ? I can do aplay sample.wav to speaker. So alsa 
utils should be ok.

3. I notice that , on this howto, it do not mentioned the process of 
pairing, Shouldn't that be done in some other place ? How can I done that ? 
actually I have put in hcid.conf something like :

# HCId options
options {
    ....
        security auto;
        pairing multi;
        passkey "1234";
    ....
}

But this one do not work for dbus-send method , right ?

Thanks.

Raymond






-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
