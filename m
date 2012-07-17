Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Jul 2012 14:51:57 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 18/18 v2] Bluetooth: Introduce a flags variable to
 Three-wire UART state
Message-ID: <20120717175157.GA19582@joana>
References: <1342444339-1627-1-git-send-email-johan.hedberg@gmail.com>
 <1342444339-1627-18-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1342444339-1627-18-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2012-07-16 16:12:19 +0300]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> This patch introduces a flags variable to the Three-wire UART state
> struct and converts the two existing bools in the struct into flags.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  drivers/bluetooth/hci_h5.c |   26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)

All patches have been applied to bluetooth-next. Thanks.

	Gustavo
