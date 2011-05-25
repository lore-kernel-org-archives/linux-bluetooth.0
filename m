Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 May 2011 13:40:48 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Add messages backend initialization and finalization
Message-ID: <20110525204048.GC18794@dell.amr.corp.intel.com>
References: <1306159280-19889-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306159280-19889-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Mon, May 23, 2011, Slawomir Bochenski wrote:
> +	err = messages_init();
> +	if (err < 0)
> +		goto failed_messages_init;
> +
>  	err = obex_mime_type_driver_register(&mime_map);
>  	if (err < 0)
>  		goto failed_mime;
> @@ -275,6 +279,9 @@ failed_mas_reg:
>  	obex_mime_type_driver_unregister(&mime_map);
>  
>  failed_mime:
> +	messages_exit();
> +
> +failed_messages_init:
>  	return err;
>  }

In this case it'd be simpler to do the following instead of adding the
new label:

	if (err < 0)
		return err;

If there was more complex cleanup involved then the new label would make
sense, but not really with a simple return statement.

Johan
