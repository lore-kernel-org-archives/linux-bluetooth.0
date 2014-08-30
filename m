Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH BlueZ v1 0/7] Introduce tools/btgatt-client.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1409326452-8534-1-git-send-email-armansito@chromium.org>
Date: Fri, 29 Aug 2014 20:18:41 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <33338DB3-59D9-451D-B4A9-0D2C64470FDA@holtmann.org>
References: <1409326452-8534-1-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> * v1: Removed L2CAP_LM socket options; using only BT_SECURITY now.
> 
> Arman Uguray (7):
>  tools/btgatt-client: Introduce tools/btgatt-client
>  tools/btgatt-client: Added L2CAP LE ATT connection.
>  tools/btgatt-client: Integrate bt_att and bt_gatt_client.
>  tools/btgatt-client: Add command parsing.
>  tools/btgatt-client: Add "ready" handler.
>  tools/btgatt-client: Add "services" command.
>  tools/btgatt: Add command argument support.
> 
> Makefile.tools        |  14 +-
> tools/btgatt-client.c | 657 ++++++++++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 670 insertions(+), 1 deletion(-)
> create mode 100644 tools/btgatt-client.c

I think you need to rebase this one since it does not apply to current git.

Regards

Marcel

