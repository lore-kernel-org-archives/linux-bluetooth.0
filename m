Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sun, 19 Jul 2009 20:45:20 -0700
Message-ID: <dd18b0c30907192045t3078451ao9af4c1751d9efe91@mail.gmail.com>
Subject: btusb_send_frame: hci0 urb ede00a50 submission failed
From: Justin Mattock <justinmattock@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Not sure whats happening here,
this morning using s2ram worked like a charm,
now at the end of the day this thing takes a good minute to
wakeup. As for the blueooth finally got it working, but
now I'm seeing this in dmesg:


[  708.630722] Restarting tasks ... done.
[  708.910090] usb 5-1: USB disconnect, address 3
[  708.910262] btusb_send_frame: hci0 urb ede00a50 submission failed
[  709.330776] [drm] Loading R500 Microcode

Maybe suspend works better when cooler, but in anycase
the bluetooth works perfectly recovers from s2ram, scrollball
works as well(all with SELinux running too).


-- 
Justin P. Mattock
