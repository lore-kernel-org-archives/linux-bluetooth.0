Return-Path: <cyrus@holtmann.org>
Message-ID: <1322222488.29909.19.camel@aeonflux>
Subject: Re: [RFCv1 3/6] Bluetooth: Add HCI Read Flow Control Mode function
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 25 Nov 2011 13:01:28 +0100
In-Reply-To: <1322139125-22377-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1322139125-22377-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1322139125-22377-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Upstream Code Aurora function with minor trivial fixes.
> Origin: git://codeaurora.org/kernel/msm.git
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/hci.h      |    6 ++++++
>  include/net/bluetooth/hci_core.h |    2 ++
>  net/bluetooth/hci_event.c        |   19 +++++++++++++++++++
>  3 files changed, 27 insertions(+), 0 deletions(-)

just keep in mind that this command is not available on all controller
version.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


