Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 May 2013 14:14:36 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] Bluetooth: Fix not sending link key negative reply
Message-ID: <20130507111436.GA11154@x220>
References: <20130507060630.GA3766@x220.ger.corp.intel.com>
 <1367923915-6421-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367923915-6421-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, May 07, 2013, Andrei Emeltchenko wrote:
> If Link Keys are not loaded during initialization with
> MGMT_OP_LOAD_LINK_KEYS command then pairing always fails
> since HCI_LINK_KEYS is not set. Check instead for HCI_MGMT
> flag.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
> *v2 modified patch following Johan's comments

The existing behavior is intentional with the implicit assumption that a
mgmt_load_link_keys will always be received, if only to set the debug
keys flag in case of no link keys. So I'd word the commit message
differently, something like:

	Bluetooth: Use HCI_MGMT flag for link keys management

	The HCI_MGMT flag should be enough to test for a user space that
	expects the kernel to do link keys management. Checking for the
	special HCI_LINK_KEYS flag is a bit overkill for this since we
	don't strictly speaking need to receive the load_link_keys
	command to know that user space talks mgmt - any mgmt command
	should be enough.

Johan
