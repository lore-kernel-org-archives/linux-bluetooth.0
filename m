Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [RFC] Bluetooth: HCI H5 fast retransmit
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <53E3B2AF.50605@intel.com>
Date: Thu, 7 Aug 2014 12:05:34 -0700
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <ED31149A-8FD2-4BF5-B67A-2312F104F984@holtmann.org>
References: <1406911076-8714-1-git-send-email-loic.poulain@intel.com> <D672899E-220D-4633-A74A-9C50021C2AE8@holtmann.org> <53E3B2AF.50605@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> This patch is not so much out-of-scope of the H5 because specification
> only gives "recommended parameters" regarding timeout calculation.
> 
> I tested it with only one H5 controller (rtl8723).
> This mechanism is very beneficial with this controller due to a
> relative high packet loss.
> 
> However I'm going to rework this patch to be more specific (only fast
> retransmit if the invalid ack number is a duplicate of the last acked packet)
> + comments.

sounds good. Go for it.

Regards

Marcel

