Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH v2 00/12] Bluetooth: Move LE scan changes behind req_workqueue
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1447222287-4288-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 11 Nov 2015 15:26:35 +0900
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <BA80D318-C52C-41EC-8DD6-52C7D8F851EF@holtmann.org>
References: <1447222287-4288-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> v2: updated version with feedback for 01/12 and 02/12 taken into
> account.
> 
> From the original cover letter:
> 
> The current bluetooth-next tree is not able to reliably and in a
> race-free manner handle updates to the LE scan state. This results in
> the kernel ending up out of sync with the actual LE scan state and
> starts sending incorrect scan state HCI commands, often resulting in
> "not allowed" HCI responses.
> 
> This is an initial set of patches to try solve the issue. I've tried to
> retain as much as possible of the original logic so that it's easier to
> see that nothing should get broken. Because of this, there are still
> many simplifications and cleanups that can be done. However, since I've
> already got 12 patches lined up I wanted to get them sent, reviewed and
> merged. After that I can concentrate on the cleanups and I'll also be
> looking into moving the adverising state changes to hci_request.c as
> well.
> 
> The general solution that this set takes to solve the synchronization
> issues with the LE scan state, is to move all of it behind the
> hdev->req_workqueue and perform the actions synchronously. The main tool
> I've used for this is the hci_req_sync() API which allows taking
> existing asynchronous HCI request helpers and using them to perform the
> same commands synchronously (by passing the helper as the callback to
> hci_req_sync).
> 
> Since only one work callback is active at a time we get an easy way to
> avoid races between the changes. All of the new synchronous code can be
> found in hci_request.c which seemed like an appropriate place for it.
> 
> I've done a fair amount of testing with the patches, including
> mgmt-tester, l2cap-tester and various bluetoothd tests (both with
> controllers supporting simultaneous Inquiry+LE scan as well as those not
> supporting it). However, because of the size of the changes it's
> perfectly possible that I've missed or broken something, so it'd be good
> if others could give the set a spin before merging it.
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (12):
>      Bluetooth: Add stubs for synchronous HCI request functionality
>      Bluetooth: Run all background scan updates through req_workqueue
>      Bluetooth: Don't wait for HCI in Add/Remove Device
>      Bluetooth: Add HCI status return parameter to hci_req_sync()
>      Bluetooth: Use req_workqueue for explicit connect requests
>      Bluetooth: Use req_workqueue for background scanning when powering on
>      Bluetooth: Make __hci_update_background_scan private to hci_request.c
>      Bluetooth: Move LE scan disable/restart behind req_workqueue
>      Bluetooth: Add discovery type validity helper
>      Bluetooth: Add error return value to hci_req_sync callback
>      Bluetooth: Move Start Discovery to req_workqueue
>      Bluetooth: Move Stop Discovery to req_workqueue
> 
> include/net/bluetooth/hci.h      |   3 +-
> include/net/bluetooth/hci_core.h |  10 +-
> net/bluetooth/hci_conn.c         |  39 +--
> net/bluetooth/hci_core.c         | 243 ++++-------------
> net/bluetooth/hci_request.c      | 537 +++++++++++++++++++++++++++++++++++---
> net/bluetooth/hci_request.h      |  26 +-
> net/bluetooth/mgmt.c             | 503 +++++++----------------------------
> 7 files changed, 684 insertions(+), 677 deletions(-)

patches 1-10 have been applied to bluetooth-next tree.

Regards

Marcel

