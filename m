Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Mar 2013 14:08:10 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v5 26/26] Bluetooth: Fix PIN/Confirm/Passkey response
 parameters
Message-ID: <20130318170810.GA3072@joana>
References: <1363385236-25704-1-git-send-email-johan.hedberg@gmail.com>
 <1363385236-25704-27-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363385236-25704-27-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2013-03-15 17:07:16 -0500]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> The only valid mgmt response to these pairing related commands is a
> mgmt_cmd_complete and the returned parameters should contain the address
> and address type of the remote device.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c |   20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)

All patches have been applied to bluetooth-next. Thanks.

	Gustavo
