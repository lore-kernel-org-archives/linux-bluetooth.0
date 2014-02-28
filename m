Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Feb 2014 18:44:59 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/6] android/socket: Reserve channel for HSP AG
Message-ID: <20140228164459.GA23792@localhost.P-661HNU-F1>
References: <1393604374-10127-1-git-send-email-szymon.janc@tieto.com>
 <1393604374-10127-4-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1393604374-10127-4-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Feb 28, 2014, Szymon Janc wrote:
> ---
>  android/socket.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/android/socket.c b/android/socket.c
> index ee98b54..f6863c8 100644
> --- a/android/socket.c
> +++ b/android/socket.c
> @@ -47,8 +47,9 @@
>  
>  #define RFCOMM_CHANNEL_MAX 30
>  
> +#define HSP_AG_DEFAULT_CHANNEL	11
>  #define OPP_DEFAULT_CHANNEL	12
> -#define HFAG_DEFAULT_CHANNEL	13
> +#define HFP_AG_DEFAULT_CHANNEL	13
>  #define PBAP_DEFAULT_CHANNEL	19

Wasn't our plan to mirror the BlueZ doc/assigned-numbers.txt here? At
least the OPP and HSP channels don't match up with that.

Johan
