Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: Questions related to LE Privacy 1.2 (BLE 4.2 feature)
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <023801d06071$49ce4450$dd6accf0$@samsung.com>
Date: Mon, 16 Mar 2015 22:34:45 -0700
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, bharat.panda@samsung.com
Message-Id: <9AAFF27D-D1B6-4C8D-A85B-DD93AF541257@holtmann.org>
References: <023801d06071$49ce4450$dd6accf0$@samsung.com>
To: paras kumar <paras.kumar@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Paras,

you can not use HTML based emails on this mailing list. Please use plain text only.

> I have some questions related to LE Privacy 1.2 feature. Could you please answer my below queries.
>  
> Currently set_privacy() MGMT method is used to set the HCI_PRIVACY (LE controller) flag to enable host based privacy feature locally in kernel,
> when adapter is powered off. To enable controller based privacy, first we need to check whether LL supports the LL privacy feature and bit is set or not, if so
> ·    how and when controller based privacy to be set when adapter is powered off ?
> ·    Can set_privacy() MGMT method and HCI_PRIVACY flag be reused for controller based privacy also ?
> ·    OR should we introduce new flag like HCI_CTLR_PRIVACY and new MGMT method to set and differentiate controller and host based privacy code in kernel ?

For link layer based / controller based privacy support we will use the same mgmt flag and setting. There should be no difference from an userspace point of view. The detail between controller based resolution and host based resolution should be abstract away by the kernel.

So use the existing Set Privacy management command and the existing privacy settings flag.

The RPA resolution is automatically activated as soon as you call Load Identity Resolving Keys command. Even with an empty set of keys. That is what bluetoothd actually does. It will issue that command to enable RPA resolution. And you want that enabled even if you do not use LE Privacy feature yourself.

Every time the controller is powered down, you can enable/disable LE Privacy feature. However it is required that the controller is powered down. When using btmgmt you can also test this by just programming your local IRK.

	btmgmt privacy on 6930dec38f847414e12399c1ca9ac331
	btmgmt power on

>From now on the kernel will use RPAs locally and when you pair it will also provide the IRK and identity information to the remote peers. The kernel will also rotate the RPAs after a certain amount of time.

For testing purposes the debugfs entries identity, identity_resolving_keys and rpa_timeout will provide additional information about internal states.

Regards

Marcel

