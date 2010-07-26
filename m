Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC v2] Bluetooth: Provide access to reassembled Rx packets
From: Marcel Holtmann <marcel@holtmann.org>
To: Suraj Sumangala <suraj@atheros.com>
Cc: linux-bluetooth@vger.kernel.org, Jothikumar.Mothilal@Atheros.com
In-Reply-To: <1280126094-18004-1-git-send-email-suraj@atheros.com>
References: <1280126094-18004-1-git-send-email-suraj@atheros.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 26 Jul 2010 08:13:23 -0700
Message-ID: <1280157203.2621.48.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

> Provide the HCI transport driver access to reassembled Rx packets before
> sending to Host.

you still haven't answered my question on why you want this. It makes no
sense to me to relay all packets back to the driver. That is just a
waste of CPU cycles.

Regards

Marcel


