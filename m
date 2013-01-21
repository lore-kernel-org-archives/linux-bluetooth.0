Return-Path: <cyrus@holtmann.org>
Message-ID: <50FDAD79.8040700@globaledgesoft.com>
Date: Tue, 22 Jan 2013 02:34:57 +0530
From: Ajay <ajay.kv@globaledgesoft.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Simultaneous data transfer on  ACL and BLE  links
Content-Type: multipart/mixed;
 boundary="------------060001040309060305040702"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------060001040309060305040702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi ,
     Kernel has set some  restrictions in simultaneous  L2cap data 
transfer on BLE and ACL links on a common device .

      My test scenario is as follows
             Device A  has both LE and ACL link with  device B and C 
respectively . when i start  sending l2cap data on  ACL link (A to B), 
it work fine . But when i starts sending BLE data along with ACL  data 
(A to C )  , it fails  with  error "send failed : interrupt system call" 
. when i count the  LE packets that had reached upto hci layer , it  
shows some 367 packets.
              Later i noticed that LE data is getting queued at hci 
layer  and it is  not  scheduled properly . following piece of code 
tells us the order of scheduling.. (hci_core.c)


static void hci_tx_task(unsigned long arg)
{
     struct hci_dev *hdev = (struct hci_dev *) arg;
     struct sk_buff *skb;

     read_lock(&hci_task_lock);

     BT_DBG("%s acl %d sco %d le %d", hdev->name, hdev->acl_cnt,
         hdev->sco_cnt, hdev->le_cnt);

     /* Schedule queues and send stuff to HCI driver */

     hci_sched_acl(hdev);

     hci_sched_sco(hdev);

     hci_sched_esco(hdev);

     hci_sched_le(hdev);

......


     Here  both   acl and le scheduling  are using same count  as 
reference  (hdev->acl_cnt)  and they have never make use of hdev->le_cnt.

    please kindly go through this issue.








-- 
Thanks & Regards

  AJAY KV
  GlobalEdge software Ltd
  8892753703


--------------060001040309060305040702
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


--------------060001040309060305040702--
