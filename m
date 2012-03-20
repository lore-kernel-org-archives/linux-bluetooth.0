Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Mar 2012 10:25:04 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andre Guedes <aguedespe@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, andre.guedes@openbossa.org
Subject: Re: [PATCH] Bluetooth: Replace EPERM by EALREADY in
 hci_cancel_inquiry
Message-ID: <20120320132504.GA20925@joana>
References: <1332213218-21420-1-git-send-email-aguedespe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332213218-21420-1-git-send-email-aguedespe@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

* Andre Guedes <aguedespe@gmail.com> [2012-03-20 00:13:38 -0300]:

> We should return -EALREADY in hci_cancel_inquiry since it is more
> suitable than -EPERM error code.
> 
> Signed-off-by: Andre Guedes <aguedespe@gmail.com>

Applied, thanks.

	Gustavo
