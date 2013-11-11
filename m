Return-Path: <cyrus@holtmann.org>
Date: Mon, 11 Nov 2013 10:33:30 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] android/hid: Handle virtual unplug event from hid device
Message-ID: <20131111083330.GA3773@x220.p-661hnu-f1>
References: <1383920094-20498-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383920094-20498-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Fri, Nov 08, 2013, Ravi kumar Veeramally wrote:
> If hid host receives the virtual unplug event from hid device
> recipient shall destroy or invalidate all bluetooth bonding and
> virtual cable information
> ---
>  android/hal-msg.h |  1 +
>  android/hidhost.c | 28 ++++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)

Looks good enough to me, so the patch has been applied.

Johan
