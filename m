Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Frederic Danis <frederic.danis@linux.intel.com>, Marcel Holtmann
	<marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v2 4/4] Bluetooth: hci_bcm: Add suspend/resume runtime
 PM functions
Date: Mon, 7 Sep 2015 21:32:56 +0000
Message-ID: <E0D3336E15B58B4294723AC879BA5E9429247F@IRVEXCHMB15.corp.ad.broadcom.com>
References: <1441373747-23042-1-git-send-email-frederic.danis@linux.intel.com>
 <1441373747-23042-5-git-send-email-frederic.danis@linux.intel.com>
 <CBC77539-71FB-4A84-B849-A9987BD29488@holtmann.org>
 <55EDABA9.5050207@linux.intel.com>
In-Reply-To: <55EDABA9.5050207@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@v=
ger.kernel.org] On Behalf Of Frederic Danis
Sent: Monday, September 07, 2015 11:22 AM
To: Marcel Holtmann
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 4/4] Bluetooth: hci_bcm: Add suspend/resume runtime =
PM functions

Hello Marcel,

On 04/09/2015 21:15, Marcel Holtmann wrote:
> Hi Fred,
>
>> Adds autosuspend runtime functionality to BCM UART driver.
>> Autosuspend is enabled at end of bcm_setup.
>>
>> Add a work queue to be able to perform pm_runtime commands during bcm_re=
cv
>> which is called by hci_uart_tty_receive() under spinlock.
>>
>> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
>> ---
>> drivers/bluetooth/hci_bcm.c | 111 ++++++++++++++++++++++++++++++++++++++=
++++--
>> 1 file changed, 107 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
>> index 7f63f2b..a226249 100644
>> --- a/drivers/bluetooth/hci_bcm.c
>> +++ b/drivers/bluetooth/hci_bcm.c
>> @@ -33,6 +33,7 @@
>> #include <linux/tty.h>
>> #include <linux/interrupt.h>
>> #include <linux/dmi.h>
>> +#include <linux/pm_runtime.h>
>>
>> #include <net/bluetooth/bluetooth.h>
>> #include <net/bluetooth/hci_core.h>
>> @@ -40,6 +41,8 @@
>> #include "btbcm.h"
>> #include "hci_uart.h"
>>
>> +#define BCM_AUTOSUSPEND_DELAY	5000 /* default autosleep delay */
>> +
>> struct bcm_device {
>> 	struct list_head	list;
>>
>> @@ -67,6 +70,9 @@ struct bcm_data {
>> 	struct sk_buff_head	txq;
>>
>> 	struct bcm_device	*dev;
>> +#ifdef CONFIG_PM
>> +	struct work_struct	pm_work;
>> +#endif
>> };
>>
>> /* List of BCM BT UART devices */
>> @@ -160,6 +166,10 @@ static irqreturn_t bcm_host_wake(int irq, void *dat=
a)
>>
>> 	bt_dev_dbg(bdev, "Host wake IRQ");
>>
>> +	pm_runtime_get(&bdev->pdev->dev);
>> +	pm_runtime_mark_last_busy(&bdev->pdev->dev);
>> +	pm_runtime_put_autosuspend(&bdev->pdev->dev);
>> +
>> 	return IRQ_HANDLED;
>> }
>>
>> @@ -183,6 +193,12 @@ static int bcm_request_irq(struct bcm_data *bcm)
>> 			goto unlock;
>>
>> 		device_init_wakeup(&bdev->pdev->dev, true);
>> +
>> +		pm_runtime_set_autosuspend_delay(&bdev->pdev->dev,
>> +						 BCM_AUTOSUSPEND_DELAY);
>> +		pm_runtime_use_autosuspend(&bdev->pdev->dev);
>> +		pm_runtime_set_active(&bdev->pdev->dev);
>> +		pm_runtime_enable(&bdev->pdev->dev);
>> 	}
>>
>> unlock:
>> @@ -198,7 +214,7 @@ static const struct bcm_set_sleep_mode default_sleep=
_params =3D {
>> 	.bt_wake_active =3D 1,	/* BT_WAKE active mode: 1 =3D high, 0 =3D low */
>> 	.host_wake_active =3D 0,	/* HOST_WAKE active mode: 1 =3D high, 0 =3D lo=
w */
>> 	.allow_host_sleep =3D 1,	/* Allow host sleep in SCO flag */
>> -	.combine_modes =3D 0,	/* Combine sleep and LPM flag */
>> +	.combine_modes =3D 1,	/* Combine sleep and LPM flag */
>> 	.tristate_control =3D 0,	/* Allow tri-state control of UART tx flag */
>> 	/* Irrelevant USB flags */
>> 	.usb_auto_sleep =3D 0,
>> @@ -228,9 +244,28 @@ static int bcm_setup_sleep(struct hci_uart *hu)
>>
>> 	return 0;
>> }
>> +
>> +static void bcm_pm_runtime_work(struct work_struct *work)
>> +{
>> +	struct bcm_data *bcm =3D container_of(work, struct bcm_data, pm_work);
>> +
>> +	mutex_lock(&bcm_device_lock);
>> +	if (bcm_device_exists(bcm->dev)) {
>> +		pm_runtime_get(&bcm->dev->pdev->dev);
>> +		pm_runtime_mark_last_busy(&bcm->dev->pdev->dev);
>> +		pm_runtime_put_autosuspend(&bcm->dev->pdev->dev);
>> +	}
>> +	mutex_unlock(&bcm_device_lock);
>> +}
>> +
>> +static bool bcm_schedule_work(struct bcm_data *bcm)
>> +{
>> +	return schedule_work(&bcm->pm_work);
>> +}
>> #else
>> static inline int bcm_request_irq(struct bcm_data *bcm) { return 0; }
>> static inline int bcm_setup_sleep(struct hci_uart *hu) { return 0; }
>> +static inline bool bcm_schedule_work(struct bcm_data *bcm) { return fal=
se; }
>> #endif
>>
>> static int bcm_open(struct hci_uart *hu)
>> @@ -261,6 +296,7 @@ static int bcm_open(struct hci_uart *hu)
>> 			hu->init_speed =3D dev->init_speed;
>> #ifdef CONFIG_PM
>> 			dev->hu =3D hu;
>> +			INIT_WORK(&bcm->pm_work, bcm_pm_runtime_work);
>> #endif
>> 			bcm_gpio_set_power(bcm->dev, true);
>> 			break;
>> @@ -284,6 +320,11 @@ static int bcm_close(struct hci_uart *hu)
>> 	if (bcm_device_exists(bdev)) {
>> 		bcm_gpio_set_power(bdev, false);
>> #ifdef CONFIG_PM
>> +		cancel_work_sync(&bcm->pm_work);
>> +
>> +		pm_runtime_disable(&bdev->pdev->dev);
>> +		pm_runtime_set_suspended(&bdev->pdev->dev);
>> +
>> 		if (device_can_wakeup(&bdev->pdev->dev)) {
>> 			devm_free_irq(&bdev->pdev->dev, bdev->irq, bdev);
>> 			device_init_wakeup(&bdev->pdev->dev, false);
>> @@ -393,6 +434,13 @@ static int bcm_recv(struct hci_uart *hu, const void=
 *data, int count)
>> 	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
>> 		return -EUNATCH;
>>
>> +	/* mutex_lock/unlock can not be used here as this function is called
>> +	 * from hci_uart_tty_receive under spinlock.
>> +	 * Defer pm_runtime_* calls to work queue
>> +	 */
>> +	if (bcm->dev)
>> +		bcm_schedule_work(bcm);
>> +
>> 	bcm->rx_skb =3D h4_recv_buf(hu->hdev, bcm->rx_skb, data, count,
>> 				  bcm_recv_pkts, ARRAY_SIZE(bcm_recv_pkts));
>> 	if (IS_ERR(bcm->rx_skb)) {
>> @@ -421,8 +469,27 @@ static int bcm_enqueue(struct hci_uart *hu, struct =
sk_buff *skb)
>> static struct sk_buff *bcm_dequeue(struct hci_uart *hu)
>> {
>> 	struct bcm_data *bcm =3D hu->priv;
>> +	struct sk_buff *skb =3D NULL;
>> +	struct bcm_device *bdev =3D NULL;
>> +
>> +	mutex_lock(&bcm_device_lock);
>> +
>> +	if (bcm_device_exists(bcm->dev)) {
>> +		bdev =3D bcm->dev;
>> +		pm_runtime_get_sync(&bdev->pdev->dev);
>> +		/* Shall be resumed here */
>> +	}
>> +
>> +	skb =3D skb_dequeue(&bcm->txq);
>> +
>> +	if (bdev) {
>> +		pm_runtime_mark_last_busy(&bdev->pdev->dev);
>> +		pm_runtime_put_autosuspend(&bdev->pdev->dev);
>> +	}
>>
>> -	return skb_dequeue(&bcm->txq);
>> +	mutex_unlock(&bcm_device_lock);
>> +
>> +	return skb;
>> }
>>
>> #ifdef CONFIG_PM
>> @@ -458,6 +525,34 @@ static void __bcm_resume(struct bcm_device *bdev)
>> 		hci_uart_set_flow_control(bdev->hu, false);
>> 	}
>> }
>> +
>> +static int bcm_runtime_suspend(struct device *dev)
>> +{
>> +	struct bcm_device *bdev =3D platform_get_drvdata(to_platform_device(de=
v));
>> +
>> +	bt_dev_dbg(bdev, "");
>> +
>> +	/* bcm_device_lock held is not required here as bcm_runtime_suspend
>> +	 * is only called when device is attached.
>> +	 */
>> +	__bcm_suspend(bdev);
>> +
>> +	return 0;
>> +}
>> +
>> +static int bcm_runtime_resume(struct device *dev)
>> +{
>> +	struct bcm_device *bdev =3D platform_get_drvdata(to_platform_device(de=
v));
>> +
>> +	bt_dev_dbg(bdev, "");
>> +
>> +	/* bcm_device_lock held is not required here as bcm_runtime_resume
>> +	 * is only called when device is attached.
>> +	 */
>> +	__bcm_resume(bdev);
>> +
>> +	return 0;
>> +}
>> #endif
>>
>> #ifdef CONFIG_PM_SLEEP
>> @@ -474,7 +569,8 @@ static int bcm_suspend(struct device *dev)
>> 	if (!bdev->hu)
>> 		goto unlock;
>>
>> -	__bcm_suspend(bdev);
>> +	if (pm_runtime_active(dev))
>> +		__bcm_suspend(bdev);
>>
>> 	if (device_may_wakeup(&bdev->pdev->dev)) {
>> 		error =3D enable_irq_wake(bdev->irq);
>> @@ -510,6 +606,10 @@ static int bcm_resume(struct device *dev)
>> unlock:
>> 	mutex_unlock(&bcm_device_lock);
>>
>> +	pm_runtime_disable(dev);
>> +	pm_runtime_set_active(dev);
>> +	pm_runtime_enable(dev);
>> +
>> 	return 0;
>> }
>> #endif
>> @@ -726,7 +826,10 @@ MODULE_DEVICE_TABLE(acpi, bcm_acpi_match);
>> #endif
>>
>> /* Platform suspend and resume callbacks */
>> -static SIMPLE_DEV_PM_OPS(bcm_pm_ops, bcm_suspend, bcm_resume);
>> +static const struct dev_pm_ops bcm_pm_ops =3D {
>> +	SET_SYSTEM_SLEEP_PM_OPS(bcm_suspend, bcm_resume)
>> +	SET_RUNTIME_PM_OPS(bcm_runtime_suspend, bcm_runtime_resume, NULL)
>
> I think you really need to explain why runtime suspend and system sleep i=
s actually different for Broadcom based devices. Since for the Intel ones i=
t turned out to be the same (at least for now).

I dissociate system sleep and runtime suspend functions for the=20
following reasons:

1) IRQ is enabled as a wake source only during system sleep, while this=20
is not needed for runtime suspend.

IF: The ideal implementation should suspend both the UART and the BT device=
 at runtime. UART should be suspended in a state where the device is flow-c=
ontrolled so the device is unable to send. BT device GPIO based interrupt i=
s then needed for runtime resume initiated by the device. Upon the interrup=
t, your code will resume the UART and allow the device to transmit again. I=
f you leave the UART on w/o flow-controlling the device in suspend you in f=
act don't need that interrupt . However, OEMs will not like that due to the=
 unnecessary UART power consumption. Speaking from experience. :-)

Thanks,
 -Ilya

2) runtime suspend functions do not need to protect usage of dev->hu as=20
these functions are called with a valid dev->hu (these functions are=20
disabled before dev->hu is set to NULL when BCM driver is closed).
System sleep functions need this protection as they can be called even=20
when driver is not opened, and need to ensure that dev->hu is valid=20
until GPIO and UART flow control management is performed.

Common part (GPIO and UART flow control management) for runtime suspend=20
and system sleep moved to __bcm_suspend() and __bcm_resume() in previous=20
patch.

Regards

Fred
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
