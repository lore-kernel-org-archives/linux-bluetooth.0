Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Aug 2015 20:07:35 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Nicholas Krause <xerofoify@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bluetooth:Fix locking issues in the function
 l2cap_connect_cfm
Message-ID: <20150824170735.GA25004@t440s.P-661HNU-F1>
References: <1440429299-23798-1-git-send-email-xerofoify@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1440429299-23798-1-git-send-email-xerofoify@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nicholas,

On Mon, Aug 24, 2015, Nicholas Krause wrote:
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -7285,6 +7285,7 @@ static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
>  		struct l2cap_chan *chan, *next;
>  
>  		/* Client fixed channels should override server ones */
> +		mutex_lock(&conn->chan_lock);
>  		if (__l2cap_get_chan_by_dcid(conn, pchan->scid))
>  			goto next;
>  
> @@ -7301,6 +7302,7 @@ static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
>  
>  		l2cap_chan_unlock(pchan);
>  next:
> +		mutex_lock(&conn->chan_lock);

Shouldn't this be unlock? Btw, It'd be easier to trac the revisions of
your patches if you versioned them properly, e.g. in this case with
"[PATCH v2} Bluetooth: ...".

Johan
