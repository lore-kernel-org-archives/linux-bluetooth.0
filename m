Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1334065112-14966-2-git-send-email-mikel.astiz.oss@gmail.com>
References: <1334065112-14966-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1334065112-14966-2-git-send-email-mikel.astiz.oss@gmail.com>
Date: Thu, 12 Apr 2012 13:30:04 +0300
Message-ID: <CABBYNZ+XiWkum4+WOzE=DwGk=yoL6_uLdYD3ejnA9BVcbgdUkg@mail.gmail.com>
Subject: Re: [PATCH obexd v1 01/11] client: minor buffer access api changes
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Apr 10, 2012 at 4:38 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> @@ -1169,29 +1168,18 @@ const char *obc_session_get_buffer(struct obc_session *session, size_t *size)
>                return NULL;
>        }
>
> -       buf = obc_transfer_get_buffer(transfer, size);
> -
> -       obc_transfer_clear_buffer(transfer);
> -
> -       return buf;
> +       return obc_transfer_get_buffer(transfer, size);
>  }
>

Lets just not mix unrelated things so leave clear_buffer for now,
besides I would really like to remove the memory buffering completely
and start using temporary files, so doing cosmetic changes IMO is
useless if we are not fixing real bugs.


-- 
Luiz Augusto von Dentz
