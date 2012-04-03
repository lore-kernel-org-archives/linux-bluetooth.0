Return-Path: <cyrus@holtmann.org>
Message-ID: <1333460117.1870.287.camel@aeonflux>
Subject: Re: [PATCH v1] Bluetooth: Fix packet type for ESCO Link
From: Marcel Holtmann <marcel@holtmann.org>
To: Hemant Gupta <hemant.gupta@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org,
	Naresh Gupta <naresh.gupta@stericsson.com>,
	Hemant Gupta <hemantgupta.ste@gmail.com>
Date: Tue, 03 Apr 2012 06:35:17 -0700
In-Reply-To: <1333458907-28940-1-git-send-email-hemant.gupta@stericsson.com>
References: <1333458907-28940-1-git-send-email-hemant.gupta@stericsson.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hemant,

> This patch fixes the packet type for ESCO Link which was incorrectly
> set for EDR ESCO Packet Types. Anding esco_type with ~EDR_ESCO_MASK
> results in loosing information of esco packet type (EDR Packet
> types are inverted as per BT Spec) that resulted in wrong calculation
> of packet type in hci_setup_sync() API causing the HCI Setup Synchronous
> Connection Command to fail.

any chance you can add a hcidump trace to the commit message to show
this failure?

Regards

Marcel


