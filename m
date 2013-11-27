Return-Path: <cyrus@holtmann.org>
Date: Wed, 27 Nov 2013 13:12:03 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/4] android/pan: Implement pan connect method in daemon
Message-ID: <20131127111203.GA17921@x220.p-661hnu-f1>
References: <1385387369-3015-1-git-send-email-ravikumar.veeramally@linux.intel.com>
 <1385387369-3015-3-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1385387369-3015-3-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Mon, Nov 25, 2013, Ravi kumar Veeramally wrote:
> Implements the PAN connect method in android daemon with PANU role
> only. Setting up the bnep environment, adds connection and makes
> bnep interface up. Notifies bnep interface on control state call back
> and connection status on connection state call back.
> ---
>  android/Android.mk  |   2 +
>  android/Makefile.am |   3 +-
>  android/pan.c       | 289 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 291 insertions(+), 3 deletions(-)

I've applied the first patch in this set, however I'll wait for a new
revision of the rest including the refactoring of
profiles/network/common.c and profiles/network/connection.c.

Johan
