Return-Path: <cyrus@holtmann.org>
Message-ID: <1361395569.1583.88.camel@aeonflux>
Subject: Re: [PATCH 10/16] Bluetooth: Remove socket lock from state_change()
 in l2cap_core
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Date: Wed, 20 Feb 2013 22:26:09 +0100
In-Reply-To: <1361391103-30738-11-git-send-email-gustavo@padovan.org>
References: <1361391103-30738-1-git-send-email-gustavo@padovan.org>
	 <1361391103-30738-11-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> This simplifies a lot the state change handling inside l2cap_core.c,
> we got rid of __l2cap_state_change() and l2cap_state_change() doesn't lock
> the socket anymore, instead the socket is locked inside the ops user code
> in l2cap_sock.c.
> 
> In some places we were not using the locked version, and now we are using
> it. There is no side effect in locking the socket in these places.
> 
> Handle the operation of lock the socket to ops user benefit A2MP, since
> there is no socket lock there it doesn't need any special function in
> l2cap work without touching socket locks.

I am lost now. You are changing locking around from a to b to c. A
function previously using locking is now no longer using it. This is
confusing. Why are we doing this again.

Regards

Marcel


