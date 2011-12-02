Return-Path: <cyrus@holtmann.org>
Date: Fri, 2 Dec 2011 20:22:25 +0900
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Correct version check in hci_setup
Message-ID: <20111202112225.GB2570@joana>
References: <1322040215-640-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1322040215-640-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-11-23 11:23:34 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Check for hci_ver instead of lmp_ver
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_event.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied to the bluetooth current tree. Thanks.

	Gustavo
