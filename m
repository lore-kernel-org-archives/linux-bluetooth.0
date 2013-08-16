Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH v10 05/10] Bluetooth: Use voice setting in deferred SCO connection request
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1376499814-11386-6-git-send-email-frederic.dalleau@linux.intel.com>
Date: Fri, 16 Aug 2013 11:47:06 -0700
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@intel.com>
Message-Id: <FCEEFE18-5C0C-46DE-BD05-B97E62C7BB01@holtmann.org>
References: <1376499814-11386-1-git-send-email-frederic.dalleau@linux.intel.com> <1376499814-11386-6-git-send-email-frederic.dalleau@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> When an incoming eSCO connection is requested, check the selected voice
> setting and reply appropriately. Voice setting should have been
> negotiated previously.  For example, in case of HFP, the codec is
> negotiated using AT commands on the RFCOMM channel. This patch only
> changes replies for socket with deferred setup enabled.
> 
> Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/sco.c |   22 +++++++++++++++++-----
> 1 file changed, 17 insertions(+), 5 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

