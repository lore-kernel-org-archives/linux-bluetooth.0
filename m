Return-Path: <cyrus@holtmann.org>
Message-Id: <AD5919F0-1D89-4AF8-9BF2-296976BAE6AD@wizai.com>
From: Florian Schwehn <f.schwehn@wizai.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: problem with obex-data-server service requests
Date: Thu, 4 Sep 2008 23:50:09 +0200
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello!

I have a strange issue with the obex data server. I try to write a  
program that should accept files that are sent by mobile phones via opp.
When I try to send a file, some mobile phones always come up with  
messages like 'Sending failed'. hcidump produces the following output:

 > ACL data: handle 11 flags 0x02 dlen 17
     L2CAP(d): cid 0x0040 len 13 [psm 1]
         SDP SS Req: tid 0x1 len 0x8
           pat uuid-16 0x1105 (OBEXObjPush)
           max 65535
           cont 00
< ACL data: handle 11 flags 0x02 dlen 14
     L2CAP(d): cid 0x0040 len 10 [psm 1]
         SDP SS Rsp: tid 0x1 len 0x5
           count 0
           cont 00


When I try to send a file to my program from a linux PC with bluez- 
gnome everything works as exspected and hcidump prints the following  
lines:

 > ACL data: handle 12 flags 0x02 dlen 17
     L2CAP(d): cid 0x0040 len 13 [psm 1]
         SDP SS Req: tid 0x0 len 0x8
           pat uuid-16 0x1105 (OBEXObjPush)
           max 64
           cont 00
< ACL data: handle 12 flags 0x02 dlen 18
     L2CAP(d): cid 0x0040 len 14 [psm 1]
         SDP SS Rsp: tid 0x0 len 0x9
           count 1
           handle 0x10004
           cont 00

The difference between the outputs hcidump creates makes no sense to  
me. Do you have any ideas?

Thanks in advance, Florian.
