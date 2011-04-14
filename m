Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Apr 2011 10:29:37 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Iain Hibbert <plunky@rya-online.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: bugfix patches for hcidump
Message-ID: <20110414072937.GA28187@jh-x301>
References: <alpine.NEB.2.00.1104140748380.12891@galant.ukfsn.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.NEB.2.00.1104140748380.12891@galant.ukfsn.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Iain,

On Thu, Apr 14, 2011, Iain Hibbert wrote:
> Is this still the correct place to post patches for hcidump?

Yes.

> I ask because I have posted a bugfix twice and so far been ignored, in my
> opinion BlueZ *really* needs a bug tracker so things don't get lost..

Your patch email is still marked as "new" in my linux-bluetooth folder,
so in that sense it's not lost. I've just forgotten to check back on
older unapplied patches for a while. The reason why it didn't
immediately go upstream was a coding style issue (missing space after a
typecast) and the reuse of an iterator variable for something else than
iteration. I don't remember what I was doing at the time when I glanced
at your patch but it seems I must have been in quite a hurry since I
didn't respond with these comments back then. Sorry about that.

Johan
