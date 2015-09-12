Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH] bluetooth: bt3c_cs: clean up obsolete functions
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150911150226.GA12951@ubuntu>
Date: Sat, 12 Sep 2015 09:47:40 +0100
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <FB0132DD-5BEA-4881-AE9D-9B7BC9BAD7D9@holtmann.org>
References: <20150911150226.GA12951@ubuntu>
To: "Mutharaju, Prasanna (P.)" <mkarthi3@visteon.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Prasanna,

> simple_strtoul is obsolete, use kstrtoul instead reported by checkpatch.
> 
> Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
> ---
> drivers/bluetooth/bt3c_cs.c |   12 ++++++++----
> 1 files changed, 8 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

