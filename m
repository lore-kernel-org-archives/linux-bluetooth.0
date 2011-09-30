Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMOw1v7ZVnyTJGZZXZJis8Wj5EbEv-cY5SuFsxRF5YnEdA6iSg@mail.gmail.com>
References: <1317316050-12855-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1317316050-12855-4-git-send-email-lucas.demarchi@profusion.mobi>
	<CABBYNZ+qTbbhLsO-GXdi9pvS9ep7FJ+yhYfS_bbCqup4=1Dk5Q@mail.gmail.com>
	<CAMOw1v7ZVnyTJGZZXZJis8Wj5EbEv-cY5SuFsxRF5YnEdA6iSg@mail.gmail.com>
Date: Fri, 30 Sep 2011 12:42:24 +0300
Message-ID: <CABBYNZ+pe5i4z7HE_-6jKgQ9LQ++26FJjNbaXpyQ6_1dJoVf3w@mail.gmail.com>
Subject: Re: [PATCH 3/3] AVRCP: allow track to be un-selected
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Thu, Sep 29, 2011 at 10:54 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> Hi Luiz,
>
>> I have this more or less covered in mine yet to be published changes
>> to have player registration per adapter, so I would like to ask you to
>> hold this a bit until I finish to avoid to many conflicts.
>
> It's not a nice thing asking to wait for unpublished code. Do you have
> an ETA? The code above is a very basic thing, necessary for people
> doing AVRCP 1.3 certification.

This should be ready by next week to be tested at UPF, also I would
suggest not doing any official qualification until we do proper IOP
testing with this code, first because it may pass qualification but
may not work properly with many platforms, second there is still no
release that contains this code and third we are still doing
modification to its API.

> I already have other patches queued here:
>  - TRACK_REACHED_END event;
>  - TRACK_REACHED_START event;
>  - PDU_CONTINUING / PDU_ABORT (this was already sent once, but I will
> refactor it as requested)
>
> So there are already conflicts and they will continue to exist if we
> don't sync what we are doing.

Im sorry if this is a bad timing , but I really want to run IOP with
an interface per adapter and not the one used by test-player. In my
experience the API definition is almost always more important than the
protocol itself, it is much easier to fix the latter when a problem is
detected than having to break API if that doesn't fulfill some
requirements.

-- 
Luiz Augusto von Dentz
