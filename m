Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Feb 2015 11:15:57 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: fix service discovery behaviour for empty
 uuids filter
Message-ID: <20150213091557.GA30773@t440s.lan>
References: <1423795883-13182-1-git-send-email-jpawlowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423795883-13182-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Thu, Feb 12, 2015, Jakub Pawlowski wrote:
> This patch fixes service discovery behaviour, when provided uuid filter
> is empty and HCI_QUIRK_STRICT_DUPLICATE_FILTER is set. Before this
> patch, empty uuid filter was unable to trigger scan restart, and that
> caused inconsistent behaviour in applications.
> 
> Example: two DBus clients call BlueZ, one to find all devices with
> service abcd, second to find all devices with rssi smaller than -90.
> Sum of those filters, that is passed to mgmt_service_scan is empty
> filter, with no rssi or uuids set.
> That caused kernel not to restart scan when quirk was set.
> That was inconsistent with what happen when there's only one of those
> two filters set (scan is restarted and reports devices).
> 
> To fix that, new variable hdev->discovery.service_discovery was
> introduced. It can indicate that filtered scan is running, no matter
> what uuid or rssi filter is set.
> 
> Thi patch also closes all code responsible for filtered discovery in

Minor typo there: s/Thi/This/

> one if statement. That makes whole code shorter, much more readable,
> and easier to backport to older kernels, especially pre 3.10.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
>  include/net/bluetooth/hci_core.h |   2 +
>  net/bluetooth/mgmt.c             | 140 +++++++++++++++------------------------
>  2 files changed, 55 insertions(+), 87 deletions(-)

Would it be possible to provide a mgmt-tester case to catch this issue?
The fact that this issue wasn't noticed earlier can be seen as an
indication that the mgmt-tester coverage of this API isn't good enough.

Do you think this is critical enough that we should try to get a fix
still for 3.20 through bluetooth.git? The fact that the patch looks
largely as refactoring (as opposed to a clear fix) might make that
difficult.

Johan
