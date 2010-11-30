Return-Path: <cyrus@holtmann.org>
Date: Mon, 29 Nov 2010 23:05:55 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] Bluetooth: Fix error handling for l2cap_init()
Message-ID: <20101130010555.GA5919@vigoh>
References: <1291047350-32126-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291047350-32126-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

* Anderson Lizardo <anderson.lizardo@openbossa.org> [2010-11-29 12:15:50 -0400]:

> create_singlethread_workqueue() may fail with errors such as -ENOMEM. If
> this happens, the return value is not set to a negative value and the
> module load will succeed. It will then crash on module unload because of
> a destroy_workqueue() call on a NULL pointer.
> 
> Additionally, the _busy_wq workqueue is not being destroyed if any
> errors happen on l2cap_init().
> 
> Signed-off-by: Anderson Lizardo <anderson.lizardo@openbossa.org>

Patch has been applied, thanks a lot.

-- 
Gustavo F. Padovan
http://profusion.mobi
