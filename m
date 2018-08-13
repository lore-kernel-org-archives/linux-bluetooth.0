Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Hans de Goede <hdegoede@redhat.com>,
	Jeremy Cline <jeremy@jcline.org>,
	Kees Cook <keescook@chromium.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bluetooth: hci_h5: avoid unused variable warnings
Date: Tue, 14 Aug 2018 00:04:13 +0200
Message-Id: <20180813220419.4168133-1-arnd@arndb.de>
List-ID: <linux-bluetooth.vger.kernel.org>

When CONFIG_BT_HCIUART_RTL is disabled, the hci_h5 driver produces a build
warning because of an incorrect set of #ifdef guards:

drivers/bluetooth/hci_h5.c:920:22: error: 'rtl_vnd' defined but not used [-Werror=unused-variable]

Replacing the #ifdef with an IS_ENABLED() check shuts up the error
and simplifies the logic.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/bluetooth/hci_h5.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 8eede1197cd2..b10e64ba0ff4 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -841,7 +841,6 @@ static void h5_serdev_remove(struct serdev_device *serdev)
 	hci_uart_unregister_device(&h5->serdev_hu);
 }
 
-#ifdef CONFIG_BT_HCIUART_RTL
 static int h5_btrtl_setup(struct h5 *h5)
 {
 	struct btrtl_device_info *btrtl_dev;
@@ -923,24 +922,21 @@ static struct h5_vnd rtl_vnd = {
 	.close		= h5_btrtl_close,
 	.acpi_gpio_map	= acpi_btrtl_gpios,
 };
-#endif
 
-#ifdef CONFIG_ACPI
 static const struct acpi_device_id h5_acpi_match[] = {
-#ifdef CONFIG_BT_HCIUART_RTL
 	{ "OBDA8723", (kernel_ulong_t)&rtl_vnd },
-#endif
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, h5_acpi_match);
-#endif
 
 static struct serdev_device_driver h5_serdev_driver = {
 	.probe = h5_serdev_probe,
 	.remove = h5_serdev_remove,
 	.driver = {
 		.name = "hci_uart_h5",
-		.acpi_match_table = ACPI_PTR(h5_acpi_match),
+		.acpi_match_table = (IS_ENABLED(CONFIG_BT_HCIUART_RTL) &&
+				     IS_ENABLED(CONFIG_ACPI)) ?
+					h5_acpi_match : 0,
 	},
 };
 
-- 
2.18.0
