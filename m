Return-Path: <cyrus@holtmann.org>
Date: Sat, 30 Jun 2012 12:33:49 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH trivial 1/2] Bluetooth: bluecard_cs: Shorten scope for
 iobase
Message-ID: <20120630153349.GF1920@joana>
References: <1340971088-16059-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1340971088-16059-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1340971088-16059-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-06-29 14:58:07 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Shortening scope shall silence some warnings reported by Geert
> Uytterhoeven:
> 
> ...
> drivers/bluetooth/bluecard_cs.c: warning: unused variable 'iobase'
> 	[-Wunused-variable]
> ...
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  drivers/bluetooth/bluecard_cs.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Patch has been applied, thanks.

	Gustavo
