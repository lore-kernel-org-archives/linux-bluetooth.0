Return-Path: <cyrus@holtmann.org>
Date: Tue, 16 Dec 2014 13:43:30 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v5 1/3] Bluetooth: Add lock for HCI_OP_SCAN_ENABLE command
Message-ID: <20141216114330.GA4618@t440s.lan>
References: <1418293574-25095-1-git-send-email-jpawlowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1418293574-25095-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Thu, Dec 11, 2014, Jakub Pawlowski wrote:
> This patch introduces new lock, that need to be acquired if you want
> to use HCI_OP_SCAN_ENABLE in a series of request. Next patch introduces
> le restarting that would have race condition without that.

This is not really the way that locks are typically used and will likely
result in bugs in the long run. Each lock should have a well defined
piece of data that it protects and the lock/unlock pair should cover a
clear and contiguous section of code. Neither one of these principles
seems to fulfilled by your design.

As an example, your code would be stuck with the lock if you powered off
the adapter while holding it (since the HCI request callbacks would not
get called). So you'll need to find a different kind of solution here.
It seems to me like you're looking for some sort of state tracking,
which is something locking shouldn't be mixed with.

Johan.
