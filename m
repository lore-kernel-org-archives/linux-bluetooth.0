Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] Bluetooth: Ignore H5 non-link packets in non-active state
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <50C3158CF44D924791C15F1437EF2EC62438004B@HASMSX104.ger.corp.intel.com>
Date: Mon, 23 Jun 2014 17:24:08 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Message-Id: <778D5FB8-193A-42A0-B4C8-787630124123@holtmann.org>
References: <1403528983-9314-1-git-send-email-loic.poulain@intel.com>,<9B6ECBFE-E31A-4C5B-9892-F383F180F350@holtmann.org> <50C3158CF44D924791C15F1437EF2EC62438004B@HASMSX104.ger.corp.intel.com>
To: "Poulain, Loic" <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

no top-posting on this mailing list please.

> Sorry, but I omitted to precise that this patch fixes a NULL pointer dereference.
> Indeed, h5->rx_skb was freed in h5_reset_rx and dereferenced in the next 
> h5_rx_payload call. So I think it should go to stable tree.

and if you think this should go to stable, then you have to have a proper commit message explaining what is happening and what the impact is. Feel free to send a new version.

Regards

Marcel

