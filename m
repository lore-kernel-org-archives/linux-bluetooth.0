Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Jul 2012 15:53:10 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 10/17] Bluetooth: Add delayed init sequence support for
 UART controllers
Message-ID: <20120710185310.GG13847@joana>
References: <1340796367-10321-1-git-send-email-johan.hedberg@gmail.com>
 <1340796367-10321-11-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1340796367-10321-11-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2012-06-27 14:26:00 +0300]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> This patch makes it possible to have UART drivers perform an internal
> initialization before calling hci_reguister_dev. This allows moving a

typo:  hci_register_dev

	Gustavo
