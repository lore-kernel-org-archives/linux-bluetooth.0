Return-Path: <fengguang.wu@intel.com>
Date: Wed, 30 May 2018 20:14:52 +0800
From: kbuild test robot <lkp@intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: kbuild-all@01.org, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Hans de Goede <hdegoede@redhat.com>, robh@kernel.org,
	Jeremy Cline <jeremy@jcline.org>, linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 04/13] Bluetooth: btrtl: add support for retrieving the
 UART settings
Message-ID: <201805301938.m1Ny6tn6%fengguang.wu@intel.com>
References: <20180527190457.2632-5-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180527190457.2632-5-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Martin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bluetooth/master]
[also build test WARNING on v4.17-rc7 next-20180529]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Hans-de-Goede/Bluetooth-Add-RTL8723BS-support/20180530-141115
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/bluetooth/btrtl.c:594:14: sparse: symbol 'btrtl_convert_baudrate' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
