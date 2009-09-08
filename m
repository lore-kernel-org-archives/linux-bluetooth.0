Return-Path: <cyrus@holtmann.org>
Date: Wed, 9 Sep 2009 01:28:39 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Peter Hurley <phurley@charter.net>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: Fix for audio stream XCASE connect:connect failures
Message-ID: <20090908222839.GA25653@jh-x301>
References: <4AA6C556.9050804@charter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4AA6C556.9050804@charter.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Tue, Sep 08, 2009, Peter Hurley wrote:
..lots of great analysis snipped..
> Comments?

That's some really nice analysis of the situation you've done. The chosen
solution seems like the best one and and patch looks good too. Could you
still do the following so we can get it pushed upstream and you get the
proper credits as the author of the patch:

- Use /* .. */ for comments instead of //
- Make sure your lines are max 80 columns (e.g. shorten the debug message
  or split it into two lines if necessary)
- commit it to your own tree with a descriptive commit message and prepare
  a patch using "git format-patch". This way it's easy for me to apply it
  using "git am" and e.g. the author field gets correctly preserved.

Thanks.

Johan
