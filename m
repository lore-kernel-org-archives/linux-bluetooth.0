Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 1/2] core: don't set BR/EDR support when no flags present
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CA+bD78i-x0O2odFSEGwSKHULg-uZ=rR7f9TTetBVnVFrf2T3LA@mail.gmail.com>
Date: Fri, 4 Apr 2014 08:57:17 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F89968EE-EFA3-4978-904D-5F02988B0785@holtmann.org>
References: <CAHZ1yCmu26xibOaeGUP3HGhp7cvC0eXuviJBRq2VDD0fE6U6SQ@mail.gmail.com> <1396564054-20566-1-git-send-email-scott@netsplit.com> <20140404072528.GA16753@t440s.lan> <CA+bD78i-x0O2odFSEGwSKHULg-uZ=rR7f9TTetBVnVFrf2T3LA@mail.gmail.com>
To: Scott James Remnant <scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

>> One thing to note regarding this first one: this is actually not a
>> problem with current bluetooth-next since there we merge the adv_ind and
>> scan_rsp into a single mgmt device found event. I.e. with such a kernel
>> we will not need to have this extra non-zero flags check. I added an
>> extra code comment to this place so we don't forget to fix it.
>> 
> 
> Makes sense, we're testing with the current
> bluetooth-next/for-upstream tag, and it looks like the
> ADV_IND/SCAN_RSP merging patches aren't submitted yet ;-)
> 
> Won't this mean that the flag checking will be needed on kernels prior
> to 3.15 in either case?

they will be needed for kernels < 3.16 since that will be the earliest kernel this gets merged.

The 3.15 merge window is closed for us. What you have with bluetooth-next/for-upstream is what is merged into 3.15 and from now on only bug fixes are allowed.

Regards

Marcel

