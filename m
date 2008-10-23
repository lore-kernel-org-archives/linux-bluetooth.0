Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Quirk for Apple Aluminum Bluetooth  keyboard FN key
From: Marcel Holtmann <marcel@holtmann.org>
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <48F50EEB.1060802@dell.com>
References: <48F50EEB.1060802@dell.com>
Content-Type: text/plain
Date: Thu, 23 Oct 2008 06:56:11 +0200
Message-Id: <1224737771.9386.180.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mario,

> This patch was present in Ubuntu Hardy, but got dropped by accident in
> Intrepid and never submitted upstream.  It adds a quirk enabling the FN
> key on the Apple Aluminum Bluetooth Wireless Keyboard.

yeah, the Ubuntu kernel team is pretty bad in getting patches back to
upstream. However in this case please check with the upstream kernel
since the HID bus makes all quirks general to the HID subsystem.

Regards

Marcel


