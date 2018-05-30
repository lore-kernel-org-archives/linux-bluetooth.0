Return-Path: <fengguang.wu@intel.com>
Date: Wed, 30 May 2018 20:14:52 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: kbuild-all@01.org, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Hans de Goede <hdegoede@redhat.com>, robh@kernel.org,
	Jeremy Cline <jeremy@jcline.org>, linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [RFC PATCH] Bluetooth: btrtl: btrtl_convert_baudrate() can be static
Message-ID: <20180530121452.GA8292@lkp-hsx02>
References: <20180527190457.2632-5-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180527190457.2632-5-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>


Fixes: 547b9528309e ("Bluetooth: btrtl: add support for retrieving the UART settings")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 btrtl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index bc56ef7..99b77f6 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -591,7 +591,7 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
 }
 EXPORT_SYMBOL_GPL(btrtl_setup_realtek);
 
-unsigned int btrtl_convert_baudrate(u32 device_baudrate)
+static unsigned int btrtl_convert_baudrate(u32 device_baudrate)
 {
 	switch (device_baudrate) {
 	case 0x0252a00a:
