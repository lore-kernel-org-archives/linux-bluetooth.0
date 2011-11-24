Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111124182222.GA23469@fusion.localdomain>
References: <1321991470-2201-1-git-send-email-andre.guedes@openbossa.org>
	<20111122215822.GA23550@fusion.localdomain>
	<70B35869-720B-4A42-8E3C-84679BE805FC@openbossa.org>
	<20111124182222.GA23469@fusion.localdomain>
Date: Thu, 24 Nov 2011 14:29:43 -0400
Message-ID: <CAJdJm_MgOZKANxtfqiXWLqrdVCAFPsjDM5WbXr50HrAFgb-C2A@mail.gmail.com>
Subject: Re: [PATCH] Don't set LE flags in mgmt_start_discovery()
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Nov 24, 2011 at 2:22 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> Or do we expect it does a kind of "best effort" and runs the inquiry
>> only?
>
> Yes, I think that would make most sense from user-space perspective
> "find all devices you can". As for BR/EDR specific discovery (with no LE
> bits) or LE specific discovery (BR/EDR bit not set) if the hardware
> doesn't support the request then in this case I think it would in fact
> make sense to return an error.

So in summary, it should fail only if "requested_mask & supported_mask" is 0.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
