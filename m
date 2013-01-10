Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Jan 2013 06:24:58 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 7/8 v2] Bluetooth: Fix checking for exact values of
 boolean mgmt parameters
Message-ID: <20130110082458.GA1649@joana>
References: <1357738180-4128-8-git-send-email-johan.hedberg@gmail.com>
 <1357740319-5737-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1357740319-5737-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2013-01-09 16:05:19 +0200]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
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

All patches but 5 and 8 were applied to bluetooth-next. Thanks.

	Gustavo
