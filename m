Return-Path: <cyrus@holtmann.org>
Message-ID: <49C10E12.3030708@gmail.com>
Date: Wed, 18 Mar 2009 18:06:58 +0300
From: Ilya Rubtsov <lusyaru@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Set Tmin and Tmax for inquiry?
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

I'm developing an application for bluecasting. So period of periodic 
inquire is important for me.
AFAIK, inquire process takes 10.24 seconds (Bluetooth 2.0). But if I use 
StartDiscovery method in python script, then I see this in hcidump:

< HCI Command: Periodic Inquiry Mode (0x01|0x0003) plen 9
   max 24 min 16 lap 0x9e8b33 len 8 num 0

and I get "Inquiry Complete" event every ~24-30 second. But if I use 
'hcitool spinq', then I see:

< HCI Command: Periodic Inquiry Mode (0x01|0x0003) plen 9
   max 24 min 16 lap 0x9e8b33 len 8 num 0

and "Inquiry Complete" event takes place every ~13-15 seconds. And in 
both cases all remote devices is being founded, so I don't see any 
reason for longer inquiring. AFAIK HCID internally sets Tmin and Tmax 
parameters, but is there any way to affect to its 'decision'?

P.S. Excuse me for my English :(
