Return-Path: <cyrus@holtmann.org>
Date: Fri, 2 Dec 2011 20:50:25 +0900
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv1 2/6] Bluetooth: Split ctrl init to BREDR and AMP parts
Message-ID: <20111202115025.GD2570@joana>
References: <1322139125-22377-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1322139125-22377-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1322139125-22377-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-11-24 14:52:01 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Current controller initialization is moved tp bredr_init and new
> function added amp_init to handle later AMP init sequence. Current
> AMP init sequence include Reset and Read Local Version.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_core.c  |   64 ++++++++++++++++++++++++++++++++------------
>  net/bluetooth/hci_event.c |    3 ++
>  2 files changed, 49 insertions(+), 18 deletions(-)

For some reason this patch doesn't apply, please rebase.

	Gustavo
