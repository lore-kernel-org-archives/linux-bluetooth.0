Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <001301cfafc0$ef11b350$cd3519f0$@samsung.com>
References: <001301cfafc0$ef11b350$cd3519f0$@samsung.com>
Date: Mon, 4 Aug 2014 13:45:08 +0300
Message-ID: <CABBYNZKfvD271JoWqCW=Lupu-22scZRAJ0D8ksG8bXfUP8gBkg@mail.gmail.com>
Subject: Re: AVCTP and AVRCP packet decoder file structure in btmon
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vikrampal <vikram.pal@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vikrampal,

We can start by reusing avctp.c to place AV/C and AVRCP decoders,
later on we can review if it is the case of splitting. Also please
note that android/Android.mk needs updating if we change anything on
the build of btmon.

On Mon, Aug 4, 2014 at 11:48 AM, Vikrampal <vikram.pal@samsung.com> wrote:
> Hi,
>
> I'm working on AVRCP packet decoder for Bluetooth monitor module.
> There's a separate file avctp.c/h for AVCTP packet decoder.
>
> The file avctp.c is not a big file as such. So, I'm thinking whether or not
> I should
> include AVRCP decoder in this file itself.
>
> Shall I create a separate file for AVRCP decoding?
>
> If both AVCTP & AVRCP go in the same file then what should be the
> appropriate name of the file or shall I create a separate file for AVRCP as
> well.
>
> Please advise me. Thanks!
>
> Regards,
> Vikram
>



-- 
Luiz Augusto von Dentz
