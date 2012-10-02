Return-Path: <cyrus@holtmann.org>
Message-ID: <506B3010.6060606@globaledgesoft.com>
Date: Tue, 02 Oct 2012 23:48:56 +0530
From: Ajay <ajay.kv@globaledgesoft.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: L2CAP Flush_Timeout  Error
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
     Im currently working in an A2DP stuff, where i noticed an error. 
Here i wanted to monitor the flushed packets due to timeout.

  I used the  l2test code for my testing purpose

               On client side   "l2test  -R  -S <bdadddr> "
               and i set the flush timeout as 100 (opts.flush_to = 100)

        But  later  when i print the getsockopt value of flush_to, it 
was showing some default value (65532)  harcoded at kernel side.

     so  how can i flush some packets in the sender side,  without 
enabling any retransmission  and  able to monitor the sequence number in 
the receiver side.


   --
  Thanks & regards

AJAY KV
8892753703

