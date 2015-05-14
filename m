Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BD5E516FF3711A41B93DC005170007BB010D943FDCC9@EMBSVR01.ember.local>
References: <BD5E516FF3711A41B93DC005170007BB010D943FDCC9@EMBSVR01.ember.local>
From: John Carter <john.carter@taitradio.com>
Date: Thu, 14 May 2015 14:30:21 +1200
Message-ID: <CAFD1m3HSANSX1xMj99_tFrp2qnDqVyqQ5Gab0EsQsfk-moqvMA@mail.gmail.com>
Subject: Re: Issue with registering GATT Services
To: Ankur Patel <ankur@embertec.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> Not enough free handles to register service

I'm deeply suspicious of this error message.... I'm not sure why it
occurs, but I suspect any time a plugin / profile attempts to register
and fails to get a handle, the service fails to register.

-- 
John Carter
Phone : (64)(3) 358 6639
Tait Electronics
PO Box 1645 Christchurch
New Zealand

-- 

------------------------------
This email, including any attachments, is only for the intended recipient. 
It is subject to copyright, is confidential and may be the subject of legal 
or other privilege, none of which is waived or lost by reason of this 
transmission.
If you are not an intended recipient, you may not use, disseminate, 
distribute or reproduce such email, any attachments, or any part thereof. 
If you have received a message in error, please notify the sender 
immediately and erase all copies of the message and any attachments.
Unfortunately, we cannot warrant that the email has not been altered or 
corrupted during transmission nor can we guarantee that any email or any 
attachments are free from computer viruses or other conditions which may 
damage or interfere with recipient data, hardware or software. The 
recipient relies upon its own procedures and assumes all risk of use and of 
opening any attachments.
------------------------------
