Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1448622711-17562-2-git-send-email-lukasz.rymanowski@codecoup.pl>
References: <1448622711-17562-1-git-send-email-lukasz.rymanowski@codecoup.pl>
	<1448622711-17562-2-git-send-email-lukasz.rymanowski@codecoup.pl>
Date: Thu, 3 Dec 2015 11:27:34 +0200
Message-ID: <CABBYNZKk=RZERiZfD02mtW7sZg2G+R1cOHBfT9BU8CETHJcPyw@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] unit/test-gatt: Fix long write testcases
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?UTF-8?Q?=C5=81ukasz_Rymanowski?= <lukasz.rymanowski@codecoup.pl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Fri, Nov 27, 2015 at 1:11 PM, Łukasz Rymanowski
<lukasz.rymanowski@codecoup.pl> wrote:
> Idea of long write is that each part of data is continuation
> of previous one. There shall be not gaps in the offsets between.
>
> If there are gaps in offset then we have reliable write rather than
> long write

The patch looks fine what I did not understand is what different it
makes if it is a reliable write or a long write, to me all long writes
are in fact reliable write since it does use prepare + execute, the
fact that only one handle is written doesn't change anything.

> ---
>  unit/test-gatt.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/unit/test-gatt.c b/unit/test-gatt.c
> index 326a32c..70b6de5 100644
> --- a/unit/test-gatt.c
> +++ b/unit/test-gatt.c
> @@ -3852,8 +3852,8 @@ int main(int argc, char *argv[])
>                         raw_pdu(0x17, 0x03, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff,
>                                 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
>                                 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff),
> -                       raw_pdu(0x16, 0x03, 0x00, 0x3f, 0x00, 0xff),
> -                       raw_pdu(0x17, 0x03, 0x00, 0x3f, 0x00, 0xff),
> +                       raw_pdu(0x16, 0x03, 0x00, 0x12, 0x00, 0xff),
> +                       raw_pdu(0x17, 0x03, 0x00, 0x12, 0x00, 0xff),
>                         raw_pdu(0x18, 0x01),
>                         raw_pdu(0x19));
>
> @@ -3866,8 +3866,8 @@ int main(int argc, char *argv[])
>                         raw_pdu(0x17, 0x82, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff,
>                                 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
>                                 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff),
> -                       raw_pdu(0x16, 0x82, 0x00, 0x3f, 0x00, 0xff),
> -                       raw_pdu(0x17, 0x82, 0x00, 0x3f, 0x00, 0xff),
> +                       raw_pdu(0x16, 0x82, 0x00, 0x12, 0x00, 0xff),
> +                       raw_pdu(0x17, 0x82, 0x00, 0x12, 0x00, 0xff),
>                         raw_pdu(0x18, 0x01),
>                         raw_pdu(0x19));
>
> @@ -4374,8 +4374,8 @@ int main(int argc, char *argv[])
>                         raw_pdu(0x17, 0x04, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff,
>                                 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
>                                 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff),
> -                       raw_pdu(0x16, 0x04, 0x00, 0x3f, 0x00, 0xff),
> -                       raw_pdu(0x17, 0x04, 0x00, 0x3f, 0x00, 0xff),
> +                       raw_pdu(0x16, 0x04, 0x00, 0x12, 0x00, 0xff),
> +                       raw_pdu(0x17, 0x04, 0x00, 0x12, 0x00, 0xff),
>                         raw_pdu(0x18, 0x01),
>                         raw_pdu(0x19));
>
> @@ -4388,8 +4388,8 @@ int main(int argc, char *argv[])
>                         raw_pdu(0x17, 0x83, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff,
>                                 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
>                                 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff),
> -                       raw_pdu(0x16, 0x83, 0x00, 0x3f, 0x00, 0xff),
> -                       raw_pdu(0x17, 0x83, 0x00, 0x3f, 0x00, 0xff),
> +                       raw_pdu(0x16, 0x83, 0x00, 0x12, 0x00, 0xff),
> +                       raw_pdu(0x17, 0x83, 0x00, 0x12, 0x00, 0xff),
>                         raw_pdu(0x18, 0x01),
>                         raw_pdu(0x19));
>
> --
> 2.5.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
