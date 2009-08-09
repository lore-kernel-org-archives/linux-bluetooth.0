Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1249812358-30344-1-git-send-email-gustavo@las.ic.unicamp.br>
References: <1249812358-30344-1-git-send-email-gustavo@las.ic.unicamp.br>
Date: Sun, 9 Aug 2009 07:15:24 -0300
Message-ID: <6b53b1990908090315q1a144740ka06749541497a56c@mail.gmail.com>
Subject: Re: [PATCH 1/2] Add fcs to l2cap_options
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Aug 9, 2009 at 7:05 AM, Gustavo F.
Padovan<gustavo@las.ic.unicamp.br> wrote:
> Enable set of the FCS Option on userland. Need a kernel with support to
> FCS.
> ---
>  include/l2cap.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/include/l2cap.h b/include/l2cap.h
> index 8bede46..23a4820 100644
> --- a/include/l2cap.h
> +++ b/include/l2cap.h
> @@ -51,6 +51,7 @@ struct l2cap_options {
>        uint16_t        imtu;
>        uint16_t        flush_to;
>        uint8_t         mode;
> +       uint8_t         fcs;
>  };
>
>  #define L2CAP_CONNINFO 0x02
> --
> 1.6.3.3


These two patches can't be applied now, they need the FCS support in
kernel side. I sent them to here just for one that wanna test the
kernel side patch.


>
>



-- 
Gustavo F. Padovan
http://padovan.org
