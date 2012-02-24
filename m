Return-Path: <cyrus@holtmann.org>
Date: Fri, 24 Feb 2012 18:21:02 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix double locking in LE and conless chan
Message-ID: <20120224202102.GA28740@joana>
References: <1330094132-11762-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330094132-11762-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-02-24 16:35:32 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Remove socket lock since chan->ops->recv locks socket itself.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   24 ++++--------------------
>  1 files changed, 4 insertions(+), 20 deletions(-)

Acked-by: Gustavo F. Padovan <padovan@profusion.mobi>

	Gustavo
