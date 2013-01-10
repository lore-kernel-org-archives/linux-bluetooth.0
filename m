Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Jan 2013 16:30:58 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/8 v2] Bluetooth: Fix returning proper command status
 for start_discovery
Message-ID: <20130110183058.GA7700@joana>
References: <1357738180-4128-6-git-send-email-johan.hedberg@gmail.com>
 <1357822449-10727-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1357822449-10727-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2013-01-10 14:54:09 +0200]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> Management commands should whenever possible fail with proper command
> status or command complete events. This patch fixes the
> mgmt_start_discovery command to do this for the failure cases where an
> incorrect parameter value was passed to it ("not supported" if the
> parameter value was valid but the controller doesn't support it and
> "invalid params" if it isn't valid at all).
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> v2: Use proposed logic for testing for not supported parameters
> 
>  net/bluetooth/mgmt.c |   46 ++++++++++++++++++++++++++++++----------------
>  1 file changed, 30 insertions(+), 16 deletions(-)

Patch has been applied. Thanks.

	Gustavo
