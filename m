Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH] Bluetooth: hci_h4: Fix zero len data packet reception issue
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1440435477-25188-1-git-send-email-loic.poulain@intel.com>
Date: Mon, 24 Aug 2015 11:19:18 -0700
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <6CD3A286-2B0E-4D93-A31B-49336A8AC37C@holtmann.org>
References: <1440435477-25188-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Packets with a variable len equal to zero were not received.
> Since no more data expected (and input buffer entirely consumed), we
> need to complete/forward the packet immediately instead of waiting for
> more data.
> 
> Fix this by completing the packet on !dlen.
> happening if two cases:
>    - no variable data len
>    - variable data len is zero.

please give me an example of such a packet. I am currently failing to see what is wrong with the code and how this patch would actually help.

Is this for vendor packet types or does this actually happen with standard H:4 packet types?

Regards

Marcel

