Return-Path: <cyrus@holtmann.org>
Date: Tue, 5 Jun 2012 11:20:21 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] gattrib: Fix command timeout handling
Message-ID: <20120605142021.GA3988@samus>
References: <1338898622-18408-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338898622-18408-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 20:17 Tue 05 Jun, Johan Hedberg wrote:
> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> This patch fixes command timeout handling. Previously attrib_destroy was
> explicitly called which ignored any reference holders. This patch fixes
> the issue by first passing errors to command callbacks and after that
> marking the GAttrib object as stale so no further operations can be
> done.
> ---
> This is an untested patch which should hopefully fix bluetoothd crashes
> when we fail to receive a response to a command. I'm sending it to
> linux-bluetooth in case someone can spot some obvious problem with it.
> If there are no objections I'll complete testing of it during the next
> 24 hours and then apply it upstream.

Looks fine to me as well.

On a side note, I took a look at how gatchat[1] (from ofono) does this, and
it gave me some ideas about how to simplify some things, I am thinking
mostly about the GAttrib destruction code path. And this "stale"
condition would be useful.


[snip]


Cheers,
-- 
Vinicius

[1] http://git.kernel.org/?p=network/ofono/ofono.git;a=blob;f=gatchat/gatio.c;hb=HEAD
