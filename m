Return-Path: <cyrus@holtmann.org>
Message-ID: <1413553723.2705.154.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: Locking issue when running out of credits in 6lowpan connection
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Date: Fri, 17 Oct 2014 16:48:43 +0300
In-Reply-To: <54411319.7030306@hurleysoftware.com>
References: <1413549465.2705.149.camel@jrissane-mobl.ger.corp.intel.com>
	 <54411319.7030306@hurleysoftware.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On pe, 2014-10-17 at 09:01 -0400, Peter Hurley wrote:
> On 10/17/2014 08:37 AM, Jukka Rissanen wrote:
> > Any ideas how to solve this?
> 
> The spin_lock() in hci_queue_acl() still needs to be spin_lock_bh().

Do'h! Yep, you mentioned that yesterday but I forgot to convert the
locks. Thanks for the help.


Cheers,
Jukka



