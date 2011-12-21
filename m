Return-Path: <cyrus@holtmann.org>
Date: Wed, 21 Dec 2011 02:20:20 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove global mutex hci_task_lock
Message-ID: <20111221042020.GC2729@joana>
References: <1324408251-8116-1-git-send-email-ulisses@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1324408251-8116-1-git-send-email-ulisses@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

* Ulisses Furquim <ulisses@profusion.mobi> [2011-12-20 17:10:51 -0200]:

> The hci_task_lock mutex (previously a lock) was supposed to protect the
> register/unregister of HCI protocols against RX/TX tasks. This will not
> be needed anymore because SCO and L2CAP will always be compiled.
> 
> Moreover, with the recent move of RX/TX to workqueues per device the
> global hci_task_lock was causing starvation between different HCI
> devices.
> 
> Signed-off-by: Ulisses Furquim <ulisses@profusion.mobi>
> ---
>  net/bluetooth/hci_core.c |   21 +--------------------
>  1 files changed, 1 insertions(+), 20 deletions(-)

Patch has been applied, thanks.

	Gustavo
