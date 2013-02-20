Return-Path: <cyrus@holtmann.org>
Message-ID: <1361395687.1583.89.camel@aeonflux>
Subject: Re: [PATCH 11/16] Bluetooth: remove parent socket usage from
 l2cap_core.c
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Date: Wed, 20 Feb 2013 22:28:07 +0100
In-Reply-To: <1361391103-30738-12-git-send-email-gustavo@padovan.org>
References: <1361391103-30738-1-git-send-email-gustavo@padovan.org>
	 <1361391103-30738-12-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> Since we do not touch the parent sock in l2cap_core.c anymore we don't
> need to lock it there anymore. That lock was replaced by the
> l2cap_chan_lock and inside the new_connection() call for l2cap_sock.c the
> parent lock is locked, so the operations that uses it can be performed
> safely.
> 
> The l2cap_chan_lock give us the needed protection to handle the incoming
> connections.

and what about the newly added lock_sock(parent).

Regards

Marcel


