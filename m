Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Nov 2010 19:31:36 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@nokia.com>
Subject: Re: [PATCH 2/2] Bluetooth: Automate remote name requests
Message-ID: <20101118213136.GC3874@vigoh>
References: <1290111749-8968-1-git-send-email-johan.hedberg@gmail.com>
 <1290111749-8968-2-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290111749-8968-2-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2010-11-18 22:22:29 +0200]:

> From: Johan Hedberg <johan.hedberg@nokia.com>
> 
> In Bluetooth there are no automatic updates of remote device names when
> they get changed on the remote side. Instead, it is a good idea to do a
> manual name request when a new connection gets created (for whatever
> reason) since at this point it is very cheap (no costly baseband
> connection creation needed just for the sake of the name request).
> 
> So far userspace has been responsible for this extra name request but
> tighter control is needed in order not to flood Bluetooth controllers
> with two many commands during connection creation. It has been shown
> that some controllers simply fail to function correctly if they get too
> many (almost) simultaneous commands during connection creation. The
> simplest way to acheive better control of these commands is to move
> their sending completely to the kernel side.
> 
> This patch inserts name requests into the sequence of events that the
> kernel performs during connection creation. It does this after the
> remote features have been successfully requested and before any pending
> authentication requests are performed. The code will work sub-optimally
> with userspace versions that still do the name requesting themselves (it
> shouldn't break anything though) so it is recommended to combine this
> with a userspace software version that doesn't have automated name
> requests.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
> ---
>  net/bluetooth/hci_event.c |   72 +++++++++++++++++++++++++++++++++-----------
>  1 files changed, 54 insertions(+), 18 deletions(-)

Both patches have been applied. Thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
