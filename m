Return-Path: <cyrus@holtmann.org>
Date: Sun, 31 May 2015 08:20:40 +0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Florian Grandel <fgrandel@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v6 00/16] Bluetooth: Multi-advertising infrastructure
Message-ID: <20150531012040.GA20436@t440s>
References: <1432507154-22925-1-git-send-email-fgrandel@gmail.com>
 <1432600463-7758-1-git-send-email-fgrandel@gmail.com>
 <064C8AD4-80B3-4E94-96E9-F40BDA0D38C7@holtmann.org>
 <55663161.2000508@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55663161.2000508@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Florian,

On Wed, May 27, 2015, Florian Grandel wrote:
> >Are multiple instances suppose to work with this patch set?
> 
> No. There are a few remaining TODOs (documented in the code) for actual
> multi-advertising. I mention these in the commit messages where applicable.
> 
> The idea was to do the more complex changes in a functionally neutral
> refactoring first as a safe starting point for functional changes (see my
> conv. with Arman on the list).
> 
> Of course I'm prepared to resolve those remaining TODOs in a second patch
> set. I just think it is a good idea if I go full cycle once to avoid those
> beginner's errors during the next iteration.
> 
> If you think that there are no more fundamental flaws in that first patch
> set then I can start with the second one now. What do you think?

I was also under the impression that this set implemented the full
multi-advertising feature (rather than being refactoring in preparation
for it). I think a kernel release should contain the whole thing or
nothing at all, which makes me now a bit doubtful of whether this can
make it to 4.2.

How soon can you send the follow-up set? It will essentially validate
the work of your first set, so it'd be good to see and test it as soon
as possible.

Johan
