Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Don't set LE flags in mgmt_start_discovery()
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=US-ASCII
From: Andre Guedes <andre.guedes@openbossa.org>
In-Reply-To: <CAJdJm_MgOZKANxtfqiXWLqrdVCAFPsjDM5WbXr50HrAFgb-C2A@mail.gmail.com>
Date: Thu, 24 Nov 2011 15:44:20 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <35FC761F-6E35-4EB5-AD0C-28DCC8862C3B@openbossa.org>
References: <1321991470-2201-1-git-send-email-andre.guedes@openbossa.org> <20111122215822.GA23550@fusion.localdomain> <70B35869-720B-4A42-8E3C-84679BE805FC@openbossa.org> <20111124182222.GA23469@fusion.localdomain> <CAJdJm_MgOZKANxtfqiXWLqrdVCAFPsjDM5WbXr50HrAFgb-C2A@mail.gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan/Lizardo,

On Nov 24, 2011, at 3:29 PM, Anderson Lizardo wrote:

> Hi,
> 
> On Thu, Nov 24, 2011 at 2:22 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>>> Or do we expect it does a kind of "best effort" and runs the inquiry
>>> only?
>> 
>> Yes, I think that would make most sense from user-space perspective
>> "find all devices you can". As for BR/EDR specific discovery (with no LE
>> bits) or LE specific discovery (BR/EDR bit not set) if the hardware
>> doesn't support the request then in this case I think it would in fact
>> make sense to return an error.
> 
> So in summary, it should fail only if "requested_mask & supported_mask" is 0.

To keep things simpler, IMO we should have some sort of this:

DISCOV_AUTO:     The kernel choose the discovery procedure based on the
                 hardware capabilities.
DISCOV_BREDR:    The kernel runs the BR/EDR discovery procedure
DISCOV_LE:       The kernel runs the LE-Only discovery procedure

BR,

Andre