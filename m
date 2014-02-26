Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCHv2 01/23] android/hal-gatt-api: Add missing opcodes in GATT Service
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393404081-1401-2-git-send-email-jakub.tyszkowski@tieto.com>
Date: Wed, 26 Feb 2014 00:51:52 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <63DA7E43-4B20-4CF9-8539-3BBE1A7EBD21@holtmann.org>
References: <1393404081-1401-1-git-send-email-jakub.tyszkowski@tieto.com> <1393404081-1401-2-git-send-email-jakub.tyszkowski@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> Add missing Listen and Set Advertising Data opcodes and reorder them as
> they appear in HAL's headers.

I left this out originally since they are only useful for when we are a peripheral. Curious to know if Android APIs actually support this.

GATT client and server are valid for central role. And the connect/disconnect need to be turned into being one pair of commands. No point in duplicating them. There is really no difference between a GATT client and server connect. The central will connect to the peripheral. Unless Android got fully confused and uses the APIs wrongly.

Regards

Marcel

