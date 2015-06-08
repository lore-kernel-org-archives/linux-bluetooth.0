Return-Path: <cyrus@holtmann.org>
Message-ID: <55755617.8080302@intel.com>
Date: Mon, 08 Jun 2015 10:45:11 +0200
From: Loic Poulain <loic.poulain@intel.com>
MIME-Version: 1.0
To: "Ge, Ethan" <ethan.ge@intel.com>, "An, Tedd" <tedd.an@intel.com>
CC: Marcel Holtmann <marcel@holtmann.org>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCHv2] Bluetooth: btusb: Fix Intel controller hang after shutdown
References: <1432218957-3400-1-git-send-email-loic.poulain@intel.com> <69A96222-5518-4341-9F0B-32F3CEACCC35@holtmann.org> <55703D8F.6010602@intel.com> <41F028F6-E05E-4816-ACE8-3B0F121F2081@intel.com> <86D221DC0B85F94D9B05B97827669A3403CA5E7F@PGSMSX106.gar.corp.intel.com> <86D221DC0B85F94D9B05B97827669A3403CA6EA0@PGSMSX106.gar.corp.intel.com>
In-Reply-To: <86D221DC0B85F94D9B05B97827669A3403CA6EA0@PGSMSX106.gar.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ethan,

> I am helping Tedd to test this patch now, but I have a question about this patch.
>
> For your comment It looks like you want to send HCI RESET command to controller first when BT enabled, then I found below patch also do same thing as your patch. May I know any difference for your patch? Thanks.

> commit dffd30ee9619ccd7153f1861ba0436bbc4400f36
> Author: Tedd Ho-Jeong An <tedd.an@intel.com>
> Date:   Fri Apr 19 09:57:43 2013 -0700
>
>      Bluetooth: Add support for Intel Bluetooth device [8087:07dc]

setup is only called for the first open/up to initialize the device.
shutdown is called before each regular HCI close/down to perform vendor 
HCI epilog.

The Intel shutdown procedure consist in sending the 0xfc3f command which 
seems
to cause an internal reset with old firmwares (LED off with new one).
So, we need to HCI reset the controller before any other command in 
order to avoid
the "number of completed commands" issue.
To be sure that this HCI reset will be perform, I just put the HCI reset 
after the 0xfc3f
in the shutdown callback.

Since I only have old version, I can only test that the problem is fixed 
for me but not that
no regression is caused with the new fw/hw version.
So we need feedback, to know if the expected behavior (LED OFF on 
shutdown) is preserved.

Regards,
Loic

-- 
Intel Open Source Technology Center
http://oss.intel.com/
