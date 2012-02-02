Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Feb 2012 17:16:46 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Hemant Gupta <hemant.gupta@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org,
	Hemant Gupta <hemantgupta.ste@gmail.com>
Subject: Re: [PATCH v1 1/1] Bluetooth: Send correct response to IO Capability
 Request
Message-ID: <20120202011646.GB12782@x220.globalsuite.net>
References: <1326701069-19146-1-git-send-email-hemant.gupta@stericsson.com>
 <1326701069-19146-2-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1326701069-19146-2-git-send-email-hemant.gupta@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hemant,

On Mon, Jan 16, 2012, Hemant Gupta wrote:
> This patch sends correct IO Capability response to remote device
> in case Local Device supports KeyBoardDisplay IO Capability as
> this capability is not valid as per BT spec for IO capability
> Request Reply Command.
> This capability is mapped to DisplayYesNo which is in accordance
> with BT spec.
> 
> Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
> ---
>  net/bluetooth/hci_event.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)

Applied to my bluetooth-next tree. Thanks.

Johan
