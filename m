Return-Path: <cyrus@holtmann.org>
Subject: Questions regarding NetLink APIs.
From: Alok <alokbarsode@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain
Date: Fri, 17 Oct 2008 20:21:31 +0530
Message-Id: <1224255091.6175.18.camel@greatbear>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel, 

I had a few queries regarding the netlink APIs. I have been referring to
net/wireless/nl80211.c for reference.

1. Would the ioctls on raw sock(BTPROTO_HCI), be converted into netlink
commands?
eg HCIGETDEVLIST (NLBLUETOOTH_CMD_GET_DEVLIST),
HCIGETDEVINFO    (NLBLUETOOTH_CMD_GET_DEV_INFO),
HCIDEVUP         (NLBLUETOOTH_CMD_DEVUP) .. etc 


2. Would the netlink attributes consist of HCI Ioctl requests
structures ? or individual structure members?
eg:

[NLBLUETOOTH_ATTR_DEV_INFO] = {.len = sizeof(struct hci_dev_info)} 


3. Would it be a separate kernel module? 

Thanks, 
Alok.

