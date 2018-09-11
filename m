Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180221192800.254383-1-jkessinger@google.com>
References: <20180221192800.254383-1-jkessinger@google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 11 Sep 2018 11:11:49 +0300
Message-ID: <CABBYNZ+zYHmLxKbsqvoRPnWCWmVD8VYY=6eUMwzWwZsOS4n0cA@mail.gmail.com>
Subject: Re: [PATCH 1/1] sbc: Fix stack overflow read in sbc_crc8.
To: Joshua Kessinger <jkessinger@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joshua,

On Wed, Feb 21, 2018 at 9:28 PM, Joshua Kessinger <jkessinger@google.com> wrote:
> When encoding or decoding with JOINT_STEREO and 8 subbands the crc_pos is 88
> bits. In this case there are no extra bits which need to be added to the CRC,
> but there is still a read 1 byte past the end of the crc_header stack variable.
>
> Signed-off-by: Joshua Kessinger <jkessinger@google.com>
> ---
>  sbc/sbc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sbc/sbc.c b/sbc/sbc.c
> index 606f11c..7f1efaa 100644
> --- a/sbc/sbc.c
> +++ b/sbc/sbc.c
> @@ -190,7 +190,7 @@ static uint8_t sbc_crc8(const uint8_t *data, size_t len)
>         for (i = 0; i < len / 8; i++)
>                 crc = crc_table[crc ^ data[i]];
>
> -       octet = data[i];
> +       octet = len % 8 ? data[i] : 0;
>         for (i = 0; i < len % 8; i++) {
>                 char bit = ((octet ^ crc) & 0x80) >> 7;
>
> --

Looks like we forgot about this one, it is now applied after removing
the signed-off-by line.

-- 
Luiz Augusto von Dentz
