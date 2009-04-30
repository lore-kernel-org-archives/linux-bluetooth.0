Return-Path: <cyrus@holtmann.org>
Date: Thu, 30 Apr 2009 15:57:08 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.cz>
To: Marc Pignat <Marc.Pignat@hevs.ch>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.30-rc4 hid bluetooth not working
In-Reply-To: <49F9C1AD020000BF00029086@mailgw2.hevs.ch>
Message-ID: <alpine.LRH.2.00.0904301556310.2050@twin.jikos.cz>
References: <49F9C1AD020000BF00029086@mailgw2.hevs.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 30 Apr 2009, Marc Pignat wrote:

> My bluetooth keyboard is not working any more in rc4, but was working in 
> rc3.
> Here is the dmesg output, triggered by the first key press on the 
> keyboard, fortunately, this is 100% reproductible (once per boot).

Does reverting f3784d834c7 fix the problem?

-- 
Jiri Kosina
SUSE Labs

