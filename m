Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Mar 2012 17:42:50 -0600
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/2] gobex: flush tx_queue before disconnection
Message-ID: <20120308234250.GB15265@x220.amr.corp.intel.com>
References: <1331189303-6734-1-git-send-email-jaganath.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331189303-6734-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Thu, Mar 08, 2012, Jaganath Kanakkassery wrote:
> @@ -1335,6 +1335,12 @@ void g_obex_unref(GObex *obex)
>  
>  	g_slist_free_full(obex->req_handlers, g_free);
>  
> +	do {
> +		ret = write_data(obex->io, G_IO_OUT, obex);
> +		if (obex->pending_req && obex->pending_req->cancelled)
> +			break;
> +	} while(ret);

This is not ok since we should only attempt writing to the transport if
G_IO_OUT is *really* set and not just fake it. Otherwise the call might
block which is not acceptable for the way gobex is designed (to be used
with a single async mainloop).

Johan
