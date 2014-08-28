Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH BlueZ v1 00/13] Introducing shared/gatt-client
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1408754867-13313-1-git-send-email-armansito@chromium.org>
Date: Thu, 28 Aug 2014 13:46:03 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <2A1DCF6B-5E80-44D2-AC49-FED73B1216E1@holtmann.org>
References: <1408754867-13313-1-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> * v1:
>  - Moved the TODOs to the top-level TODO file in a new ATT/GATT section.
>  - Removed bt_gatt_client_init. Instead, added a
>    bt_gatt_client_set_ready_handler to set up a handler which gets called when
>    discovery is over. Discovery is initiated in bt_gatt_client_new instead.
>  - Removed bt_gatt_client_get_att.
>  - Removed the (un)register_service_changed functions for now.
>  - Removed bt_gatt_client_destroy in favor of ref/unref functions.
>  - Dropped "_handler" from bt_att_(un)register_disconnect_handler functions.
> 
> Arman Uguray (13):
>  TODO: Add items for tasks involving the new shared ATT/GATT stack
>  shared/gatt-helpers: Remove service, characteristic, descriptor
>    structures.
>  shared/gatt-helpers: Added result count functions.
>  shared/gatt-client: Added initial skeleton and simple functions.
>  shared/att: Support multiple disconnect handlers.
>  shared/att: Add BT_ATT_DEFAULT_LE_MTU macro.
>  shared/gatt-helpers: Fixed typo in callback args.
>  shared/gatt-client: Add bt_gatt_client_set_debug.
>  shared/gatt-client: Implement initial service discovery.
>  shared/gatt-client: Add service iterator functions.
>  shared/gatt-client: Implement characteristic discovery.
>  shared/gatt-client: Implement descriptor discovery.
>  TODO: shared/gatt-client has been defined and discovery implemented
> 
> Makefile.am               |   3 +-
> TODO                      |  90 ++++++-
> src/shared/att-types.h    |   2 +
> src/shared/att.c          | 161 ++++++++++--
> src/shared/att.h          |  11 +-
> src/shared/gatt-client.c  | 652 ++++++++++++++++++++++++++++++++++++++++++++++
> src/shared/gatt-client.h  |  90 +++++++
> src/shared/gatt-helpers.c | 100 +++++--
> src/shared/gatt-helpers.h |  36 +--
> 9 files changed, 1064 insertions(+), 81 deletions(-)
> create mode 100644 src/shared/gatt-client.c
> create mode 100644 src/shared/gatt-client.h

sorry for the delay, I never fully got through the whole set in one go. I tried to apply it today, but I ran into some issues.

/data/devel/x/.git/rebase-apply/patch:155: new blank line at EOF.
+
fatal: 1 line adds whitespace errors.
Patch failed at 0004 shared/gatt-client: Added initial skeleton and simple functions.

We are using struct checks here and you need to make sure you do not have any extra empty lines at the end of your files.

The more problematic one is this.

error: patch failed: src/shared/gatt-client.h:34
error: src/shared/gatt-client.h: patch does not apply
Patch failed at 0008 shared/gatt-client: Add bt_gatt_client_set_debug.

Can you just rebase your patches against latest git so that I can apply them.

Regards

Marcel

