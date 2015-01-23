Return-Path: <cyrus@holtmann.org>
Message-ID: <54C2517E.4060209@hurleysoftware.com>
Date: Fri, 23 Jan 2015 08:49:50 -0500
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix "blocking ops when !TASK_RUNNING" with
 sock_accept
References: <1422014582-14391-1-git-send-email-johan.hedberg@gmail.com> <20150123124323.GA15371@t440s.lan>
In-Reply-To: <20150123124323.GA15371@t440s.lan>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 01/23/2015 07:43 AM, Johan Hedberg wrote:
> Szymon pointed out that this change is mostly reverting fixes from Peter
> Hurley from a few years back, i.e. the following commits:
> 
> 	552b0d3cb9ff648aa503011ef50ca24019cd0f5f
> 	f9a3c20aa07462108fc6fd759dea956053f020bb
> 	950e2d51e866623e4c360280aa63b85ab66d3403
> 
> So my patch is probably not the right fix for the issue. Any further
> ideas on how to properly fix this are welcome. I didn't manage to find
> anything similar to our accept_q in other (non-Bluetooth) socket types,
> so I'm a bit lost why exactly it's needed in the first place.

Thanks for letting me know about this; I'll take care of it.

Regards,
Peter Hurley
