Return-Path: <cyrus@holtmann.org>
Message-ID: <1322222412.29909.18.camel@aeonflux>
Subject: Re: [RFCv1 2/6] Bluetooth: Split ctrl init to BREDR and AMP parts
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 25 Nov 2011 13:00:12 +0100
In-Reply-To: <1322139125-22377-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1322139125-22377-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1322139125-22377-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Current controller initialization is moved tp bredr_init and new
> function added amp_init to handle later AMP init sequence. Current
> AMP init sequence include Reset and Read Local Version.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_core.c  |   64 ++++++++++++++++++++++++++++++++------------
>  net/bluetooth/hci_event.c |    3 ++
>  2 files changed, 49 insertions(+), 18 deletions(-)

so far so good.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


