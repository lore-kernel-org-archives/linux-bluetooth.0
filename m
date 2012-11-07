Return-Path: <cyrus@holtmann.org>
Message-ID: <509A8FD4.1080800@globaledgesoft.com>
Date: Wed, 07 Nov 2012 22:14:04 +0530
From: Ajay <ajay.kv@globaledgesoft.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: BLE issue - Reusing  Existing LE physical link
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

  Hi ,
	 I came across an issue as part of my "BLE test tool project"  . After 
the first successful connection of BLE l2cap connection (client server) 
, we just retains the physical link  without calling  le_connection 
cancel() (logical link is closed) (patch has been added).  But second 
time   i wanted to use the existing connection , without calling 
hci_le_connect() . but  here l2cap connect fails . I noticed in normal 
acl link , the same scenario is working on existing link.  so  can  we 
do the same  working on BLE link . (ubuntu 11.10  and kernel 3.2.5)
-- 
Thanks & regards

  AJAY KV
  GlobalEdge software Ltd
  8892753703
