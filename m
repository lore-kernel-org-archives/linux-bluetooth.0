Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1286270443.17473.62.camel@aeonflux>
References: <AANLkTimOai9_92VuJUZMo26es9Wsu_6d+z36Sv_Q4i+L@mail.gmail.com>
	<1286270443.17473.62.camel@aeonflux>
Date: Mon, 11 Oct 2010 15:00:01 +0200
Message-ID: <AANLkTinCUscmm=1t7iEAz2LQ0O_TM5-G7zANhLcuA-d9@mail.gmail.com>
Subject: Re: [PATCH 6/6] This patch adds support for using the ST-Ericsson CG2900
From: Par-Gunnar Hjalmdahl <pghatwork@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	linus.walleij@stericsson.com, Pavan Savoy <pavan_savoy@sify.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks for your comments Marcel,

Sorry for not answering to your mail earlier. I've been on a business
trip whole last week where I just did not have the possibility to
answer.

We are currently working on a new version of our driver, both the MFD
and the Bluetooth part, where we address the comments that we have so
far received. Hopefully I will able to send it later this week.

As answer to last mail: yes, we will change our debug system to be
reuse existing functionality in the Kernel.

/P-G

2010/10/5 Marcel Holtmann <marcel@holtmann.org>:
> Hi Par-Gunnar,
>
>> This patch adds support for using the ST-Ericsson CG2900
>> =A0connectivity controller as a driver for the BlueZ Bluetooth
>> =A0stack.
>> =A0This patch registers as a driver into the BlueZ framework and, when
>> =A0opened by BlueZ, it registers as user for bt_cmd, bt_acl, and bt_evt
>> =A0channels.
>>
>> Signed-off-by: Par-Gunnar Hjalmdahl <par-gunnar.p.hjalmdahl@stericsson.c=
om>
>> ---
>> =A0drivers/bluetooth/Kconfig =A0 =A0 =A0| =A0 =A07 +
>> =A0drivers/bluetooth/Makefile =A0 =A0 | =A0 =A02 +
>> =A0drivers/bluetooth/cg2900_hci.c | =A0896 +++++++++++++++++++++++++++++=
+++++++++++
>> =A03 files changed, 905 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/bluetooth/cg2900_hci.c
>>
>> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
>> index 02deef4..9ca8d69 100644
>> --- a/drivers/bluetooth/Kconfig
>> +++ b/drivers/bluetooth/Kconfig
>> @@ -219,4 +219,11 @@ config BT_ATH3K
>> =A0 =A0 =A0 =A0 Say Y here to compile support for "Atheros firmware down=
load driver"
>> =A0 =A0 =A0 =A0 into the kernel or say M to compile it as module (ath3k)=
.
>>
>> +config BT_CG2900
>> + =A0 =A0 tristate "ST-Ericsson CG2900 driver"
>> + =A0 =A0 depends on MFD_CG2900 && BT
>> + =A0 =A0 help
>> + =A0 =A0 =A0 Select if ST-Ericsson CG2900 Connectivity controller shall=
 be used as
>> + =A0 =A0 =A0 Bluetooth controller for BlueZ.
>> +
>> =A0endmenu
>> diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
>> index 71bdf13..a479c16 100644
>> --- a/drivers/bluetooth/Makefile
>> +++ b/drivers/bluetooth/Makefile
>> @@ -19,6 +19,8 @@ obj-$(CONFIG_BT_ATH3K) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D=
 ath3k.o
>> =A0obj-$(CONFIG_BT_MRVL) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D btmrvl.o
>> =A0obj-$(CONFIG_BT_MRVL_SDIO) =A0 +=3D btmrvl_sdio.o
>>
>> +obj-$(CONFIG_BT_CG2900) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D cg2900_hci.o
>> +
>
> Please sort this after ath3k and before btmvrl config.
>
> And for the name either just use cg2900 if it uniquely identifies the
> Bluetooth chip used in the combo or use btcg2900.o as module name if it
> is the name of the combo module.
>
> We clearly moved into the direction of either unique hardware names
> without bt prefix or we have the bt prefix in front of it. The fully
> generic term hci will be phased out of the driver names.
>

I can change the name to btcg2900.o since the whole chip is called
cg2900 and this file is just for the BT part of it.
I will also sort it correctly into the file.

>> =A0btmrvl-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 :=3D btmrvl_main.o
>> =A0btmrvl-$(CONFIG_DEBUG_FS) =A0 =A0+=3D btmrvl_debugfs.o
>>
>> diff --git a/drivers/bluetooth/cg2900_hci.c b/drivers/bluetooth/cg2900_h=
ci.c
>> new file mode 100644
>> index 0000000..de1ada8
>> --- /dev/null
>> +++ b/drivers/bluetooth/cg2900_hci.c
>> @@ -0,0 +1,896 @@
>> +/*
>> + * drivers/bluetooth/cg2900_hci.c
>> + *
>> + * Copyright (C) ST-Ericsson SA 2010
>> + * Authors:
>> + * Par-Gunnar Hjalmdahl (par-gunnar.p.hjalmdahl@stericsson.com) for
>> ST-Ericsson.
>> + * Henrik Possung (henrik.possung@stericsson.com) for ST-Ericsson.
>> + * Josef Kindberg (josef.kindberg@stericsson.com) for ST-Ericsson.
>> + * Dariusz Szymszak (dariusz.xd.szymczak@stericsson.com) for ST-Ericsso=
n.
>> + * Kjell Andersson (kjell.k.andersson@stericsson.com) for ST-Ericsson.
>> + * License terms: =A0GNU General Public License (GPL), version 2
>> + *
>> + * Linux Bluetooth HCI H:4 Driver for ST-Ericsson CG2900 connectivity
>> controller
>> + * towards the BlueZ Bluetooth stack.
>> + */
>
> Drop the filename in this header and don't bother with the description
> towards BlueZ or Bluetooth subsystem. That is clear from the location of
> the file.
>
> Also what is up with the "for ST-Ericsson"?
>

OK regarding the header comments. We have been instructed to use "for
ST-Ericsson" when writing author name. Is that a problem?

>> +
>> +#include <linux/module.h>
>> +#include <linux/types.h>
>> +#include <linux/skbuff.h>
>> +#include <asm/byteorder.h>
>> +#include <net/bluetooth/bluetooth.h>
>> +#include <net/bluetooth/hci.h>
>> +#include <net/bluetooth/hci_core.h>
>> +
>> +#include <linux/workqueue.h>
>> +#include <linux/wait.h>
>> +#include <linux/time.h>
>> +#include <linux/jiffies.h>
>> +#include <linux/sched.h>
>> +#include <linux/timer.h>
>> +
>> +#include <linux/mfd/cg2900.h>
>> +#include <mach/cg2900_devices.h>
>> +
>> +/* module_param declared in cg2900_core.c */
>> +extern int cg2900_debug_level;
>> +
>> +#define NAME =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "CG2900 HCI"
>> +
>> +/* Debug defines */
>> +#define CG2900_DBG_DATA(fmt, arg...) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 \
>> +do { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> + =A0 =A0 if (cg2900_debug_level >=3D 25) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG NAME " %s: " fmt "\n" , __fu=
nc__ , ## arg); \
>> +} while (0)
>> +
>> +#define CG2900_DBG(fmt, arg...) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0\
>> +do { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> + =A0 =A0 if (cg2900_debug_level >=3D 20) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG NAME " %s: " fmt "\n" , __fu=
nc__ , ## arg); \
>> +} while (0)
>> +
>> +#define CG2900_INFO(fmt, arg...) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 \
>> +do { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> + =A0 =A0 if (cg2900_debug_level >=3D 10) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO NAME ": " fmt "\n" , ## arg);=
 \
>> +} while (0)
>> +
>> +#define CG2900_ERR(fmt, arg...) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>> +do { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> + =A0 =A0 if (cg2900_debug_level >=3D 1) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR NAME " %s: " fmt "\n" , __func=
__ , ## arg); \
>> +} while (0)
>
> Remove all this debug stuff. Use BT_DBG, BT_ERR etc.

OK

>
>> +#define CG2900_SET_STATE(__name, __var, __new_state) =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 \
>> +do { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> + =A0 =A0 CG2900_DBG("New %s: 0x%X", __name, (uint32_t)__new_state); =A0=
 =A0 =A0\
>> + =A0 =A0 __var =3D __new_state; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>> +} while (0)
>
> What is this for? Please don't do that. It just obfuscates the code.
>

Is it OK to use inline functions instead of defines? It's pretty
useful to be able to printout when changing state.
So something like:

static inline void set_reset_state(enum reset_state new_state)
{
  BT_DBG("New reset state: %x", new_state);
  hci_info->reset_state =3D new_state;
}

>> +/* HCI device type */
>> +#define HCI_CG2900 =A0 =A0 =A0 =A0 =A0 HCI_VIRTUAL
>
> This is the wrong type. Don't do that. And don't create a new define for
> it. Use the standard types. I assume that HCI_UART is most likely what
> you want here.
>

The problem here is that the physical transport used is not shown for
this module. It is handled with the CG2900 MFD driver. But I guess I
could expose the type through an API function.

>> +/* Wait for 5 seconds for a response to our requests */
>> +#define RESP_TIMEOUT =A0 =A0 =A0 =A0 5000
>> +
>> +/* State-setting defines */
>> +#define SET_RESET_STATE(__hci_reset_new_state) \
>> + =A0 =A0 CG2900_SET_STATE("reset_state", hci_info->reset_state, \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__hci_reset_new_state)
>> +#define SET_ENABLE_STATE(__hci_enable_new_state) \
>> + =A0 =A0 CG2900_SET_STATE("enable_state", hci_info->enable_state, \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__hci_enable_new_state)
>
> Don't do this. It is just highly obfuscating the code flow.
>

As stated above, is it OK to use static inline functions instead?

>> +/* Bluetooth error codes */
>> +#define HCI_ERR_NO_ERROR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x00
>> +#define HCI_ERR_CMD_DISALLOWED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 0x0C
>> +
>> +/**
>> + * enum reset_state - RESET-states of the HCI driver.
>> + *
>> + * @RESET_IDLE: =A0 =A0 =A0 =A0 =A0 =A0 =A0No reset in progress.
>> + * @RESET_ACTIVATED: Reset in progress.
>> + * @RESET_UNREGISTERED: =A0 =A0 =A0hdev is unregistered.
>> + */
>> +
>> +enum reset_state {
>> + =A0 =A0 RESET_IDLE,
>> + =A0 =A0 RESET_ACTIVATED,
>> + =A0 =A0 RESET_UNREGISTERED
>> +};
>> +
>> +/**
>> + * enum enable_state - ENABLE-states of the HCI driver.
>> + *
>> + * @ENABLE_IDLE: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 The HCI driver=
 is loaded but not opened.
>> + * @ENABLE_WAITING_BT_ENABLED_CC: =A0 =A0The HCI driver is waiting for =
a command
>> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
complete event from the BT chip as a
>> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
response to a BT Enable (true) command.
>> + * @ENABLE_BT_ENABLED: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 The =
BT chip is enabled.
>> + * @ENABLE_WAITING_BT_DISABLED_CC: =A0 The HCI driver is waiting for a =
command
>> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
complete event from the BT chip as a
>> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
response to a BT Enable (false) command.
>> + * @ENABLE_BT_DISABLED: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0The =
BT chip is disabled.
>> + * @ENABLE_BT_ERROR: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 The HCI driver is =
in a bad state, some
>> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
thing has failed and is not expected to
>> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
work properly.
>> + */
>> +enum enable_state {
>> + =A0 =A0 ENABLE_IDLE,
>> + =A0 =A0 ENABLE_WAITING_BT_ENABLED_CC,
>> + =A0 =A0 ENABLE_BT_ENABLED,
>> + =A0 =A0 ENABLE_WAITING_BT_DISABLED_CC,
>> + =A0 =A0 ENABLE_BT_DISABLED,
>> + =A0 =A0 ENABLE_BT_ERROR
>> +};
>> +
>> +/**
>> + * struct hci_info - Specifies HCI driver private data.
>> + *
>> + * This type specifies CG2900 HCI driver private data.
>> + *
>> + * @bt_cmd: =A0 =A0 =A0 =A0 =A0Device structure for BT command channel.
>> + * @bt_evt: =A0 =A0 =A0 =A0 =A0Device structure for BT event channel.
>> + * @bt_acl: =A0 =A0 =A0 =A0 =A0Device structure for BT ACL channel.
>> + * @hdev: =A0 =A0 =A0 =A0 =A0 =A0Device structure for HCI device.
>> + * @reset_state: =A0 =A0 Device enum for HCI driver reset state.
>> + * @enable_state: =A0 =A0Device enum for HCI driver BT enable state.
>> + */
>> +struct hci_info {
>> + =A0 =A0 struct cg2900_device =A0 =A0*bt_cmd;
>> + =A0 =A0 struct cg2900_device =A0 =A0*bt_evt;
>> + =A0 =A0 struct cg2900_device =A0 =A0*bt_acl;
>> + =A0 =A0 struct hci_dev =A0 =A0 =A0 =A0 =A0*hdev;
>> + =A0 =A0 enum reset_state =A0 =A0 =A0 =A0reset_state;
>> + =A0 =A0 enum enable_state =A0 =A0 =A0 enable_state;
>> +};
>> +
>> +/**
>> + * struct dev_info - Specifies private data used when receiving
>> callbacks from CPD.
>> + *
>> + * @hdev: =A0 =A0 =A0 =A0 =A0 =A0Device structure for HCI device.
>> + * @hci_data_type: =A0 Type of data according to BlueZ.
>> + */
>> +struct dev_info {
>> + =A0 =A0 struct hci_dev =A0*hdev;
>> + =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0hci_data_type;
>> +};
>> +
>> +/* Variables where LSB and MSB for bt_enable command is stored */
>> +static u16 bt_enable_cmd;
>> +
>> +static struct hci_info *hci_info;
>> +
>> +/*
>> + * hci_wait_queue - Main Wait Queue in HCI driver.
>> + */
>> +static DECLARE_WAIT_QUEUE_HEAD(hci_wait_queue);
>> +
>> +/* Internal function declarations */
>> +static int register_to_bluez(void);
>
> Don't use bluez in kernel code. Just use bluetooth or bt.
>

OK

>> +/* Internal functions */
>> +
>> +/**
>> + * remove_bt_users() - Unregister and remove any existing BT users.
>> + * @info: =A0 =A0HCI driver info structure.
>> + */
>> +static void remove_bt_users(struct hci_info *info)
>> +{
>> + =A0 =A0 if (info->bt_cmd) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(info->bt_cmd->user_data);
>> + =A0 =A0 =A0 =A0 =A0 =A0 info->bt_cmd->user_data =3D NULL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 cg2900_deregister_user(info->bt_cmd);
>> + =A0 =A0 =A0 =A0 =A0 =A0 info->bt_cmd =3D NULL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (info->bt_evt) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(info->bt_evt->user_data);
>> + =A0 =A0 =A0 =A0 =A0 =A0 info->bt_evt->user_data =3D NULL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 cg2900_deregister_user(info->bt_evt);
>> + =A0 =A0 =A0 =A0 =A0 =A0 info->bt_evt =3D NULL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (info->bt_acl) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(info->bt_acl->user_data);
>> + =A0 =A0 =A0 =A0 =A0 =A0 info->bt_acl->user_data =3D NULL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 cg2900_deregister_user(info->bt_acl);
>> + =A0 =A0 =A0 =A0 =A0 =A0 info->bt_acl =3D NULL;
>> + =A0 =A0 }
>> +}
>> +
>> +/**
>> + * hci_read_cb() - Callback for handling data received from CG2900 driv=
er.
>> + * @dev: =A0 =A0 Device receiving data.
>> + * @skb: =A0 =A0 Buffer with data coming from device.
>> + */
>> +static void hci_read_cb(struct cg2900_device *dev, struct sk_buff *skb)
>> +{
>> + =A0 =A0 int err =3D 0;
>> + =A0 =A0 struct dev_info *dev_info;
>> + =A0 =A0 struct hci_event_hdr *evt;
>> + =A0 =A0 struct hci_ev_cmd_complete *cmd_complete;
>> + =A0 =A0 struct hci_ev_cmd_status *cmd_status;
>> + =A0 =A0 u8 status;
>> +
>> + =A0 =A0 if (!skb) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 CG2900_ERR("NULL supplied for skb");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (!dev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 CG2900_ERR("dev =3D=3D NULL");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto fin_free_skb;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 dev_info =3D (struct dev_info *)dev->user_data;
>> +
>> + =A0 =A0 if (!dev_info) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 CG2900_ERR("dev_info =3D=3D NULL");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto fin_free_skb;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 evt =3D (struct hci_event_hdr *)skb->data;
>> + =A0 =A0 cmd_complete =3D (struct hci_ev_cmd_complete *)(skb->data + si=
zeof(*evt));
>> + =A0 =A0 cmd_status =3D (struct hci_ev_cmd_status *)(skb->data + sizeof=
(*evt));
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Check if HCI Driver it self is expecting a Command Comple=
te packet
>> + =A0 =A0 =A0* from the chip after a BT Enable command.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if ((hci_info->enable_state =3D=3D ENABLE_WAITING_BT_ENABLED_C=
C ||
>> + =A0 =A0 =A0 =A0 =A0hci_info->enable_state =3D=3D ENABLE_WAITING_BT_DIS=
ABLED_CC) &&
>> + =A0 =A0 =A0 =A0 hci_info->bt_evt->h4_channel =3D=3D dev->h4_channel &&
>> + =A0 =A0 =A0 =A0 evt->evt =3D=3D HCI_EV_CMD_COMPLETE &&
>> + =A0 =A0 =A0 =A0 le16_to_cpu(cmd_complete->opcode) =3D=3D bt_enable_cmd=
) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* This is the command complete event for
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* the HCI_Cmd_VS_Bluetooth_Enable.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* Check result and update state.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* The BT chip is enabled/disabled. Either i=
t was enabled/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* disabled now (status NO_ERROR) or it was =
already enabled/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* disabled (assuming status CMD_DISALLOWED =
is already enabled/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* disabled).
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 status =3D *(skb->data + sizeof(*evt) + sizeof=
(*cmd_complete));
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (status !=3D HCI_ERR_NO_ERROR &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status !=3D HCI_ERR_CMD_DISALLOWED) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CG2900_ERR("Could not enable/d=
isable BT core (0x%X)",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status)=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SET_ENABLE_STATE(ENABLE_BT_ERR=
OR);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fin_free_skb;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (hci_info->enable_state =3D=3D ENABLE_WAITI=
NG_BT_ENABLED_CC) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SET_ENABLE_STATE(ENABLE_BT_ENA=
BLED);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CG2900_INFO("BT core is enable=
d");
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SET_ENABLE_STATE(ENABLE_BT_DIS=
ABLED);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CG2900_INFO("BT core is disabl=
ed");
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Wake up whom ever is waiting for this resul=
t. */
>> + =A0 =A0 =A0 =A0 =A0 =A0 wake_up_interruptible(&hci_wait_queue);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto fin_free_skb;
>> + =A0 =A0 } else if ((hci_info->enable_state =3D=3D ENABLE_WAITING_BT_DI=
SABLED_CC ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hci_info->enable_state =3D=3D ENABLE_W=
AITING_BT_ENABLED_CC) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hci_info->bt_evt->h4_channel =3D=3D dev=
->h4_channel &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0evt->evt =3D=3D HCI_EV_CMD_STATUS &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0le16_to_cpu(cmd_status->opcode) =3D=3D =
bt_enable_cmd) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* Clear the status events since the Bluez i=
s not expecting
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* them.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 CG2900_DBG("HCI Driver received Command Status=
(for "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"BT enable): 0x%X", cmd=
_status->status);
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* This is the command status event for
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* the HCI_Cmd_VS_Bluetooth_Enable.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* Just free the packet.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto fin_free_skb;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 bt_cb(skb)->pkt_type =3D dev_info->hci_data_ty=
pe;
>> + =A0 =A0 =A0 =A0 =A0 =A0 skb->dev =3D (struct net_device *)dev_info->hd=
ev;
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Update BlueZ stats */
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_info->hdev->stat.byte_rx +=3D skb->len;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (bt_cb(skb)->pkt_type =3D=3D HCI_ACLDATA_PK=
T)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info->hdev->stat.acl_rx++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info->hdev->stat.evt_rx++;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 CG2900_DBG_DATA("Data receive %d bytes", skb->=
len);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Provide BlueZ with received frame*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D hci_recv_frame(skb);
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* If err, skb have been freed in hci_recv_fra=
me() */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CG2900_ERR("Failed in supplyin=
g packet to BlueZ (%d)",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return;
>> +
>> +fin_free_skb:
>> + =A0 =A0 kfree_skb(skb);
>> +}
>> +
>> +/**
>> + * hci_reset_cb() - Callback for handling reset from CG2900 driver.
>> + * @dev: =A0 =A0 CPD device resetting.
>> + */
>> +static void hci_reset_cb(struct cg2900_device *dev)
>> +{
>> + =A0 =A0 int err;
>> + =A0 =A0 struct hci_dev *hdev;
>> + =A0 =A0 struct dev_info *dev_info;
>> + =A0 =A0 struct hci_info *info;
>> +
>> + =A0 =A0 CG2900_INFO("BluezDriver: hci_reset_cb");
>> +
>> + =A0 =A0 if (!dev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 CG2900_ERR("NULL supplied for dev");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 dev_info =3D (struct dev_info *)dev->user_data;
>> + =A0 =A0 if (!dev_info) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 CG2900_ERR("NULL supplied for dev_info");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 hdev =3D dev_info->hdev;
>> + =A0 =A0 if (!hdev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 CG2900_ERR("NULL supplied for hdev");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 info =3D (struct hci_info *)hdev->driver_data;
>> + =A0 =A0 if (!info) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 CG2900_ERR("NULL supplied for driver_data");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 switch (dev_info->hci_data_type) {
>> +
>> + =A0 =A0 case HCI_EVENT_PKT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 info->bt_evt =3D NULL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 case HCI_COMMAND_PKT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 info->bt_cmd =3D NULL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 case HCI_ACLDATA_PKT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 info->bt_acl =3D NULL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 CG2900_ERR("Unknown HCI data type:%d",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_info->hci_data_type=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 SET_RESET_STATE(RESET_ACTIVATED);
>> +
>> + =A0 =A0 /* Free userdata as device info structure will be freed by CG2=
900
>> + =A0 =A0 =A0* when this callback returns */
>> + =A0 =A0 kfree(dev->user_data);
>> + =A0 =A0 dev->user_data =3D NULL;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Continue to deregister hdev if all channels has been rese=
t else
>> + =A0 =A0 =A0* return.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (info->bt_evt || info->bt_cmd || info->bt_acl)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Deregister HCI device. Close and Destruct functions shoul=
d
>> + =A0 =A0 =A0* in turn be called by BlueZ.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 CG2900_INFO("Deregister HCI device");
>> + =A0 =A0 err =3D hci_unregister_dev(hdev);
>> + =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 CG2900_ERR("Can not deregister HCI device! (%d=
)", err);
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* Now we are in trouble. Try to register a =
new hdev
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* anyway even though this will cost some me=
mory.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> +
>> + =A0 =A0 wait_event_interruptible_timeout(hci_wait_queue,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (RESET_UNREGIS=
TERED =3D=3D hci_info->reset_state),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msecs_to_jiffi=
es(RESP_TIMEOUT));
>> + =A0 =A0 if (RESET_UNREGISTERED !=3D hci_info->reset_state)
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* Now we are in trouble. Try to register a =
new hdev
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* anyway even though this will cost some me=
mory.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 CG2900_ERR("Timeout expired. Could not deregis=
ter HCI device");
>> +
>> + =A0 =A0 /* Init and register hdev */
>> + =A0 =A0 CG2900_INFO("Register HCI device");
>> + =A0 =A0 err =3D register_to_bluez();
>> + =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 CG2900_ERR("HCI Device registration error (%d)=
.", err);
>> +}
>> +
>> +/*
>> + * struct cg2900_cb - Specifies callback structure for CG2900 user.
>> + *
>> + * @read_cb: Callback function called when data is received from
>> + * =A0 =A0 =A0 =A0 =A0 the controller.
>> + * @reset_cb: =A0 =A0 =A0 =A0Callback function called when the controll=
er has been reset.
>> + */
>> +static struct cg2900_callbacks cg2900_cb =3D {
>> + =A0 =A0 .read_cb =3D hci_read_cb,
>> + =A0 =A0 .reset_cb =3D hci_reset_cb
>> +};
>> +
>> +/**
>> + * open_from_hci() - Open HCI interface.
>> + * @hdev: =A0 =A0HCI device being opened.
>> + *
>> + * BlueZ callback function for opening HCI interface to device.
>> + *
>> + * Returns:
>> + * =A0 0 if there is no error.
>> + * =A0 -EINVAL if NULL pointer is supplied.
>> + * =A0 -EOPNOTSUPP if supplied packet type is not supported.
>> + * =A0 -EBUSY if device is already opened.
>> + * =A0 -EACCES if opening of channels failed.
>> + */
>> +static int open_from_hci(struct hci_dev *hdev)
>> +{
>> + =A0 =A0 struct hci_info *info;
>> + =A0 =A0 struct dev_info *dev_info;
>> + =A0 =A0 struct sk_buff *enable_cmd;
>> + =A0 =A0 int err;
>> +
>> + =A0 =A0 CG2900_INFO("Open ST-Ericsson connectivity HCI driver");
>> +
>> + =A0 =A0 if (!hdev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 CG2900_ERR("NULL supplied for hdev");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 info =3D (struct hci_info *)hdev->driver_data;
>> + =A0 =A0 if (!info) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 CG2900_ERR("NULL supplied for driver_data");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (test_and_set_bit(HCI_RUNNING, &(hdev->flags))) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 CG2900_ERR("Device already opened!");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (!(info->bt_cmd)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 info->bt_cmd =3D cg2900_register_user(CG2900_B=
T_CMD,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&cg2900_cb);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (info->bt_cmd) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info =3D kmalloc(sizeof(*d=
ev_info), GFP_KERNEL);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dev_info) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info->hdev=
 =3D hdev;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info->hci_=
data_type =3D HCI_COMMAND_PKT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->bt_cmd->user_data =3D de=
v_info;
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CG2900_ERR("Couldn't register =
CG2900_BT_CMD to CG2900");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EACCES;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto handle_error;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (!(info->bt_evt)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 info->bt_evt =3D cg2900_register_user(CG2900_B=
T_EVT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&cg2900_cb);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (info->bt_evt) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info =3D kmalloc(sizeof(*d=
ev_info), GFP_KERNEL);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dev_info) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info->hdev=
 =3D hdev;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info->hci_=
data_type =3D HCI_EVENT_PKT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->bt_evt->user_data =3D de=
v_info;
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CG2900_ERR("Couldn't register =
CG2900_BT_EVT to CG2900");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EACCES;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto handle_error;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (!(info->bt_acl)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 info->bt_acl =3D cg2900_register_user(CG2900_B=
T_ACL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&cg2900_cb);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (info->bt_acl) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info =3D kmalloc(sizeof(*d=
ev_info), GFP_KERNEL);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dev_info) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info->hdev=
 =3D hdev;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info->hci_=
data_type =3D HCI_ACLDATA_PKT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->bt_acl->user_data =3D de=
v_info;
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CG2900_ERR("Couldn't register =
CG2900_BT_ACL to CG2900");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EACCES;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto handle_error;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (info->reset_state =3D=3D RESET_ACTIVATED)
>> + =A0 =A0 =A0 =A0 =A0 =A0 SET_RESET_STATE(RESET_IDLE);
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Call platform specific function that returns the chip dep=
endent
>> + =A0 =A0 =A0* bt enable(true) HCI command.
>> + =A0 =A0 =A0* If NULL is returned, then no bt_enable command should be =
sent to the
>> + =A0 =A0 =A0* chip.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 enable_cmd =3D cg2900_devices_get_bt_enable_cmd(&bt_enable_cmd=
, true);
>> + =A0 =A0 if (!enable_cmd) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* The chip is enabled by default */
>> + =A0 =A0 =A0 =A0 =A0 =A0 SET_ENABLE_STATE(ENABLE_BT_ENABLED);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* Set the HCI state before sending command to chip. */
>> + =A0 =A0 SET_ENABLE_STATE(ENABLE_WAITING_BT_ENABLED_CC);
>> +
>> + =A0 =A0 /* Send command to chip */
>> + =A0 =A0 cg2900_write(info->bt_cmd, enable_cmd);
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Wait for callback to receive command complete and then wa=
ke us up
>> + =A0 =A0 =A0* again.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 wait_event_interruptible_timeout(hci_wait_queue,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (info->enable_=
state =3D=3D ENABLE_BT_ENABLED),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msecs_to_jiffi=
es(RESP_TIMEOUT));
>> + =A0 =A0 /* Check the current state to se that it worked. */
>> + =A0 =A0 if (info->enable_state !=3D ENABLE_BT_ENABLED) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 CG2900_ERR("Could not enable BT core (%d)", in=
fo->enable_state);
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EACCES;
>> + =A0 =A0 =A0 =A0 =A0 =A0 SET_ENABLE_STATE(ENABLE_BT_DISABLED);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto handle_error;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +
>> +handle_error:
>> + =A0 =A0 remove_bt_users(info);
>> + =A0 =A0 clear_bit(HCI_RUNNING, &(hdev->flags));
>> + =A0 =A0 return err;
>> +
>> +}
>> +
>> +/**
>> + * flush_from_hci() - Flush HCI interface.
>> + * @hdev: =A0 =A0HCI device being flushed.
>> + *
>> + * Returns:
>> + * =A0 0 if there is no error.
>> + * =A0 -EINVAL if NULL pointer is supplied.
>> + */
>> +static int flush_from_hci(struct hci_dev *hdev)
>> +{
>> + =A0 =A0 CG2900_INFO("flush_from_hci");
>> +
>> + =A0 =A0 if (!hdev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 CG2900_ERR("NULL supplied for hdev");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +/**
>> + * close_from_hci() - Close HCI interface.
>> + * @hdev: =A0 =A0HCI device being closed.
>> + *
>> + * BlueZ callback function for closing HCI interface.
>> + * It flushes the interface first.
>> + *
>> + * Returns:
>> + * =A0 0 if there is no error.
>> + * =A0 -EINVAL if NULL pointer is supplied.
>> + * =A0 -EOPNOTSUPP if supplied packet type is not supported.
>> + * =A0 -EBUSY if device is not opened.
>> + */
>> +static int close_from_hci(struct hci_dev *hdev)
>> +{
>> + =A0 =A0 struct hci_info *info =3D NULL;
>> + =A0 =A0 struct sk_buff *enable_cmd;
>> +
>> + =A0 =A0 CG2900_INFO("close_from_hci");
>> +
>> + =A0 =A0 if (!hdev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 CG2900_ERR("NULL supplied for hdev");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 info =3D (struct hci_info *)hdev->driver_data;
>> + =A0 =A0 if (!info) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 CG2900_ERR("NULL supplied for driver_data");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (!test_and_clear_bit(HCI_RUNNING, &(hdev->flags))) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 CG2900_ERR("Device already closed!");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 flush_from_hci(hdev);
>> +
>> + =A0 =A0 /* Do not do this if there is an reset ongoing */
>> + =A0 =A0 if (hci_info->reset_state =3D=3D RESET_ACTIVATED)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto remove_users;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Get the chip dependent BT Enable HCI command. The command=
 parameter
>> + =A0 =A0 =A0* shall be set to false to disable the BT core.
>> + =A0 =A0 =A0* If NULL is returned, then no BT Enable command should be =
sent to the
>> + =A0 =A0 =A0* chip.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 enable_cmd =3D cg2900_devices_get_bt_enable_cmd(&bt_enable_cmd=
, false);
>> + =A0 =A0 if (!enable_cmd) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* The chip is enabled by default and we sho=
uld not disable it.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 SET_ENABLE_STATE(ENABLE_BT_ENABLED);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto remove_users;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* Set the HCI state before sending command to chip */
>> + =A0 =A0 SET_ENABLE_STATE(ENABLE_WAITING_BT_DISABLED_CC);
>> +
>> + =A0 =A0 /* Send command to chip */
>> + =A0 =A0 cg2900_write(info->bt_cmd, enable_cmd);
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Wait for callback to receive command complete and then wa=
ke us up
>> + =A0 =A0 =A0* again.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 wait_event_interruptible_timeout(hci_wait_queue,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (info->enable_=
state =3D=3D ENABLE_BT_DISABLED),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msecs_to_jiffi=
es(RESP_TIMEOUT));
>> + =A0 =A0 /* Check the current state to se that it worked. */
>> + =A0 =A0 if (info->enable_state !=3D ENABLE_BT_DISABLED) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 CG2900_ERR("Could not disable BT core.");
>> + =A0 =A0 =A0 =A0 =A0 =A0 SET_ENABLE_STATE(ENABLE_BT_ENABLED);
>> + =A0 =A0 }
>> +
>> +remove_users:
>> + =A0 =A0 /* Finally deregister all users and free allocated data */
>> + =A0 =A0 remove_bt_users(info);
>> + =A0 =A0 return 0;
>> +}
>> +
>> +/**
>> + * send_from_hci() - Send packet to device.
>> + * @skb: =A0 =A0 sk buffer to be sent.
>> + *
>> + * BlueZ callback function for sending sk buffer.
>> + *
>> + * Returns:
>> + * =A0 0 if there is no error.
>> + * =A0 -EINVAL if NULL pointer is supplied.
>> + * =A0 -EOPNOTSUPP if supplied packet type is not supported.
>> + * =A0 Error codes from cg2900_write.
>> + */
>> +static int send_from_hci(struct sk_buff *skb)
>> +{
>> + =A0 =A0 struct hci_dev *hdev;
>> + =A0 =A0 struct hci_info *info;
>> + =A0 =A0 int err =3D 0;
>> +
>> + =A0 =A0 if (!skb) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 CG2900_ERR("NULL supplied for skb");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 hdev =3D (struct hci_dev *)(skb->dev);
>> + =A0 =A0 if (!hdev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 CG2900_ERR("NULL supplied for hdev");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 info =3D (struct hci_info *)hdev->driver_data;
>> + =A0 =A0 if (!info) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 CG2900_ERR("NULL supplied for info");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* Update BlueZ stats */
>> + =A0 =A0 hdev->stat.byte_tx +=3D skb->len;
>> +
>> + =A0 =A0 CG2900_DBG_DATA("Data transmit %d bytes", skb->len);
>> +
>> + =A0 =A0 switch (bt_cb(skb)->pkt_type) {
>> + =A0 =A0 case HCI_COMMAND_PKT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 CG2900_DBG("Sending HCI_COMMAND_PKT");
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D cg2900_write(info->bt_cmd, skb);
>> + =A0 =A0 =A0 =A0 =A0 =A0 hdev->stat.cmd_tx++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case HCI_ACLDATA_PKT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 CG2900_DBG("Sending HCI_ACLDATA_PKT");
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D cg2900_write(info->bt_acl, skb);
>> + =A0 =A0 =A0 =A0 =A0 =A0 hdev->stat.acl_tx++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 CG2900_ERR("Trying to transmit unsupported pac=
ket type "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"(0x%.2X)", bt_cb(skb)-=
>pkt_type);
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EOPNOTSUPP;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 };
>> +
>> + =A0 =A0 return err;
>> +}
>> +
>> +/**
>> + * destruct_from_hci() - Destruct HCI interface.
>> + * @hdev: =A0 =A0HCI device being destructed.
>> + */
>> +static void destruct_from_hci(struct hci_dev *hdev)
>> +{
>> + =A0 =A0 CG2900_INFO("destruct_from_hci");
>> +
>> + =A0 =A0 if (!hci_info)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 /* When being reset, register a new hdev when hdev is deregist=
ered */
>> + =A0 =A0 if (hci_info->reset_state =3D=3D RESET_ACTIVATED) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (hci_info->hdev)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hci_free_dev(hci_info->hdev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 SET_RESET_STATE(RESET_UNREGISTERED);
>> + =A0 =A0 }
>> +}
>
> Please name thse cg2900_destruct or btcg2900_destruct. And not from_hci.
> Follow how the other Bluetooth drivers do the naming.
>
> And the destruct callback is for freeing memory. I am also not sure how
> reset and unregister/re-register HCI is a good idea.
>

Regarding naming: no problem, we'll change that. We will see how we
solve the reset. It's a bit tricky to get it working correctly, but
we'll see what we can do. We have to be able in some way to handle if
another stack, such as GPS or FM, suddenly reset the chip.

>> +/**
>> + * notify_from_hci() - Notification from the HCI interface.
>> + * @hdev: =A0 =A0HCI device notifying.
>> + * @evt: =A0 =A0 Notification event.
>> + */
>> +static void notify_from_hci(struct hci_dev *hdev, unsigned int evt)
>> +{
>> + =A0 =A0 CG2900_INFO("notify_from_hci - evt =3D 0x%.2X", evt);
>> +}
>
> If you don't use it, then just leave it out.
>

OK

>> +/**
>> + * ioctl_from_hci() - Handle IOCTL call to the HCI interface.
>> + * @hdev: HCI device.
>> + * @cmd: =A0IOCTL command.
>> + * @arg: =A0IOCTL argument.
>> + *
>> + * Returns:
>> + * =A0 -EINVAL if NULL is supplied for hdev.
>> + * =A0 -EPERM otherwise since current driver supports no IOCTL.
>> + */
>> +static int ioctl_from_hci(struct hci_dev *hdev, unsigned int cmd,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long arg)
>> +{
>> + =A0 =A0 CG2900_INFO("ioctl_from_hci - cmd 0x%X", cmd);
>> + =A0 =A0 CG2900_DBG("DIR: %d, TYPE: %d, NR: %d, SIZE: %d",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_IOC_DIR(cmd), _IOC_TYPE(cmd), _IOC_NR(=
cmd),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_IOC_SIZE(cmd));
>> +
>> + =A0 =A0 if (!hdev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 CG2900_ERR("NULL supplied for hdev");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return -EPERM;
>> +}
>
> Since you are not using anything with the ioctl, just leave it out. The
> Bluetooth subsystem will do the right thing.
>

OK

>> +/**
>> + * register_to_bluez() - Initialize module.
>> + *
>> + * Alloc, init, and register HCI device to BlueZ.
>> + *
>> + * Returns:
>> + * =A0 0 if there is no error.
>> + * =A0 -ENOMEM if allocation fails.
>> + * =A0 Error codes from hci_register_dev.
>> + */
>> +static int register_to_bluez(void)
>> +{
>> + =A0 =A0 int err;
>> +
>> + =A0 =A0 hci_info->hdev =3D hci_alloc_dev();
>> + =A0 =A0 if (!hci_info->hdev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 CG2900_ERR("Could not allocate mem for HCI dri=
ver");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 hci_info->hdev->bus =3D HCI_CG2900;
>> + =A0 =A0 hci_info->hdev->driver_data =3D hci_info;
>> + =A0 =A0 hci_info->hdev->owner =3D THIS_MODULE;
>> + =A0 =A0 hci_info->hdev->open =3D open_from_hci;
>> + =A0 =A0 hci_info->hdev->close =3D close_from_hci;
>> + =A0 =A0 hci_info->hdev->flush =3D flush_from_hci;
>> + =A0 =A0 hci_info->hdev->send =3D send_from_hci;
>> + =A0 =A0 hci_info->hdev->destruct =3D destruct_from_hci;
>> + =A0 =A0 hci_info->hdev->notify =3D notify_from_hci;
>> + =A0 =A0 hci_info->hdev->ioctl =3D ioctl_from_hci;
>> +
>> + =A0 =A0 err =3D hci_register_dev(hci_info->hdev);
>> + =A0 =A0 if (err) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 CG2900_ERR("Can not register HCI device (%d)",=
 err);
>> + =A0 =A0 =A0 =A0 =A0 =A0 hci_free_dev(hci_info->hdev);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 SET_ENABLE_STATE(ENABLE_IDLE);
>> + =A0 =A0 SET_RESET_STATE(RESET_IDLE);
>> +
>> + =A0 =A0 return err;
>> +}
>
> So whenever the module is loaded it registers the HCI device. That is
> not really useful here. This driver needs to be able to be compiled into
> the kernel (or as module) and run on hardware that doesn't have this
> chip built in.
>

OK. We will think this through and solve it in a better way.

>> +/**
>> + * hci_init() - Initialize module.
>> + *
>> + * Allocate and initialize private data. Register to BlueZ.
>> + *
>> + * Returns:
>> + * =A0 0 if there is no error.
>> + * =A0 -ENOMEM if allocation fails.
>> + * =A0 Error codes from register_to_bluez.
>> + */
>> +static int __init hci_init(void)
>> +{
>> + =A0 =A0 int err;
>> + =A0 =A0 CG2900_INFO("hci_init");
>> +
>> + =A0 =A0 /* Initialize private data. */
>> + =A0 =A0 hci_info =3D kzalloc(sizeof(*hci_info), GFP_KERNEL);
>> + =A0 =A0 if (!hci_info) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 CG2900_ERR("Could not alloc hci_info struct.")=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* Init and register hdev */
>> + =A0 =A0 err =3D register_to_bluez();
>> + =A0 =A0 if (err) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 CG2900_ERR("HCI Device registration error (%d)=
", err);
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(hci_info);
>> + =A0 =A0 =A0 =A0 =A0 =A0 hci_info =3D NULL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +/**
>> + * hci_exit() - Remove module.
>> + *
>> + * Remove HCI device from CG2900 driver.
>> + */
>> +static void __exit hci_exit(void)
>> +{
>> + =A0 =A0 int err =3D 0;
>> +
>> + =A0 =A0 CG2900_INFO("hci_exit");
>> +
>> + =A0 =A0 if (!hci_info)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 if (!hci_info->hdev)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto finished;
>> +
>> + =A0 =A0 err =3D hci_unregister_dev(hci_info->hdev);
>> + =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 CG2900_ERR("Can not unregister HCI device (%d)=
", err);
>> + =A0 =A0 hci_free_dev(hci_info->hdev);
>> +
>> +finished:
>> + =A0 =A0 kfree(hci_info);
>> + =A0 =A0 hci_info =3D NULL;
>> +}
>> +
>> +module_init(hci_init);
>> +module_exit(hci_exit);
>
> Please use more clear names like cg2900_init or similar.
>

OK

>> +MODULE_AUTHOR("Par-Gunnar Hjalmdahl ST-Ericsson");
>> +MODULE_AUTHOR("Henrik Possung ST-Ericsson");
>> +MODULE_AUTHOR("Josef Kindberg ST-Ericsson");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_DESCRIPTION("Linux Bluetooth HCI H:4 Driver for ST-Ericsson
>> controller");
>
> Regards
>
> Marcel
>
>
>
