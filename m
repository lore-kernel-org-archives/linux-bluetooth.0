Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140404072528.GA16753@t440s.lan>
References: <CAHZ1yCmu26xibOaeGUP3HGhp7cvC0eXuviJBRq2VDD0fE6U6SQ@mail.gmail.com>
	<1396564054-20566-1-git-send-email-scott@netsplit.com>
	<20140404072528.GA16753@t440s.lan>
Date: Fri, 4 Apr 2014 08:20:39 -0700
Message-ID: <CA+bD78i-x0O2odFSEGwSKHULg-uZ=rR7f9TTetBVnVFrf2T3LA@mail.gmail.com>
Subject: Re: [PATCH 1/2] core: don't set BR/EDR support when no flags present
From: Scott James Remnant <scott@netsplit.com>
To: Scott James Remnant <scott@netsplit.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Apr 4, 2014 at 12:25 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:

> One thing to note regarding this first one: this is actually not a
> problem with current bluetooth-next since there we merge the adv_ind and
> scan_rsp into a single mgmt device found event. I.e. with such a kernel
> we will not need to have this extra non-zero flags check. I added an
> extra code comment to this place so we don't forget to fix it.
>

Makes sense, we're testing with the current
bluetooth-next/for-upstream tag, and it looks like the
ADV_IND/SCAN_RSP merging patches aren't submitted yet ;-)

Won't this mean that the flag checking will be needed on kernels prior
to 3.15 in either case?

Scott
-- 
Have you ever, ever felt like this?
Had strange things happen?  Are you going round the twist?
