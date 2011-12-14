Return-Path: <cyrus@holtmann.org>
Message-ID: <1323891366.1965.55.camel@aeonflux>
Subject: Re: [PATCH 5/7] Bluetooth: LE scan infra-structure
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 14 Dec 2011 20:36:06 +0100
In-Reply-To: <1323879926-15971-6-git-send-email-andre.guedes@openbossa.org>
References: <1323879926-15971-1-git-send-email-andre.guedes@openbossa.org>
	 <1323879926-15971-6-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch adds to hci_core an infra-structure to scan LE devices.
> 
> The LE scan is implemented using a work_struct which is enqueued
> on hdev->workqueue. The LE scan work sends commands (Set LE Scan
> Parameters and Set LE Scan Enable) to the controller and waits for
> its results. If commands were executed successfully a timer is set
> to disable the ongoing scanning after some amount of time.

so I rather hold off on these until we get the tasklet removal patches
merged. The mgmt processing will then also be done in process context
and we can just sleep. This should make code like this a lot simpler.

Regards

Marcel


