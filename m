Return-Path: <kai.heng.feng@canonical.com>
From: Kai Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Paired bluetooth keyboards lead to system auto resume from S3 when
 WoL enabled for e1000e
Message-Id: <E17B265A-7432-4BAB-8B92-3A7FB3B1B09F@canonical.com>
Date: Tue, 30 Jan 2018 16:07:03 +0800
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 "Fujinaka, Todd" <todd.fujinaka@intel.com>,
 Ethan Hsieh <ethan.hsieh@canonical.com>
To: Linux USB Mailing List <linux-usb@vger.kernel.org>,
 Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
 linux-nics@intel.com
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This is actually a continuation of [1] with more findings.
The machine in question is a CFL desktop. The auto resume roughly
happens in 5 ~ 10 mins.

After further digging, I found out that the e1000e and XHCI always
shares the same wakeup count in /sys/kernel/debug/wakeup_sources,
so I did some experiment on e1000e.

Here=E2=80=99s the tricky finding, disable WoL for e1000e can stop the =
erratic
behaviour - the machine no longer auto resume. One caveat though -
I can no longer wake up the system by pressing the BT keyboard.

No idea where to file the bug so include all three subsystems.

[1] https://www.spinics.net/lists/linux-bluetooth/msg73683.html

Kai-Heng=
