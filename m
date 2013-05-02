Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v3 00/14] Update Discovery to use HCI request framework
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1367346580-6647-1-git-send-email-andre.guedes@openbossa.org>
Date: Wed, 1 May 2013 18:59:23 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <292E4AE7-0A38-42D5-82C1-D50C6D64DEDE@holtmann.org>
References: <1367346580-6647-1-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This v3 is very similar to the previous patch set, except it has some minor
> changes Johan suggested.
> 
> This patch set requires the patch "Bluetooth: Fix checks for LE support on
> LE-only controllers" in order to apply (this patch is already acked).

do we have test cases in mgmt-tester that covers all the different command variations? Especially also when it comes to name resolving and interleaved discovery.

Regards

Marcel

