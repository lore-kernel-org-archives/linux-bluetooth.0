Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH BlueZ 00/10] shared/gatt-client: Move GATT read/write functions.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1409773571-28417-1-git-send-email-armansito@chromium.org>
Date: Thu, 4 Sep 2014 20:39:57 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <6B3A313D-0C38-445D-82ED-4B75CB18DE76@holtmann.org>
References: <1409773571-28417-1-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> This patch set moves GATT read/write functions from shared/gatt-helpers to
> shared/gatt-client. The following new functions are now available:
> 
>  bt_gatt_client_read_value
>  bt_gatt_client_read_long_value
>  bt_gatt_client_write_without_response
>  bt_gatt_client_write_value
>  bt_gatt_client_write_long_value
> 
> This patch set also adds new commands to tools/btgatt-client which map to the
> functions above.
> 
> Arman Uguray (10):
>  shared/gatt-client: Added bt_gatt_client_read_value.
>  shared/gatt-client: Added bt_gatt_client_read_long_value.
>  shared/gatt-client: Added simple write operations.
>  shared/gatt-client: Added bt_gatt_client_write_long_value.
>  TODO: GATT read/write functions moved to shared/gatt-client.
>  tools/btgatt-client: Added the "read-value" command.
>  tools/btgatt-client: Added the "read-long-value" command.
>  tools/btgatt-client: Added the "write-value" command.
>  tools/btgatt-client: Added the "write-long-value" command.
>  TODO: tools/btgatt-client introduced
> 
> TODO                      |  13 -
> src/shared/gatt-client.c  | 774 ++++++++++++++++++++++++++++++++++++++++++++--
> src/shared/gatt-client.h  |  36 +++
> src/shared/gatt-helpers.c | 625 -------------------------------------
> src/shared/gatt-helpers.h |  30 --
> tools/btgatt-client.c     | 396 +++++++++++++++++++++++-
> 6 files changed, 1160 insertions(+), 714 deletions(-)

all 10 patches have been applied.

Regards

Marcel

