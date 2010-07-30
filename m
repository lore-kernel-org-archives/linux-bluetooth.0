Return-Path: <cyrus@holtmann.org>
Message-ID: <6c8d968ad4264d852b7dfc70b813cf70.squirrel@www.codeaurora.org>
In-Reply-To: <1278696935.10421.139.camel@localhost.localdomain>
References: <1278540518-18620-1-git-send-email-ingas@codeaurora.org>
    <1278540518-18620-2-git-send-email-ingas@codeaurora.org>
    <1278609452.10421.31.camel@localhost.localdomain>
    <4C375658.10904@codeaurora.org>
    <1278696935.10421.139.camel@localhost.localdomain>
Date: Fri, 30 Jul 2010 12:13:33 -0700 (PDT)
Subject: Re: Copyrights and Legal header 
From: ingas@codeaurora.org
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: "Ron Shaffer" <rshaffer@codeaurora.org>,
 "Inga Stotland" <ingas@codeaurora.org>,
 linux-bluetooth@vger.kernel.org,
 johan.hedberg@gmail.com
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> Hi Ron,
>
>> >>  void register_public_browse_group(void)
>> >> diff --git a/src/sdpd.h b/src/sdpd.h
>> >> index e93b0b6..8fd8bbe 100644
>> >> --- a/src/sdpd.h
>> >> +++ b/src/sdpd.h
>> >> @@ -6,6 +6,7 @@
>> >>   *  Copyright (C) 2002-2003  Maxim Krasnyansky <maxk@qualcomm.com>
>> >>   *  Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
>> >>   *  Copyright (C) 2002-2003  Stephen Crane
>> <steve.crane@rococosoft.com>
>> >> + *  Copyright (C) 2010, Code Aurora Forum. All rights reserved.
>> >
>> > I prefer that we actually see major code contributions that justify a
>> > copyright here before you start adding it. And so let the maintainers
>> > worry about that later on. I don't wanna see just random copyright
>> > additions for obvious fixes or changes that are most likely even
>> derived
>> > from existing code.
>> >
>>
>> I'm unsure of the reasoning unless the idea is to add copyright markings
>> to show attribution and level of contribution. In our case it's just a
>> legal marking.
>>
>> If the reasoning for adding or not adding is the former, does this not
>> rise to that level, and for my own education and future reference why
>> not?
>
> we normally automatically add the copyright for companies or individual
> when they make large contributions. Not just small extensions or fixes
> where it is questionable if they are copyrightable anyway.
>
> For just tracking contributions, we have GIT :)
>
> Regards
>
> Marcel
>

A quick question re Copyrights and Legal header. If I am adding a
completely new file in bluez user space, what are the guidelines for the
license and copyrights header?

Thank you,

Inga
