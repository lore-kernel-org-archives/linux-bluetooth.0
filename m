Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <A0BC5B7E-9D0B-449B-ADF1-3F8D97827743@holtmann.org>
References: <1424759141-17889-1-git-send-email-gmt@be-evil.net>
 <1424759141-17889-2-git-send-email-gmt@be-evil.net> <A0BC5B7E-9D0B-449B-ADF1-3F8D97827743@holtmann.org>
From: Greg Turner <gmt@be-evil.net>
Date: Sat, 14 Mar 2015 12:01:37 -0700
Message-ID: <CA+VB3NSvFzMnU1xR+1o12uaKu8O0m_SAaDF7xmfctDthpj6JJQ@mail.gmail.com>
Subject: Re: [PATCH v2(sorta) 1/2] bluetooth: Add BT_{INFO,ERR,DBG}_RATELIMITED
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Mar 2, 2015 at 5:07 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Gregory,
>
>> Add ratelimited versions of the BT_{INFO,ERR,DBG} printk macros.
>> [snip]

Oops, caught a nasty cold and forgot all about this.

Meanwhile, I've been running 3.1{8,9} stables with the v2(sorta)
patches in, where they seem to be working as advertised.

> I would prefer that you only introduce BT_ERR_RATELIMITED
> and we leave it at that. Since that is the only one we
> need anyway. And please do not re-indent the existing
> ones. Just keep them as they are.

Sure, I'll rev. & resubmit sometime soon{,-ish}.

-gmt
