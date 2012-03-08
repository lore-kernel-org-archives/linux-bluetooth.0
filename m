Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Mar 2012 02:20:12 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix using uninitialized variable
Message-ID: <20120308052012.GB3998@joana>
References: <1331144414-28513-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331144414-28513-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

* Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2012-03-07 20:20:14 +0200]:

> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> + src/net/bluetooth/rfcomm/tty.c: warning: 'p' is used uninitialized in this
>        function:  => 218
> + src/net/bluetooth/rfcomm/tty.c: warning: 'p' may be used uninitialized in
>        this function:  => 218
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/rfcomm/tty.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

Is this a new gcc warning? I've never saw it before.

Patch is applied, thanks.

	Gustavo
