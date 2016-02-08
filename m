Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
From: Yunchuan Geng <yunchuan.geng@nomovok.com>
Subject: Browsing SMS on iPhone via bluez MAP
Message-ID: <56B85F6A.3050602@nomovok.com>
Date: Mon, 8 Feb 2016 11:27:06 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,


Trying to use bluez5(5.37) map implementation to browse SMS on iphone. 
But turned out it return empty message by 
org.bluez.obex.MessageAccess1.ListMessages API, although there does 
exist sms on iphone under the folder I intend to access. While I can get 
some feedback from an android phone on the same condition.

iOS implementation guide says sending SMS(uploading) is prohibited but 
it does not say anything about browsing. It is mandatory in MAP 
specification so I take it as supported by default. Am I wrong?

I suspect it is the iphone side's problem but can not confirm it because 
I do not know the detail spec of iOS regarding bluetooth. If any one 
here make success about browsing SMS on iphone? By the way, I am using 
iphone4 with 7.1.2.

Anyone could help is appreciated.

Thanks
-Yunchuan
