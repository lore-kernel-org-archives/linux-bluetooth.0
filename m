Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: Browsing SMS on iPhone via bluez MAP
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <56B85F6A.3050602@nomovok.com>
 <CABBYNZLcXdAqk+VNbMGC1-a1uu4NwjNAFK9yHpDL823FT9N5mg@mail.gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: Yunchuan Geng <yunchuan.geng@nomovok.com>
Message-ID: <56B90069.6020405@nomovok.com>
Date: Mon, 8 Feb 2016 22:54:01 +0200
MIME-Version: 1.0
In-Reply-To: <CABBYNZLcXdAqk+VNbMGC1-a1uu4NwjNAFK9yHpDL823FT9N5mg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, Luiz

Thanks for the responding. That is also what I guess the fact should be.

According to the following mail list from app, it only successfully 
implement
notification and able to retrieve message by the handle notification 
returned,
not mentioned browsing.

http://lists.apple.com/archives/bluetooth-dev/2013/Feb/msg00016.html

And according to this document, it requires notification, prohibit 
message sending
but say nothing about browsing.

https://developer.apple.com/hardwaredrivers/BluetoothDesignGuidelines.pdf

The above is a proof to your (and also my) guess to some extent. But 
since apple will
never disclosure their technical details, neither maintain an clear bug 
report or
something like, only claim that MAP is supported for iphone4 and later. 
So have to seek
help here to see if someone has the same issue I have.

BTW, Have you tried message Notification on iphone? I think bluez does 
not support
it yet, doesn't it?


Yunchuan


On 08.02.2016 16:02, Luiz Augusto von Dentz wrote:
> Hi Yunchuan,
>
> On Mon, Feb 8, 2016 at 11:27 AM, Yunchuan Geng
> <yunchuan.geng@nomovok.com> wrote:
>> Hello,
>>
>>
>> Trying to use bluez5(5.37) map implementation to browse SMS on iphone. But
>> turned out it return empty message by
>> org.bluez.obex.MessageAccess1.ListMessages API, although there does exist
>> sms on iphone under the folder I intend to access. While I can get some
>> feedback from an android phone on the same condition.
>>
>> iOS implementation guide says sending SMS(uploading) is prohibited but it
>> does not say anything about browsing. It is mandatory in MAP specification
>> so I take it as supported by default. Am I wrong?
>>
>> I suspect it is the iphone side's problem but can not confirm it because I
>> do not know the detail spec of iOS regarding bluetooth. If any one here make
>> success about browsing SMS on iphone? By the way, I am using iphone4 with
>> 7.1.2.
>>
>> Anyone could help is appreciated.
> If I recall this correctly the only feature the iOS implements is
> notification, it has never returned any of the existing messages for
> me. Btw, even if browsing is mandatory if they do in fact return
> without any error I guess they pass the qualification since only the
> command is subject to the specification not the contents, but it is
> worth checking if the test specification don't require some item to be
> included in the response.
>

