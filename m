Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2 11/16] Bluetooth: Add 'eir_len' param to
 mgmt_device_found()
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 10 Aug 2011 06:50:23 -0700
In-Reply-To: <1311623405-31108-12-git-send-email-andre.guedes@openbossa.org>
References: <1311623405-31108-1-git-send-email-andre.guedes@openbossa.org>
	 <1311623405-31108-12-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1312984225.3373.118.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch adds a new parameter to mgmt_device_found() to inform
> the length of 'eir' pointer.
> 
> EIR data from LE advertising report event doesn't have a fixed length
> as EIR data from extended inquiry result event does. We needed to
> change mgmt_device_found() so it copies 'eir_len' bytes instead of
> HCI_MAX_EIR_LENGTH.

what is the max EIR length for LE? Is it more than with BR/EDR. Or is it
just variable length?

Regards

Marcel



