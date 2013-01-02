Return-Path: <cyrus@holtmann.org>
Message-ID: <50E47E67.80602@globaledgesoft.com>
Date: Thu, 03 Jan 2013 00:07:27 +0530
From: Ajay <ajay.kv@globaledgesoft.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: BLE multiple connection - Recv()  issue
References: <50DF97FB.7080700@globaledgesoft.com>
In-Reply-To: <50DF97FB.7080700@globaledgesoft.com>
Content-Type: multipart/mixed;
 boundary="------------050805050403080509020900"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------050805050403080509020900
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




hi,
      I have  2 LE links  A1 to B and A2 to C ( A1 and A2 are client
running at same device )
when i starts sending data from B to A1  its happening  and A1 is
receiving properly . But the very next moment i started data transfer
from  C to A2 , A1 stops recievng . I could see data from B to A1
reaches upto hci layer(hcidump) , and then routed to A2 l2cap recv() .
Here i used recv()  and send() system calls for data transfer with l2cap
socket (cid 0x04 and psm 0x00) .Bind() is done at both client and server
side .  Is it possible for a BLE device to recv data simultaneously from
other two devices .????? .
-- 
Thanks & Regards

   AJAY KV
   GlobalEdge software Ltd
   8892753703




--------------050805050403080509020900
Content-Type: text/x-vcard; charset=utf-8;
 name="ajay_kv.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="ajay_kv.vcf"

YmVnaW46dmNhcmQNCmZuOkFKQVkgS1YNCm46O0FKQVkNCnRlbDtjZWxsOjg4OTI3NTM3MDMN
CnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------050805050403080509020900--
