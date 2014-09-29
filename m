Return-Path: <cyrus@holtmann.org>
Date: Mon, 29 Sep 2014 10:32:26 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alfonso Acosta <fons@spotify.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] Bluetooth: Fix sending redundant "LE Set Scan Enable
 (disable)" commands
Message-ID: <20140929073226.GA4163@t440s.lan>
References: <1411746838-9879-1-git-send-email-fons@spotify.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1411746838-9879-1-git-send-email-fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alfonso,

On Fri, Sep 26, 2014, Alfonso Acosta wrote:
> Checking the LE scanning state (HCI_LE_SCAN) before queuing a new "LE
> Set Scan Enable (disable)" command is not enough to avoid sending
> extra redundant commands. Since HCI_LE_SCAN is only updated upon
> "Command Complete" confirmation, multiple "LE Set Scan Enable
> (disable)" can get queued before the first one gets delivered.

I can see the need for having some sort of fix for this. However, we
already have several use cases where we'd need to check for pending HCI
commands and adding a new variable to hci_dev for each case is not
really a good way to solve it. If we really would want to do it and
we're out of available hdev->dev_flags I'd consider making the hdev
variable "unsigned long dev_flags[2]" which both test_bit and set_bit
should be able to handle fine (and existing code wouldn't need
changing). You also have the issue that your code only covers the HCI
commands sent through hci_req_add_le_scan_disable() but not any other
code paths that might send the same command (either from the kernel or
from user space using a raw HCI socket, e.g. hcitool).

So far we've been able to cover other similar cases adequately by
looking into the mgmt pending command queue and so the HCI command queue
hasn't required any special look-ups. Now it might be the time to
consider something like that. I.e. if we really do need to check for a
not-yet sent HCI command a helper to look-up pending commands in
hdev->cmd_q should be added. OTOH, we'd still have a race when the HCI
command has already been sent but not yet completed, in which case the
helper might need to look at hdev->sent_cmd as well. Either way, solving
this in a generic manner doesn't seem to be a completely trivial task.

> I encountered this issue when unpairing (MGMT_OP_UNPAIR_DEVICE) and
> immediately pairing (MGMT_OP_PAIR_DEVICE) the only auto-connected
> device. MGMT_OP_UNPAIR_DEVICE stopped scanning since there were no
> more auto-connected devices and MGMT_OP_PAIR_DEVICE also stopped
> scanning because some controllers cannot scan while connecting.
> 
> I added a dedicated flag (le_scan_disable_queued) in hci_dev for this
> purpose since dev_flags is already full.

If I've understood correctly the background for this (which it really
wouldn't hurt to mention in the commit message) is a paired device that
looses its pairing information because if a reset and we want to repair
with it? I think to make this less complex for user space we should
consider simply making mgmt_pair_device() calls valid for already paired
devices, in which case it'd simply trigger a re-pairing. That way you
wouldn't need the initial mgmt_unpair_device() call. Thoughts?

Johan
