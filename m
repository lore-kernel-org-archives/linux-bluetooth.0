Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Aug 2011 15:54:50 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: Re: [PATCH] Fix fd usage when not connected
Message-ID: <20110830125450.GA24860@dell>
References: <CABBYNZ+Y9g4rte=wukrHwdPwTHOJFyRGFTjKc3fxb34u8OfLTg@mail.gmail.com>
 <1314360360-1351-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314360360-1351-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Fri, Aug 26, 2011, Lucas De Marchi wrote:
> When the avctp channel is not connected, we call
> g_io_channel_unix_get_fd() with a NULL pointer. Glib does not check the
> pointer before dereferencing it, causing bluetoothd to segv.
> 
> Move the function call to the place it's actually needed, after the
> safety checks.
> ---
>  audio/control.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
