Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAM_iQpUHynJZBJ29qeu_fv4Rko0=7chE5BrhavOKVyzaTDf28A@mail.gmail.com>
References: <CAM_iQpUHynJZBJ29qeu_fv4Rko0=7chE5BrhavOKVyzaTDf28A@mail.gmail.com>
Date: Tue, 19 Jul 2011 15:29:38 +0800
Message-ID: <CAM_iQpXSzrLCitF364MadxkQ3G-4botpydOmZhKxfhMbT7uweQ@mail.gmail.com>
Subject: Re: [Patch] bluetooth: make 3 functions in hci_conn.c static
From: =?UTF-8?Q?Am=C3=A9rico_Wang?= <xiyou.wangcong@gmail.com>
To: Linux Kernel Network Developers <netdev@vger.kernel.org>
Cc: linux-bluetooth@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jul 19, 2011 at 3:18 PM, Am=C3=A9rico Wang <xiyou.wangcong@gmail.co=
m> wrote:
> hci_acl_connect()
> hci_add_sco()
> hci_conn_enter_sniff_mode()
>
> these three functions can become static as there are no callers outside.
>

Self-NAK.

Seems these 3 functions have no callers just accidentally.
