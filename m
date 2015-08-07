Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v3 1/2] Bluetooth: btqca: Introduce generic QCA ROME
 support
To: Marcel Holtmann <marcel@holtmann.org>
References: <55C407B2.3090105@qca.qualcomm.com>
 <85898275-32E8-4A8F-BEDD-A24F258C936E@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>
From: "Kim, Ben Young Tae" <ytkim@qca.qualcomm.com>
Message-ID: <55C426D7.6060604@qca.qualcomm.com>
Date: Thu, 6 Aug 2015 20:32:39 -0700
MIME-Version: 1.0
In-Reply-To: <85898275-32E8-4A8F-BEDD-A24F258C936E@holtmann.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,


On 8/6/2015 8:05 PM, Marcel Holtmann wrote:
> Hi Ben,
>
>> This is for supporting BT for QCA ROME with specific vendor specific HCI commands and initialization. This will have USB/UART implementation both, but for now, adding UART vendor specific commands to patch downloading and set BDaddress using VS command. Signed-off-by: Ben Young Tae Kim <ytkim@qca.qualcomm.com> --- drivers/bluetooth/Kconfig | 4 + drivers/bluetooth/Makefile | 1 + drivers/bluetooth/btqca.c | 395 +++++++++++++++++++++++++++++++++++++++++++++ drivers/bluetooth/btqca.h | 136 ++++++++++++++++ 4 files changed, 536 insertions(+) create mode 100644 drivers/bluetooth/btqca.c create mode 100644 drivers/bluetooth/btqca.h diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig index 79e8234..f580334 100644 --- a/drivers/bluetooth/Kconfig +++ b/drivers/bluetooth/Kconfig @@ -13,6 +13,10 @@ config BT_RTL tristate select FW_LOADER +config BT_QCA + tristate + select FW_LOADER + config BT_HCIBTUSB tristate "HCI USB driver" depends on USB diff --git
>> a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile index f40e194..15a0d1d 100644 --- a/drivers/bluetooth/Makefile +++ b/drivers/bluetooth/Makefile @@ -22,6 +22,7 @@ obj-$(CONFIG_BT_MRVL_SDIO) += btmrvl_sdio.o obj-$(CONFIG_BT_WILINK) += btwilink.o obj-$(CONFIG_BT_BCM) += btbcm.o obj-$(CONFIG_BT_RTL) += btrtl.o +obj-$(CONFIG_BT_QCA) += btqca.o btmrvl-y := btmrvl_main.o btmrvl-$(CONFIG_DEBUG_FS) += btmrvl_debugfs.o diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c new file mode 100644 index 0000000..863cceb --- /dev/null +++ b/drivers/bluetooth/btqca.c @@ -0,0 +1,395 @@ +/* + * Bluetooth supports for Qualcomm Atheros chips + * + * Copyright
> something went really wrong here ;)

Something meshed up on my email account. You can find another one which is no issue with same subject title. Sorry for your confusion.


>
> Regards
>
> Marcel
>

Thanks

Ben Kim


