Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: hci_uart: Fix typo in stats for sco tx
From: Marcel Holtmann <marcel@holtmann.org>
To: Karl Beldan <karl.beldan@gmail.com>
Cc: Jiri Kosina <trivial@kernel.org>, linux-bluetooth@vger.kernel.org
In-Reply-To: <1286481430-6761-1-git-send-email-karl.beldan@gmail.com>
References: <1286481430-6761-1-git-send-email-karl.beldan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 08 Oct 2010 10:33:36 +0200
Message-ID: <1286526816.6145.179.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Karl,

> s/stat.cmd_tx++/stat.sco_tx++ for HCI_SCODATA_PKT
> 
> Signed-off-by: Karl Beldan <karl.beldan@gmail.com>
> Cc: Marcel Holtmann <marcel@holtmann.org>

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


