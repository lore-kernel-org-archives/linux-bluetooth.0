Return-Path: <cyrus@holtmann.org>
Message-ID: <50B681C7.1030207@globaledgesoft.com>
Date: Thu, 29 Nov 2012 02:57:35 +0530
From: Ajay <ajay.kv@globaledgesoft.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: BLE : SMP pairing + LE_Start_encryption
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi,
	how do i do smp pairing and ltk key distribution using l2cap socket 
connection?  does bluez provide any tools for LE pairing . my ultimate 
result should be enabling LE_start_encryption , which requires ltk key 
distribution (which is a part of LE_pairing).

	spec 4.0  says we can use l2cap cid 0x06 , defined for this purpose 
(smp pairing) . But when i used cid =0x06 , l2cap connect  creates an 
normal acl connection with cid = 40 , which doesnt trigger any smp 
modules at remote side.

	please look into this issue.
-- 
Thanks & regards

  AJAY KV
  GlobalEdge software Ltd
  8892753703
