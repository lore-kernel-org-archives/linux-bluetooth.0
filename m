Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Date: Tue, 21 Jun 2016 22:27:51 +0200
Message-ID: <CAEZxfGOiiBs_eCGsgsm=CvoJSsGtEsFENr8uxEbzSnt400f6qg@mail.gmail.com>
Subject: Cached device in a weird place
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As I was explaining to sjanc in #bluez, I've noticed some weird
behaviour regarding some cached device and I think I found one reason
today.
As you can see below, a device called tis9E is found in "devices"
command while I have removed all devices with "remove *" command
previously and not seen this device for a long time.

I wonder now where this comes from.
How such an old device would come back from the dead like that?

Thanks in advance,
Francois.

---

localhost / # bluetoothctl
[NEW] Controller A4:17:31:78:A6:04 Chromebook_0A65 [default]
[NEW] Device C7:78:B4:5F:FA:DF tis9E
[bluetooth]# devices
Device C7:78:B4:5F:FA:DF tis9E

---

localhost bluetooth # more
/var/lib/bluetooth/A4\:17\:31\:78\:A6\:04/C7\:78\:B4\:5F\:FA\:DF/info
[General]
Name=tis9E
AddressType=static
SupportedTechnologies=LE;
Trusted=false
Blocked=false

---

localhost bluetooth # more
/var/lib/bluetooth/A4\:17\:31\:78\:A6\:04/cache/C7\:78\:B4\:5F\:FA\:DF/
more: stat of /var/lib/bluetooth/A4:17:31:78:A6:04/cache/C7:78:B4:5F:FA:DF/
failed: No such file or directory
