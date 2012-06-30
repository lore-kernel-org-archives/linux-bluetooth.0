Return-Path: <cyrus@holtmann.org>
Date: Sat, 30 Jun 2012 12:36:44 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Do not auto off AMP controller
Message-ID: <20120630153644.GG1920@joana>
References: <1340971622-16318-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1340971622-16318-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1340971622-16318-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-06-29 15:07:00 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Since AMP controller is not managed by user space do not shut it down.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_core.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

applied to bluetooth-next. Thanks.

	Gustavo
