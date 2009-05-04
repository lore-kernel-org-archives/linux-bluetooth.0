Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 May 2009 18:25:58 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: alokbarsode@gmail.com
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.com,
	Alok Barsode <alok.barsode@azingo.com>
Subject: Re: [PATCH 1/3] Do not exit if adapter_ops setup fails.
Message-ID: <20090504152558.GA28443@jh-x301>
References: <1241449694-17135-1-git-send-email-alok.barsode@azingo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1241449694-17135-1-git-send-email-alok.barsode@azingo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alok,

On Mon, May 04, 2009, alokbarsode@gmail.com wrote:
> @@ -412,10 +412,7 @@ int main(int argc, char *argv[])
>  
>  	event_loop = g_main_loop_new(NULL, FALSE);
>  
> -	if (adapter_ops_setup() < 0) {
> -		error("adapter_ops_setup failed");
> -		exit(1);
> -	}
> +	adapter_ops_setup();
>  
>  	starting = FALSE;

Do we really want this behavior? At the very least there should be a loud
error() in the case the adapter_ops_setup fails. Marcel, any opinion?

Johan
