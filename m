Return-Path: <cyrus@holtmann.org>
Date: Tue, 4 Jan 2011 12:14:17 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 01/11] Bluetooth: Implement automatic setup procedure
 for local adapters
Message-ID: <20110104101417.GA26944@jh-x301>
References: <1294135715-26728-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1294135715-26728-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jan 04, 2011, johan.hedberg@gmail.com wrote:
> This patch implements automatic initialization of basic information
> about newly registered Bluetooth adapters. E.g. the address and features
> are always needed so it makes sense for the kernel to automatically
> power on adapters and read this information. A new HCI_SETUP flag is
> added to track this state.
> 
> In order to not consume unnecessary amounts of power if there isn't a
> user space available that could switch the adapter back off, a timer is
> added to do this automatically as long as no Bluetooth user space seems
> to be present. A new HCI_AUTO_OFF flag is added that user space needs to
> clear to avoid the automatic power off.
> 
> Additionally, the management interface index_added event is moved to the
> end of the HCI_SETUP stage so a user space supporting the managment
> inteface has all the necessary information available for fetching when
> it gets notified of a new adapter. The HCI_DEV_REG event is kept in the
> same place as before since existing HCI raw socket based user space
> versions depend on seeing the kernels initialization sequence
> (hci_init_req) to determine when the adapter is ready for use.

Sorry about this stray and duplicate patch. I got some doubts when doing
git send-email originally and hit ctrl-c before an ack was shown for the
first email. It seems it got through to the list nevertheless. I.e.
ignore this as all the relevant patches are part of the next thread.

Johan
