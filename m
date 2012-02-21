Return-Path: <cyrus@holtmann.org>
Date: Tue, 21 Feb 2012 15:26:33 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv1 04/14] Bluetooth: Add locked and unlocked state_change
Message-ID: <20120221172633.GC866@joana>
References: <1329821707-11817-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1329821707-11817-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329821707-11817-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-02-21 12:54:57 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Split to locked and unlocked versions of l2cap_state_change helping
> to remove socket locks from l2cap code.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/l2cap_core.c |   41 +++++++++++++++++++++++++----------------
>  1 files changed, 25 insertions(+), 16 deletions(-)

Acked-by: Gustavo F. Padovan <padovan@profusion.mobi>

	Gustavo
