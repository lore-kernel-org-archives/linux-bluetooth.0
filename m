Return-Path: <cyrus@holtmann.org>
Date: Mon, 29 Nov 2010 16:05:26 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sheldon Demario <sheldon.demario@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Emit Connect signal for LE capable devices
Message-ID: <20101129140525.GA17558@jh-x301>
References: <1290705769-15487-1-git-send-email-sheldon.demario@openbossa.org>
 <20101129125208.GA15399@jh-x301>
 <4CF3ABD4.6080809@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4CF3ABD4.6080809@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sheldon,

On Mon, Nov 29, 2010, Sheldon Demario wrote:
> On 11/29/2010 07:52 AM, Johan Hedberg wrote:
> >Hi Sheldon,
> >
> >On Thu, Nov 25, 2010, Sheldon Demario wrote:
> >>+	if (le) {
> >>+		evt_le_connection_complete *evt = ptr;
> >>+		evt_bdaddr =&evt->peer_bdaddr;
> >>+		evt_handle = evt->handle;
> >>+		evt_status = evt->status;
> >>+	}  else {
> >>+		evt_conn_complete *evt = ptr;
> >>+		evt_bdaddr =&evt->bdaddr;
> >>+		evt_handle = evt->handle;
> >>+		evt_status = evt->status;
> >>+
> >>+		if (evt->link_type != ACL_LINK)
> >>+			return;
> >>+	}
> >Instead of this kind of trickery, I have a feeling that the code would
> >be easier to read if you had a separate function for the LE connect
> >complete. Could try try to come up with a patch that does it like that?
> 
> For sure, but don't you think that doing this way there will be a
> lot of duplicated code?

There will be more code, but not a lot (I'm guessing 10 lines or so
more). In the end readability & maintainability wins over that. It's
also possible that we'll need more special casing for the LE events
(e.g. wrt. random addresses) in the future so having it separate will
help there too.

Johan
