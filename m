Return-Path: <cyrus@holtmann.org>
Date: Fri, 2 Dec 2011 20:59:10 +0900
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove magic numbers from le scan cmd
Message-ID: <20111202115910.GE2570@joana>
References: <1322662630-32759-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1322662630-32759-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-11-30 16:17:10 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Make code readable by removing magic numbers.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/hci.h |    3 +++
>  net/bluetooth/hci_event.c   |   12 ++++++++++--
>  2 files changed, 13 insertions(+), 2 deletions(-)

Applied, thanks.

	Gustavo
