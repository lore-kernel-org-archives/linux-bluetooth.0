Return-Path: <cyrus@holtmann.org>
Date: Wed, 14 Oct 2015 13:56:10 -0700
From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
To: yfw <fengwei.yin@linaro.org>
CC: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan
	<gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Andy Gross
	<agross@codeaurora.org>, Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2 7/7] Bluetooth: btqcomsmd: Qualcomm WCNSS HCI driver
Message-ID: <20151014205610.GL24668@usrtlx11787.corpusers.net>
References: <1444423685-14717-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1444423685-14717-8-git-send-email-bjorn.andersson@sonymobile.com>
 <561E7067.2070007@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <561E7067.2070007@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed 14 Oct 08:10 PDT 2015, yfw wrote:

[..]
> > diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
[..]
> > +static int btqcomsmd_probe(struct qcom_smd_device *sdev)
> > +{
> > +	struct qcom_smd_channel *acl;
> > +	struct btqcomsmd *btq;
> > +	struct hci_dev *hdev;
> > +	int ret;
> > +
> > +	acl = qcom_smd_open_channel(sdev,
> > +				    "APPS_RIVA_BT_ACL",
> > +				    btqcomsmd_acl_callback);
> > +	if (IS_ERR(acl))
> > +		return PTR_ERR(acl);
> Do we need to close acl channel in following failure path and
> btqcomsmd_remove?
> 

As the life cycle of the channels implicitly follow the life cycle of
the qcom_smd_device the channel is supposed to be released by the
caller of probe upon failure.

I'll make sure this is documented in qcom_smd_open_channel()


Thanks for the review.

Regards,
Bjorn
