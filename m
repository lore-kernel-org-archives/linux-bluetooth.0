Return-Path: <cyrus@holtmann.org>
Date: Tue, 19 Jul 2011 14:19:25 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] Fix handling asynchronous plugin reads
Message-ID: <20110719111924.GA17297@dell.ger.corp.intel.com>
References: <1311072514-10572-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1311072514-10572-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Tue, Jul 19, 2011, Slawomir Bochenski wrote:
> @@ -49,6 +49,7 @@ struct obex_session {
>  	struct obex_mime_type_driver *driver;
>  	gboolean streaming;
>  	gboolean headers_sent;
> +	gboolean suspended;

There's something redundant or unintuitive about the streaming vs.
suspended variable naming. I would expect suspended to be the logical
inverse of streaming, i.e. when streaming == TRUE then suspended ==
FALSE and vice versa. So one of them shouldn't be needed. And if this is
not their meaning then they should probably be renamed more intuitively.
Btw, is any of this relevant once the migration to gobex has been done?
I think this is something important to keep in mind whenever you do any
changes due to some quirkiness of OpenOBEX.

Johan
