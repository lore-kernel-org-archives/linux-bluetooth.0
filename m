Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Jun 2009 12:44:57 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Forrest Zhao <forrest.zhao@intel.com>
Cc: linux-bluetooth@vger.kernel.org, forrest.zhao@gmail.com
Subject: Re: [PATCH] misc fixes for HFP HF role
Message-ID: <20090630094457.GA3877@jh-x301>
References: <1246353052-26175-1-git-send-email-forrest.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1246353052-26175-1-git-send-email-forrest.zhao@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Forrest,

There were still a couple of issues:

On Tue, Jun 30, 2009, Forrest Zhao wrote:
> +		debug("connection with remote BT is closed\n");

Redundant newline character.

>  	if (cond & (G_IO_ERR | G_IO_HUP)) {
> +		debug("sco connection is released\n");
>  		GIOChannel *chan = gw->sco;

Variable declaration after code and redundant newline character.

> -	g_io_channel_close(chan);
> +	g_io_channel_shutdown(chan);

Too few parameters to g_io_channel_shutdown. Please at least compile-check
before submitting patches, even if your change is trivial.

However, I went ahead and fixed these issues myself and pushed the patch
upstream.

It seems that there were plenty of redundant newline characters in debug
logs in gateway.c (where you probably got the wrong idea to start with)
and I fixed these in a separate commit.

Johan
