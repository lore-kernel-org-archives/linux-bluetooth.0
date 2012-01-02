Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1325180758.1965.291.camel@aeonflux>
References: <1324408558-24653-1-git-send-email-padovan@profusion.mobi>
	<1324408558-24653-2-git-send-email-padovan@profusion.mobi>
	<1324414866.1965.133.camel@aeonflux>
	<CABBYNZ+w0hqxHW2j4JrY_LQ8tG_aEy+Jk1TEXpixKo4aMbCQRA@mail.gmail.com>
	<1325180758.1965.291.camel@aeonflux>
Date: Mon, 2 Jan 2012 15:16:31 +0200
Message-ID: <CABBYNZ+CAnxi18+6wwWxpy61tdC0fyF1zi6PWz03q1+5NwtZFA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: Remove HCI_PRIO_MAX from ctrl cdm in RFCOMM
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Dec 29, 2011 at 7:45 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
>>
>> I guess you guys don't remember, but I tried to explain why the
>> priority has to be set even for RFCOMM, any frame sent by the kernel
>> with a timeout needs to be scheduled as soon as possible otherwise it
>> may timeout due to quote being consumed by other channels with higher
>> priority, so in this case if an A2DP stream in ongoing you will never
>> be able to complete a RFCOMM connection because there wont be enough
>> quote to schedule them before they timeout (usually 10 out 10 attempt
>> end up like that in my setup).
>>
>> Perhaps if we assign a dedicated queue/hci_chan per RFCOMM socket that
>> should get rid of this resetting sk_priority on every frame, but that
>> means not depending on socket API at all to pass frames from RFCOMM to
>> L2CAP, so we need an API to create L2CAP frames directly in RFCOMM
>> modules and queue them in its hci_chan.
>
> yes, we need exactly this. Not using the L2CAP socket and interfacing
> with L2CAP directly is a good idea. Same came up with A2MP as well.

Right, so I will work on this next, but in the meantime I think we
should keep the current logic (it doesn't seems to cause any problem
although the locking is pretty bad) until we got a proper solution and
at least it is able to complete connections.

-- 
Luiz Augusto von Dentz
