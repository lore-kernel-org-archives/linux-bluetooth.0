Return-Path: <cyrus@holtmann.org>
Message-ID: <1357762386.1806.57.camel@aeonflux>
Subject: Re: [PATCH 7/8 v2] Bluetooth: Fix checking for exact values of
 boolean mgmt parameters
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 09 Jan 2013 12:13:06 -0800
In-Reply-To: <1357740319-5737-1-git-send-email-johan.hedberg@gmail.com>
References: <1357738180-4128-8-git-send-email-johan.hedberg@gmail.com>
	 <1357740319-5737-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> All mgmt_set_* commands that take a boolean value encoded in the form of
> a byte should only accept the values 0x00 and 0x01. This patch adds the
> necessary checks for this and returns "invalid params" responses if
> anything else is provided as the value.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> v2: Fix s/SET_SSP/SET_LE/ copy-paste issue
> 
>  net/bluetooth/mgmt.c |   36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


