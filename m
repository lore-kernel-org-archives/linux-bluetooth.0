Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v3 00/18] Rework HIDP Session Management
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1365166670-3271-1-git-send-email-dh.herrmann@gmail.com>
Date: Fri, 5 Apr 2013 12:01:54 -0700
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo@padovan.org>
Message-Id: <CD91E66B-2A36-476C-BCDD-D1536A8983B4@holtmann.org>
References: <1365166670-3271-1-git-send-email-dh.herrmann@gmail.com>
To: David Herrmann <dh.herrmann@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> This is v3 of the HIDP session management rework. Only thing that changed is
> that I moved hci_conn_user to l2cap_user as requested. The l2cap_user object is
> now bound to l2cap_conn objects instead of hci_conn. This avoids any direct HCI
> dependency in external modules.
> 
> Note that this requires l2cap_conn ref-counting. However, this is pretty easy to
> implement and does not affect existing code at all as we use direct
> synchronization.
> 
> Also note that I designed it in a way that it is independent of l2cap_sock. So
> if we succeed it making l2cap_core independent of l2cap_sock, we can move HIDP
> or other l2cap_user users over and make them independent of l2cap_sock, too.

this looks good. And using L2CAP as entry point makes this cleaner.

And triple thanks for the really great commit messages. That made it a lot easier for me to review these patches.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

