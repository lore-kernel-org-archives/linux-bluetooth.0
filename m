Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v7 3/3] Bluetooth: btqcomsmd: retrieve BD address from DT
 property
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1504879075-587-3-git-send-email-loic.poulain@linaro.org>
Date: Fri, 8 Sep 2017 17:31:14 +0200
Cc: Rob Herring <robh+dt@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        bjorn.andersson@linaro.org
Message-Id: <AA9FCC78-BFEC-4944-B91F-DCDE6F455DBB@holtmann.org>
References: <1504879075-587-1-git-send-email-loic.poulain@linaro.org>
 <1504879075-587-3-git-send-email-loic.poulain@linaro.org>
To: Loic Poulain <loic.poulain@linaro.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Retrieve BD address from the local-bd-address property.
> This address must be unique and is usually added in the DT
> by the bootloader which has access to the provisioned data.
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
> v2: Set device as unconfigured if default address detected
>     Add warning if BD addr retrieved from DT
> v3: if no addr retrieved from DT, unconditionally set
>     the invalid BD addr flag.
>     swap and set bdaddr in the platform probe
> v4: Add dt-bindings documentation
>     split patch in two parts (setup, dt prop)
>     use local-bd-address name instead of local-mac-address
> v5: remove 2/3 merged in bluetooth-next tree
>     Add bluetooth.txt for common BT bindings
>     expect local-bd-address in little-endian format
> v6: use of_property_read_u8_array instead of of_get_property
> v7: use dev_info instead of BT_INFO to have dev context
> 
> drivers/bluetooth/btqcomsmd.c | 11 +++++++++++
> 1 file changed, 11 insertions(+)

all 3 patches have been applied to bluetooth-next tree.

Regards

Marcel

