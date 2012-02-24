Return-Path: <cyrus@holtmann.org>
Date: Fri, 24 Feb 2012 14:43:20 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Complete Read Local Version HCI cmd
Message-ID: <20120224124320.GA10358@x220>
References: <1330080344-23739-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330080344-23739-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Feb 24, 2012, Andrei Emeltchenko wrote:
> Mark request status as done for Read Local Version HCI command.
> In AMP initialization this HCI command is the last and needs
> to be completed.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_event.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
