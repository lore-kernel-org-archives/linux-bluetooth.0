Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Jan 2013 02:07:45 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 10/10 v2] Bluetooth: Fix returning proper cmd_complete
 for mgmt_block/unblock
Message-ID: <20130123040745.GB1632@joana>
References: <1358684842-4441-1-git-send-email-johan.hedberg@gmail.com>
 <1358684842-4441-11-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1358684842-4441-11-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2013-01-20 14:27:22 +0200]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> The Block/Unblock Device Management commands should return Command
> Complete instead of Command Status whenever possible so that user space
> can distinguish exactly which command failed in the case of multiple
> commands. This patch does the necessary changes in the command handler
> to return the right event to user space.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

All 10 patches have been applied to bluetooth-next. Thanks.

	Gustavo
