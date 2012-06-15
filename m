Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Jun 2012 10:50:50 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Masatake YAMATO <yamato@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/8] Added /proc/net/hidp via bt_procfs_init()
Message-ID: <20120615075049.GB7205@aemeltch-MOBL1>
References: <20120615.021742.1385079555521232550.yamato@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120615.021742.1385079555521232550.yamato@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Masatake,

On Fri, Jun 15, 2012 at 02:17:42AM +0900, Masatake YAMATO wrote:
> Added /proc/net/hidp via bt_procfs_init().
> 
> Signed-off-by: Masatake YAMATO <yamato@redhat.com>
> ---
>  net/bluetooth/hidp/sock.c |   24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/hidp/sock.c b/net/bluetooth/hidp/sock.c
> index 73a32d7..dd31d8f 100644
> --- a/net/bluetooth/hidp/sock.c
> +++ b/net/bluetooth/hidp/sock.c
> @@ -39,6 +39,11 @@
>  
>  #include "hidp.h"
>  
> +

Extra space here

Best regards 
Andrei Emeltchenko 


