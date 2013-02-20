Return-Path: <cyrus@holtmann.org>
Message-ID: <1361395413.1583.86.camel@aeonflux>
Subject: Re: [PATCH 08/16] Bluetooth: Improving locking in l2cap_conn_start()
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Date: Wed, 20 Feb 2013 22:23:33 +0100
In-Reply-To: <1361391103-30738-9-git-send-email-gustavo@padovan.org>
References: <1361391103-30738-1-git-send-email-gustavo@padovan.org>
	 <1361391103-30738-9-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> Since we don't read bt_sk(sk) in here anymore we can remove the lock from
> the block and only use it when calling l2cap_state_change().

you switch from __l2cap_ to l2cap_ function. You need to mention that as
well and how that all makes a difference and why it is safe.

Regards

Marcel


