Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1414074741-20286-1-git-send-email-aurelien.zanelli@parrot.com>
References: <1414074741-20286-1-git-send-email-aurelien.zanelli@parrot.com>
Date: Mon, 27 Oct 2014 12:41:11 +0200
Message-ID: <CABBYNZJP5xUn=_5h-3Ks8VmfhsXESf-dXt7MwO1wOZGN=K9dUA@mail.gmail.com>
Subject: Re: [PATCH 0/2] sbc: fix frame length in DUAL_CHANNEL mode
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?UTF-8?Q?Aur=C3=A9lien_Zanelli?= <aurelien.zanelli@parrot.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Aurélien,

On Thu, Oct 23, 2014 at 5:32 PM, Aurélien Zanelli
<aurelien.zanelli@parrot.com> wrote:
> Hi everyone,
> I was playing with sbc encoder in GStreamer, which use bluez sbc library to
> encode and I found two issues related to DUAL_CHANNEL mode in it.
>
> First the frame length calculation for DUAL_CHANNEL mode was wrong. I found
> the A2DP specification and it seems that for DUAL_CHANNEL mode, we should use
> the same formula as MONO mode to calculate the frame length. The first patch
> intend to fix this.
>
> The second patch try to fix an overflow which can occur when the frame length
> is greater than 255.
>
> Aurélien Zanelli (2):
>   sbc: fix frame length calculation for DUAL_CHANNEL mode
>   sbc: use an uint16 to store frame length in internal frame structure
>
>  sbc/sbc.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> --
> 1.7.10.4

Applied, thanks.


-- 
Luiz Augusto von Dentz
