Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Mar 2012 02:23:51 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix incorrect uninitialized assignment
Message-ID: <20120308052351.GC3998@joana>
References: <1331124705-11023-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331124705-11023-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-03-07 14:51:45 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Revert part of commit 8035ded4 which has introduced bug by
> assigning uninitialized value.
> 
> ...
> + src/net/bluetooth/rfcomm/tty.c: warning: 'p' is used uninitialized in this
> 	function:  => 218
> + src/net/bluetooth/rfcomm/tty.c: warning: 'p' may be used uninitialized in
> 	this function:  => 218
> ...
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/rfcomm/tty.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)

I saw Luiz' fix for this before and I already applied it.
Also I prefer to keep the list_for_each_entry() call.

	Gustavo
