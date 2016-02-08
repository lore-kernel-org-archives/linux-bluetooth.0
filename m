Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <56B85F6A.3050602@nomovok.com>
References: <56B85F6A.3050602@nomovok.com>
Date: Mon, 8 Feb 2016 16:02:10 +0200
Message-ID: <CABBYNZLcXdAqk+VNbMGC1-a1uu4NwjNAFK9yHpDL823FT9N5mg@mail.gmail.com>
Subject: Re: Browsing SMS on iPhone via bluez MAP
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Yunchuan Geng <yunchuan.geng@nomovok.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yunchuan,

On Mon, Feb 8, 2016 at 11:27 AM, Yunchuan Geng
<yunchuan.geng@nomovok.com> wrote:
> Hello,
>
>
> Trying to use bluez5(5.37) map implementation to browse SMS on iphone. But
> turned out it return empty message by
> org.bluez.obex.MessageAccess1.ListMessages API, although there does exist
> sms on iphone under the folder I intend to access. While I can get some
> feedback from an android phone on the same condition.
>
> iOS implementation guide says sending SMS(uploading) is prohibited but it
> does not say anything about browsing. It is mandatory in MAP specification
> so I take it as supported by default. Am I wrong?
>
> I suspect it is the iphone side's problem but can not confirm it because I
> do not know the detail spec of iOS regarding bluetooth. If any one here make
> success about browsing SMS on iphone? By the way, I am using iphone4 with
> 7.1.2.
>
> Anyone could help is appreciated.

If I recall this correctly the only feature the iOS implements is
notification, it has never returned any of the existing messages for
me. Btw, even if browsing is mandatory if they do in fact return
without any error I guess they pass the qualification since only the
command is subject to the specification not the contents, but it is
worth checking if the test specification don't require some item to be
included in the response.

-- 
Luiz Augusto von Dentz
