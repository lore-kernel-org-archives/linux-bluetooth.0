Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111212110308.GA12769@x220>
References: <1323686954-11899-1-git-send-email-frederic.danis@linux.intel.com>
	<20111212110308.GA12769@x220>
Date: Mon, 12 Dec 2011 23:24:17 +0200
Message-ID: <CAHMBquUAfvjPas_9RZWf6vG+HDNmmyUY6aFU87GZurH4W5ZZaA@mail.gmail.com>
Subject: Re: [RFC v4 0/6] Add org.bluez.Telephony interface
From: Dmitriy Paliy <dmitriy.paliy@gmail.com>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Danis?=
	<frederic.danis@linux.intel.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

>> Second, third and fourth patches remove the telephony drivers (dummy,
>> maemo5, maemo6 and ofono), functions used by telephony drivers and no
>> more needed methods of org.bluez.Headset interface.
>
> Could you please add these descriptions (and possibly even more thorough
> explanations) to the commit messages of each patch. We really should try
> to avoid one-line commit messages for all but the most trivial patches
> (and even for those I wont complain if you have longer explanations).
> Remember that the summary line should be a very short summary of *what*
> the patch does whereas the rest of the message can elaborate on it (if
> necessary) but more importantly explain *why* the patch was needed and
> how it goes about solving some issue.

I also would be interested to know justification of why removing those
drivers is needed and what it fixes.

Br,
Dmitriy
