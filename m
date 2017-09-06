Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v5 3/3] Bluetooth: btqcomsmd: retieve BD address from DT
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAL_JsqJhEaZkcBA6qnC3rVduQJ9Yesrz_h9i_WXo1bRaq1NT4Q@mail.gmail.com>
Date: Wed, 6 Sep 2017 09:04:30 +0200
Cc: Loic Poulain <loic.poulain@linaro.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Message-Id: <46A7D7AE-FDBB-424D-8E85-7180FEE24A14@holtmann.org>
References: <1504637923-21652-1-git-send-email-loic.poulain@linaro.org>
 <1504637923-21652-3-git-send-email-loic.poulain@linaro.org>
 <CAL_JsqJhEaZkcBA6qnC3rVduQJ9Yesrz_h9i_WXo1bRaq1NT4Q@mail.gmail.com>
To: Rob Herring <robh+dt@kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rob,

>> Retrieve BD address from the DT local-bd-address property.
>> This address must be unique and is usually added in the DT
>> by the bootloader which has access to the provisioned data.
>> 
>> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
>> ---
>> v2: Set device as unconfigured if default address detected
>>     Add warning if BD addr retrieved from DT
>> v3: if no addr retrieved from DT, unconditionally set
>>     the invalid BD addr flag.
>>     swap and set bdaddr in the platform probe
>> v4: Add dt-bindings documentation
>>     split patch in two parts (setup, dt prop)
>>     use local-bd-address name instead of local-mac-address
>> v5: remove 2/3 merged in bluetooth-next tree
>>     Add bluetooth.txt for common BT bindings
>>     expect local-bd-address in little-endian format
>> 
>> drivers/bluetooth/btqcomsmd.c | 12 ++++++++++++
>> 1 file changed, 12 insertions(+)
>> 
>> diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
>> index bd810d0..c6d3fd9 100644
>> --- a/drivers/bluetooth/btqcomsmd.c
>> +++ b/drivers/bluetooth/btqcomsmd.c
>> @@ -15,6 +15,8 @@
>> #include <linux/module.h>
>> #include <linux/slab.h>
>> #include <linux/rpmsg.h>
>> +#include <linux/of.h>
>> +
>> #include <linux/soc/qcom/wcnss_ctrl.h>
>> #include <linux/platform_device.h>
>> 
>> @@ -135,6 +137,7 @@ static int btqcomsmd_setup(struct hci_dev *hdev)
>> 
>> static int btqcomsmd_probe(struct platform_device *pdev)
>> {
>> +       const bdaddr_t *bdaddr;
>>        struct btqcomsmd *btq;
>>        struct hci_dev *hdev;
>>        void *wcnss;
>> @@ -156,6 +159,15 @@ static int btqcomsmd_probe(struct platform_device *pdev)
>>        if (IS_ERR(btq->cmd_channel))
>>                return PTR_ERR(btq->cmd_channel);
>> 
>> +       /* The local-bd-address DT property is usually injected by the
>> +        * bootloader which has access to the allocated BD address.
>> +        */
>> +       bdaddr = of_get_property(pdev->dev.of_node, "local-bd-address", &ret);
>> +       if (bdaddr && ret == sizeof(bdaddr_t)) {
>> +               BT_INFO("BD address %pMR retrieved from device-tree", bdaddr);
>> +               bacpy(&btq->bdaddr, bdaddr);
>> +       }
> 
> Can we put all this into a helper function before we get more
> instances. And use the u8 array property function. We're trying to
> make of_get_property an internal function.

using of_property_read_u8_array seems sensible since that would shorten this into

	if (!of_property_read_u8_array(pdev->dev.of_node, “local-bd-address”, &btq->bdaddr, 6))
		bt_dev_info(pdev->dev, “BD address %pMR ..”, &btq->bdaddr);

Creating a Bluetooth internal helper function seems rather pointless at this stage. If more users appears, then we might need to move this into the Bluetooth core to deal with this. However as said before, I am not a big fan of IEEE address assignment via DT since that forces to have the smarts in the boot loader and the boot loader doing the right thing. There are too many boards and DT where this will not be true. In a lot of cases it would make more sense to store the BD address as part of your file system. Since we do support this in a total generic fashion, I rather push for that method and have the QCOM SMD based SoC being the exception.

Regards

Marcel

