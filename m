Return-Path: <cyrus@holtmann.org>
Message-ID: <55C8CA75.8010003@linux.intel.com>
Date: Mon, 10 Aug 2015 17:59:49 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/4] Bluetooth: hci_bcm: Add PM for BCM devices
References: <1438959640-15476-1-git-send-email-frederic.danis@linux.intel.com> <1438959640-15476-2-git-send-email-frederic.danis@linux.intel.com> <2033C350-6927-46D3-9ED8-570273090B5B@holtmann.org>
In-Reply-To: <2033C350-6927-46D3-9ED8-570273090B5B@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Marcel,

On 07/08/2015 18:41, Marcel Holtmann wrote:
> Hi Fred,
>
>> Retrieve "shutdown" and "device_wakeup" GPIOs from ACPI.
>> Set device off during platform device enumeration.
>> Set device on only when attached.
>>
>> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
>> ---
>> drivers/bluetooth/hci_bcm.c | 192 +++++++++++++++++++++++++++++++++++++++++++-
>> 1 file changed, 190 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
>> index 23523e1..fbe1cab 100644
>> --- a/drivers/bluetooth/hci_bcm.c
>> +++ b/drivers/bluetooth/hci_bcm.c
>> @@ -25,6 +25,12 @@
>> #include <linux/errno.h>
>> #include <linux/skbuff.h>
>> #include <linux/firmware.h>
>> +#include <linux/module.h>
>> +#include <linux/acpi.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/clk.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/tty.h>
>>
>> #include <net/bluetooth/bluetooth.h>
>> #include <net/bluetooth/hci_core.h>
>> @@ -32,11 +38,30 @@
>> #include "btbcm.h"
>> #include "hci_uart.h"
>>
>> +struct bcm_device {
>> +	struct list_head	list;
>> +
>> +	struct platform_device	*pdev;
>> +
>> +	const char		*name;
>> +	struct gpio_desc	*device_wakeup;
>> +	struct gpio_desc	*shutdown;
>> +
>> +	struct clk		*clk;
>> +	bool			clk_enabled;
>> +};
>> +
>> struct bcm_data {
>> -	struct sk_buff *rx_skb;
>> -	struct sk_buff_head txq;
>> +	struct sk_buff		*rx_skb;
>> +	struct sk_buff_head	txq;
>> +
>> +	struct bcm_device	*dev;
>> };
>>
>> +/* List of BCM BT UART devices */
>> +static DEFINE_SPINLOCK(device_list_lock);
>> +static LIST_HEAD(device_list);
>> +
>> static int bcm_set_baudrate(struct hci_uart *hu, unsigned int speed)
>> {
>> 	struct hci_dev *hdev = hu->hdev;
>> @@ -86,9 +111,26 @@ static int bcm_set_baudrate(struct hci_uart *hu, unsigned int speed)
>> 	return 0;
>> }
>>
>> +static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
>> +{
>> +	if (powered && !IS_ERR(dev->clk) && !dev->clk_enabled)
>> +		clk_enable(dev->clk);
>> +
>> +	gpiod_set_value_cansleep(dev->shutdown, powered);
>> +	gpiod_set_value_cansleep(dev->device_wakeup, powered);
>> +
>> +	if (!powered && !IS_ERR(dev->clk) && dev->clk_enabled)
>> +		clk_disable(dev->clk);
>> +
>> +	dev->clk_enabled = powered;
>> +
>> +	return 0;
>> +}
>> +
>> static int bcm_open(struct hci_uart *hu)
>> {
>> 	struct bcm_data *bcm;
>> +	struct list_head *ptr;
>
> Lets just use p here instead of ptr. We have either used p as short enumeration variable (similar to i and n) in other parts of the Bluetooth subsystem.

OK

>>
>> 	BT_DBG("hu %p", hu);
>>
>> @@ -99,6 +141,22 @@ static int bcm_open(struct hci_uart *hu)
>> 	skb_queue_head_init(&bcm->txq);
>>
>> 	hu->priv = bcm;
>> +
>> +	spin_lock(&device_list_lock);
>> +	list_for_each(ptr, &device_list) {
>> +		struct bcm_device *dev;
>> +
>> +		dev = list_entry(ptr, struct bcm_device, list);
>
> If it fits into a single line, assign struct bcm_device *dev = list_entry directly.
>
> If you only need to get a few extra characters we could even shorten it to struct bcm_dev. If we do that then obvious bcm_dev_list_lock change has to happen as well. If it fits in a single line, then leave it as is.

OK

>> +		if (hu->tty->dev->parent == dev->pdev->dev.parent) {
>
> I would add a comment above the if statement explaining what we are looking for here. Also please double check that we do not have to take any extra locks before accessing both struct device.

OK, I will add an explanation.
I do not found extra locks.

>> +			bcm->dev = dev;
>> +			break;
>> +		}
>> +	}
>> +	spin_unlock(&device_list_lock);
>> +
>> +	if (bcm->dev)
>> +		bcm_gpio_set_power(bcm->dev, true);
>> +
>
> I think yo need to protect bcm->dev with at least the list lock or a mutex. If the platform device or driver gets removed mid way, then the bcm->dev value is no longer valid.

Yes, I will check if bcm_device is still in device_list and protect it 
with device_list_lock before calling bcm_gpio_set_power.

>> 	return 0;
>> }
>>
>> @@ -108,6 +166,9 @@ static int bcm_close(struct hci_uart *hu)
>>
>> 	BT_DBG("hu %p", hu);
>>
>> +	if (bcm->dev)
>> +		bcm_gpio_set_power(bcm->dev, false);
>> +
>
> Same as above, I think we need to protect bcm->dev against removal of the device or driver.

OK

> In case this is not an issue, then I would prefer we add a comment why not. So when we ever change anything, we remember to look at this again.
>
>> 	skb_queue_purge(&bcm->txq);
>> 	kfree_skb(bcm->rx_skb);
>> 	kfree(bcm);
>> @@ -232,6 +293,111 @@ static struct sk_buff *bcm_dequeue(struct hci_uart *hu)
>> 	return skb_dequeue(&bcm->txq);
>> }
>>
>> +static const struct acpi_gpio_params device_wakeup_gpios = { 0, 0, false };
>> +static const struct acpi_gpio_params shutdown_gpios = { 1, 0, false };
>> +
>> +static const struct acpi_gpio_mapping acpi_bcm_default_gpios[] = {
>> +	{ "device-wakeup-gpios", &device_wakeup_gpios, 1 },
>> +	{ "shutdown-gpios", &shutdown_gpios, 1 },
>> +	{ },
>> +};
>> +
>> +static int bcm_acpi_probe(struct bcm_device *dev)
>> +{
>> +	struct platform_device *pdev = dev->pdev;
>> +	const struct acpi_device_id *id;
>> +	struct gpio_desc *gpio;
>> +	int ret;
>> +
>> +	id = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev->dev);
>> +	if (!id)
>> +		return -ENODEV;
>> +
>> +	/* Retrieve GPIO data */
>> +	dev->name = dev_name(&pdev->dev);
>> +	ret = acpi_dev_add_driver_gpios(ACPI_COMPANION(&pdev->dev),
>> +					acpi_bcm_default_gpios);
>> +	if (ret)
>> +		return ret;
>> +
>> +	dev->clk = devm_clk_get(&pdev->dev, NULL);
>> +
>> +	gpio = devm_gpiod_get(&pdev->dev, "device-wakeup");
>> +	if (!IS_ERR(gpio)) {
>> +		ret = gpiod_direction_output(gpio, 0);
>> +		if (ret)
>> +			return ret;
>> +		dev->device_wakeup = gpio;
>> +	}
>> +
>> +	gpio = devm_gpiod_get(&pdev->dev, "shutdown");
>> +	if (!IS_ERR(gpio)) {
>> +		ret = gpiod_direction_output(gpio, 0);
>> +		if (ret)
>> +			return ret;
>> +		dev->shutdown = gpio;
>> +	}
>> +
>> +	/* Make sure at-least one of the GPIO is defined and that
>> +	 * a name is specified for this instance
>> +	 */
>> +	if ((!dev->device_wakeup && !dev->shutdown) || !dev->name) {
>> +		dev_err(&pdev->dev, "invalid platform data\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int bcm_probe(struct platform_device *pdev)
>> +{
>> +	struct bcm_device *dev;
>> +	struct acpi_device_id *pdata = pdev->dev.platform_data;
>> +	int ret;
>> +
>> +	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
>> +	if (!dev)
>> +		return -ENOMEM;
>> +
>> +	dev->pdev = pdev;
>> +
>> +	if (ACPI_HANDLE(&pdev->dev)) {
>> +		ret = bcm_acpi_probe(dev);
>> +		if (ret)
>> +			return ret;
>> +	} else if (pdata) {
>> +		dev->name = pdata->id;
>> +	} else {
>> +		return -ENODEV;
>
> Am I assuming correctly that devm_kzalloc allocated memory gets automatically cleaned up when probe fails?

Yes, you're right

>> +	}
>> +
>> +	platform_set_drvdata(pdev, dev);
>> +
>> +	dev_info(&pdev->dev, "%s device registered.\n", dev->name);
>> +
>> +	/* Place this instance on the device list */
>> +	spin_lock(&device_list_lock);
>> +	list_add_tail(&dev->list, &device_list);
>> +	spin_unlock(&device_list_lock);
>> +
>> +	bcm_gpio_set_power(dev, false);
>> +
>> +	return 0;
>> +}
>> +
>> +static int bcm_remove(struct platform_device *pdev)
>> +{
>> +	struct bcm_device *dev = platform_get_drvdata(pdev);
>> +
>> +	spin_lock(&device_list_lock);
>> +	list_del(&dev->list);
>> +	spin_unlock(&device_list_lock);
>
> I think here we need to check to clean bcm->dev reference if one exists. Do we?
>
> Another option might be to just enforce holding a reference of the platform device when the line discipline is active. So that the device model makes sure we are not accessing invalid memory. I don't know if this is possible and valid operation, but it sounds like the right thing to do here.

I do not found a way to hold a reference of the platform device.

Regards

Fred
