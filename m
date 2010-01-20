Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: "Luis R. Rodriguez" <mcgrof@gmail.com>
Date: Wed, 20 Jan 2010 12:13:26 -0800
Message-ID: <43e72e891001201213x6a2c203dl7121f2dde6d61fb9@mail.gmail.com>
Subject: FYI - new compat-wireless based on 2.6.33-rc4
To: linux-wireless <linux-wireless@vger.kernel.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The compat_firmware_class was having some issues which should now be
hopefully addressed:

  * Use a different subsystem name for sysfs registration, now compat_firmware
  * The new subsystem name change required a new udev rule to be added

The new compat-wireless for 2.6.33-rc4 has been pushed out with the
new changes. Unfortunately 2.6.33-rc5 hasn't been pushed out yet so I
just overwrote the old rc4 package (next time I'll just add an extra
extra version when this happens). The new sha1sum for this release is:

c007d7c8649d6149f415ea87dc7a34d4ee808766  compat-wireless-2.6.33-rc4.tar.bz2

Just kicked out a bleeding edge release with the same fixes:

65bb3cd6565f1788a2c63bfe8ccfdd8dfc1fb368  compat-wireless-2010-01-20.tar.bz2

Please let us know if there are any issues. I should note that the new
compat_firmware_class will be used *every time* compat-wireless is
used firmware needs to be uploaded, not just for the new
request_firmware_nowait().

  Luis
