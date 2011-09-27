Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Sep 2011 12:47:41 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] client: fix possible crash on GetFile
Message-ID: <20110927094741.GL3952@dell>
References: <1315901476-31728-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1315901476-31728-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Sep 13, 2011, Luiz Augusto von Dentz wrote:
> Invalid read of size 8
>    at 0x413DA1: get_file_callback (ftp.c:184)
>    by 0x40A74E: transfer_complete (gobex-transfer.c:73)
>    by 0x40AB91: transfer_response (gobex-transfer.c:172)
>    by 0x40847A: handle_response (gobex.c:629)
>    by 0x408C06: incoming_data (gobex.c:811)
>    by 0x3E01043DBC: g_main_context_dispatch (in /lib64/libglib-2.0.so.0.2910.0)
>    by 0x3E010445A7: ??? (in /lib64/libglib-2.0.so.0.2910.0)
>    by 0x3E01044AF4: g_main_loop_run (in /lib64/libglib-2.0.so.0.2910.0)
>    by 0x404CD4: main (main.c:102)
>  Address 0x8 is not stack'd, malloc'd or (recently) free'd
> ---
>  client/ftp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
