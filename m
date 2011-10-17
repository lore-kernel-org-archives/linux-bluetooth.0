Return-Path: <cyrus@holtmann.org>
Date: Mon, 17 Oct 2011 13:01:58 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] hciops: fix adapter initialization when commands
 are missed
Message-ID: <20111017100158.GA17175@fusion.localdomain>
References: <1318844848-25379-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318844848-25379-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Oct 17, 2011, Luiz Augusto von Dentz wrote:
> Sometimes after e.g, suspend we miss some initialization commands from
> the kernel, even though we had a workaround for this it doesn't really
> work as expected since the adapter must be up in order to resend.
> 
> To fix this problem the resend logic is moved after DEVUP.
> ---
>  plugins/hciops.c |   40 ++++++++++++++++++++++++----------------
>  1 files changed, 24 insertions(+), 16 deletions(-)

Thanks, seems to work fine for me. The patch has been pushed upstream.

Johan
