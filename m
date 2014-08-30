Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH BlueZ v2 0/7] Introduce tools/btgatt-client.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1409414569-20068-1-git-send-email-armansito@chromium.org>
Date: Sat, 30 Aug 2014 09:48:25 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <07455C3A-D687-41EC-ABFF-40AD17618045@holtmann.org>
References: <1409414569-20068-1-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> * v2: Rebased on latest master & fixed conflicts in Makefile.tools
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
> Makefile.tools        |  13 +-
> tools/btgatt-client.c | 657 ++++++++++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 669 insertions(+), 1 deletion(-)
> create mode 100644 tools/btgatt-client.c

all 7 patches have been applied.

When adding new tools you need to remember to add the binary to .gitignore.

Regards

Marcel

