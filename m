Return-Path: <chethantn@gmail.com>
MIME-Version: 1.0
References: <1534844080-31240-1-git-send-email-raghuram.hegde@intel.com>
 <CF4E3B3B-C3A4-4037-A2F1-ECB4B01FAC6D@holtmann.org> <CAMH2TCpppynorUSW7bh6Qq-y3p3q38ppSX2Hj0w851+2OtTXZA@mail.gmail.com>
 <3296D1DD-DC70-4685-BDF9-F27576C09F68@holtmann.org>
In-Reply-To: <3296D1DD-DC70-4685-BDF9-F27576C09F68@holtmann.org>
From: chethan tn <chethantn@gmail.com>
Date: Tue, 11 Sep 2018 10:15:21 +0530
Message-ID: <CAMH2TCpMoQShFcAUrsQ_yzcbM4dE1S+akPvoLgda-HfGyhfE=A@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: btintel: Add platform device for rfkill signal
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Raghuram Hegde <raghuram.hegde@intel.com>, linux-bluetooth@vger.kernel.org,
	chethan.tumkur.narayan@intel.com, sukumar.ghorai@intel.com,
	amit.k.bag@intel.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Aug 21, 2018 at 8:39 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Chethan,
>
> >>> Driver to add INTL6205 platform ACPI device to enable out
> >>> of band GPIO signalling to handle rfkill and reset the
> >>> bluetooth controller. Expose an interface in kernel to
> >>> assert GPIO signal.
> >>>
> >>> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> >>> Signed-off-by: Sukumar Ghorai <sukumar.ghorai@intel.com>
> >>> Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
> >>> ---
> >>> drivers/bluetooth/btintel.c | 68 +++++++++++++++++++++++++++++++++++++++++++++
> >>> drivers/bluetooth/btintel.h |  6 ++++
> >>> 2 files changed, 74 insertions(+)
> >>>
> >>> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> >>> index 5270d5513201..538cd6b6c524 100644
> >>> --- a/drivers/bluetooth/btintel.c
> >>> +++ b/drivers/bluetooth/btintel.c
> >>> @@ -24,6 +24,9 @@
> >>> #include <linux/module.h>
> >>> #include <linux/firmware.h>
> >>> #include <linux/regmap.h>
> >>> +#include <linux/acpi.h>
> >>> +#include <linux/platform_device.h>
> >>> +#include <linux/gpio/consumer.h>
> >>> #include <asm/unaligned.h>
> >>>
> >>> #include <net/bluetooth/bluetooth.h>
> >>> @@ -375,6 +378,71 @@ int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver)
> >>> }
> >>> EXPORT_SYMBOL_GPL(btintel_read_version);
> >>>
> >>> +static struct gpio_desc *reset_gpio_handler;
> >>
> >> this thing is so inherent broken. Please never ever do that. If there are two reset handlers or two Intel USB devices connected things will go horrible wrong.
> > Is it fine to keep list of the descriptors handlers for all the Intel
> > devices connected?
> >>
> >>> +void btintel_reset_bt(struct hci_dev *hdev, unsigned char code)
> >>> +{
> >>> +     if (!reset_gpio_handler)
> >>> +             return;
> >>> +
> >>> +     gpiod_set_value(reset_gpio_handler, 0);
> >>> +     mdelay(100);
> >>> +     gpiod_set_value(reset_gpio_handler, 1);
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(btintel_reset_bt);
> >>
> >> What happens here when you do this? Does the Bluetooth USB device disconnect from the USB bus and gets re-enumerated and the btusb_probe() routine gets called again?
> > Yes, USB re-enumeration will be done and btusb_proble() function will be called.
>
> As I said, in that case it is fine to implement this an RFKILL switch. It is platform RFKILL switch. The USB device actually gets virtually disconnected.
>
> >>
> >> If this is the case, then I have no idea how many times I have to explain. It is a platfrom reset switch and using RFKILL for this is acceptable.
> > Thought of make this platform independent by exposing ACPI object
> > "INTL6205", by doing so in case different platforms if the ACPI object
> > is exposed by the platform then this driver would be loaded.
> > Kindly please do suggest.
>
> See above. I really don't know what else to say. You can not handle this inside hci_dev since the hci_dev will be actually destroyed if you pull the GPIO.
Please note that the implementation is similar to the RF kill switch,
just that its implemented in btintel.c. Our understanding is hci_dev
does exist when GPIO toggle has to be done, only after that will be
destroyed.
Later again hci_dev would be created and the hdev->hw_reset shall be
re-assigned.
As you suggest if its not to be included in hci_dev, could you please
let us know how to invoke the GPIO toggle without registering the
callback(hdev->hw_reset).
>
> >>
> >>> +
> >>> +static const struct acpi_gpio_params reset_gpios = { 0, 0, false };
> >>> +static const struct acpi_gpio_mapping acpi_btintel_gpios[] = {
> >>> +     { "reset-gpios", &reset_gpios, 1 },
> >>> +     { },
> >>> +};
> >>> +
> >>> +static int btintel_probe(struct platform_device *pdev)
> >>> +{
> >>> +     struct device *hdev;
> >>> +
> >>> +     hdev = devm_kzalloc(&pdev->dev, sizeof(*hdev), GFP_KERNEL);
> >>> +     if (!hdev)
> >>> +             return -ENOMEM;
> >>
> >> What is this doing. This makes no sense.
> >>
> >>> +
> >>> +     if (!ACPI_HANDLE(&pdev->dev))
> >>> +             return -ENODEV;
> >>> +
> >>> +     if (acpi_dev_add_driver_gpios(ACPI_COMPANION(&pdev->dev),
> >>> +                                  acpi_btintel_gpios))
> >>> +             return -EINVAL;
> >>> +
> >>> +     reset_gpio_handler = devm_gpiod_get_optional(&pdev->dev,
> >>> +                                     "reset", GPIOD_OUT_HIGH);
> >>> +     if (IS_ERR(reset_gpio_handler))
> >>> +             return PTR_ERR(reset_gpio_handler);
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static int btintel_remove(struct platform_device *pdev)
> >>> +{
> >>> +     acpi_dev_remove_driver_gpios(ACPI_COMPANION(&pdev->dev));
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +#ifdef CONFIG_ACPI
> >>> +static const struct acpi_device_id btintel_acpi_match[] = {
> >>> +     { "INTL6205", 0 },
> >>> +     { },
> >>> +};
> >>> +MODULE_DEVICE_TABLE(acpi, btintel_acpi_match);
> >>> +#endif
> >>> +
> >>> +static struct platform_driver btintel_driver = {
> >>> +     .probe = btintel_probe,
> >>> +     .remove = btintel_remove,
> >>> +     .driver = {
> >>> +             .name = "btintel",
> >>> +             .acpi_match_table = ACPI_PTR(btintel_acpi_match),
> >>> +     },
> >>> +};
> >>> +module_platform_driver(btintel_driver);
> >>
> >> I am not convinced this actually works since now we have two module_init and module_exit functions.
> > We have tested these changes on two different platform and it is working.
>
> Then bring a second Intel Bluetooth controller into your platform and see what happens. One controller hdev->hw_reset can influence the other?
For the second intel bluetooth will not be connected to the Platform
GPIO and hence there is not influence on it. However there is chance
of the first controller to be reset.
Please do suggest how do we differentiate the Intel controller
connected to platform with the other.
>
> Regards
>
> Marcel
>
Thanks and Regards
Chethan
