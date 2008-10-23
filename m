Return-Path: <cyrus@holtmann.org>
Subject: Re: Questions regarding NetLink APIs.
From: Marcel Holtmann <marcel@holtmann.org>
To: Alok <alokbarsode@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1224255091.6175.18.camel@greatbear>
References: <1224255091.6175.18.camel@greatbear>
Content-Type: text/plain
Date: Thu, 23 Oct 2008 06:48:38 +0200
Message-Id: <1224737318.9386.167.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alok,

> I had a few queries regarding the netlink APIs. I have been referring to
> net/wireless/nl80211.c for reference.
> 
> 1. Would the ioctls on raw sock(BTPROTO_HCI), be converted into netlink
> commands?
> eg HCIGETDEVLIST (NLBLUETOOTH_CMD_GET_DEVLIST),
> HCIGETDEVINFO    (NLBLUETOOTH_CMD_GET_DEV_INFO),
> HCIDEVUP         (NLBLUETOOTH_CMD_DEVUP) .. etc 

yes.

> 2. Would the netlink attributes consist of HCI Ioctl requests
> structures ? or individual structure members?
> eg:
> 
> [NLBLUETOOTH_ATTR_DEV_INFO] = {.len = sizeof(struct hci_dev_info)} 

No. We will have the parameters inside the structure as direct
attributes.

> 3. Would it be a separate kernel module? 

No. It will be within bluetooth.ko.

Regards

Marcel



