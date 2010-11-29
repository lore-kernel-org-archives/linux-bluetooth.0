Return-Path: <cyrus@holtmann.org>
Date: Mon, 29 Nov 2010 14:52:08 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sheldon Demario <sheldon.demario@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Emit Connect signal for LE capable devices
Message-ID: <20101129125208.GA15399@jh-x301>
References: <1290705769-15487-1-git-send-email-sheldon.demario@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290705769-15487-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sheldon,

On Thu, Nov 25, 2010, Sheldon Demario wrote:
> +	if (le) {
> +		evt_le_connection_complete *evt = ptr;
> +		evt_bdaddr = &evt->peer_bdaddr;
> +		evt_handle = evt->handle;
> +		evt_status = evt->status;
> +	}  else {
> +		evt_conn_complete *evt = ptr;
> +		evt_bdaddr = &evt->bdaddr;
> +		evt_handle = evt->handle;
> +		evt_status = evt->status;
> +
> +		if (evt->link_type != ACL_LINK)
> +			return;
> +	}

Instead of this kind of trickery, I have a feeling that the code would
be easier to read if you had a separate function for the LE connect
complete. Could try try to come up with a patch that does it like that?

Johan
