Return-Path: <cyrus@holtmann.org>
Message-ID: <50E480C4.4060001@globaledgesoft.com>
Date: Thu, 03 Jan 2013 00:17:32 +0530
From: Ajay <ajay.kv@globaledgesoft.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: FLUSHING   ACL PACKETS
Content-Type: multipart/mixed;
 boundary="------------040801030704020304060105"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------040801030704020304060105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

  Hi ,	
	  I wanted to moniter the acl flushed packet numbers. In my L2cap 
client server code , i  did the following steps

	1. Enabled setsocket() option as BT_FLUSHABLE
	2 . set automatic flush timeout as 50msec

	On data transfer, i could see the flush occured event frequently on 
hcidump . so how do i get the number of packets flushed???

	 kindly suggest me  some solution...
-- 
Thanks & Regards

  AJAY KV
  GlobalEdge software Ltd
  8892753703

--------------040801030704020304060105
Content-Type: text/x-vcard; charset=utf-8;
 name="ajay_kv.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ajay_kv.vcf"

begin:vcard
fn:AJAY KV
n:;AJAY
tel;cell:8892753703
version:2.1
end:vcard


--------------040801030704020304060105--
