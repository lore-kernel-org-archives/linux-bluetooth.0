Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Apr 2012 13:33:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] client: Fix possible memory leak on pbap module
Message-ID: <20120423103330.GA10109@x220>
References: <1334757111-19982-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334757111-19982-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Apr 18, 2012, Luiz Augusto von Dentz wrote:
> 16 bytes in 1 blocks are definitely lost in loss record 26 of 146
>    at 0x4A075B2: realloc (vg_replace_malloc.c:525)
>    by 0x3B5104B76D: g_realloc (in /lib64/libglib-2.0.so.0.3000.2)
>    by 0x3B51064A96: ??? (in /lib64/libglib-2.0.so.0.3000.2)
>    by 0x3B51065156: g_string_insert_len (in /lib64/libglib-2.0.so.0.3000.2)
>    by 0x3B510305BC: ??? (in /lib64/libglib-2.0.so.0.3000.2)
>    by 0x3B51031BE7: g_build_filename (in /lib64/libglib-2.0.so.0.3000.2)
>    by 0x416FEE: pbap_select (pbap.c:254)
>    by 0x406CCE: process_message (object.c:224)
>    by 0x3B5301D9A0: ??? (in /lib64/libdbus-1.so.3.5.6)
>    by 0x3B5300F92F: dbus_connection_dispatch (in /lib64/libdbus-1.so.3.5.6)
> ---
>  client/pbap.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

Applied. Thanks.

Johan
