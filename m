Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1351028768.1785.57.camel@aeonflux>
References: <1351011241-32515-1-git-send-email-johan.hedberg@gmail.com>
	<1351011241-32515-3-git-send-email-johan.hedberg@gmail.com>
	<1351018956.1785.45.camel@aeonflux>
	<CAJdJm_OLBgRVBFLD4sEp+OK-qkF_-CXXzuZOCAyiaD+TVMOYKQ@mail.gmail.com>
	<20121023204809.GB12042@x220.ger.corp.intel.com>
	<1351028768.1785.57.camel@aeonflux>
Date: Wed, 24 Oct 2012 08:11:09 -0400
Message-ID: <CAJdJm_PgxH19t6b0XxmKCa=he8n9gsDro0eRPTV10x+RM9tHNA@mail.gmail.com>
Subject: Re: [PATCH 2/7] Bluetooth: mgmt: Restrict BR/EDR settings to
 BR/EDR-only adapters
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Oct 23, 2012 at 5:46 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> That is why I like the explanation above, if we set ourselves as
> peripheral, then we are peripheral and everything else is out of the
> question. So either LE is enabled and we act as central or we are acting
> as peripheral.
>
> So broadcaster and observer are extra features on top of central. For me
> that means we have treat them independent. How much you can be
> broadcaster and observer and central at the same time is then again a
> different question that we need to answer.

So do you suggest we keep Broadcaster/Observer as separate settings
(which actually we prefer, given that we have been working on
supporting those modes for BR/EDR only adapters, by using EIR for
broadcasting data allowed on EIR, such as Manufacturer Specific Data,
and parsing them from Device Found mgmt event when on Observer mode),
and keep "Set Low Energy" setting just for Central/Peripheral modes?

Regards
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
