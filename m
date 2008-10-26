Return-Path: <cyrus@holtmann.org>
Message-ID: <40aff9180810251901l6ecfa88drd671c08a5ac33821@mail.gmail.com>
Date: Sun, 26 Oct 2008 03:01:03 +0100
From: Fiorellino <fiorellino@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: pairing of bluez-utils 3.36-1 with keysonic 340 BT fails (no PIN requested)
In-Reply-To: <40aff9180810251825w1085c6d6q5ee37406475809cf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <40aff9180810251825w1085c6d6q5ee37406475809cf@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi there,

I have a keysonic bluetooth keyboard.
It works perfectly under windows (I know you don't care, but at least
the keyboard is working fine!) using the embedded BT controller of my
laptop.

Now I'd like to use it under Debian lenny/sid in an embedded PC
(alix3d3) using a Trust Ultra Small Bluetooth 2 USB Adapter.

With "apt-get install" I installed bluez-utils 3.36-1.

I tried to follow this howto:
http://www.ubuntugeek.com/howto-setup-bluetooth-keyboard-and-mouse-in-ubuntu.html

Everything seemed pretty promising:

hcitool scan would find the keyboard

I added the device in /etc/bluetooth/hcid.conf as suggested and now it
looks like this:

voyage:~# cat /etc/bluetooth/hcid.conf
options {
        autoinit yes;
        security auto;
        pairing multi;
        passkey "1234";
}
device {
        name "%h-%d";
        class 0x000100;
        iscan enable; pscan enable;
        lm master;
        lp rswitch,hold,sniff,park;
        discovto 0;
}
device 00:18:00:00:78:86 {
        name "BTKB-7886";
        auth enable;
        encrypt enable;
}

I restarted bluez using /etc/init.d/bluetooth restart and tried to
connect with hidd --search...

I type the passkey and pressed enter on the keyboard. From the linux
prospective, everything seems fine.

If I show connected BT devices, the keyboard is listed, but the
pairing led keeps blinking, and the keyboard doesn't work.

I also trying compiling passkey-agent and have "passkey-agent
--default 1234" in the background, but didn't help.

You can find that other people had the issue:
http://ubuntuforums.org/showthread.php?t=911262
http://ubuntuforums.org/showthread.php?t=800863

Any idea or help is appreciated.

Thank you,

alfonso
