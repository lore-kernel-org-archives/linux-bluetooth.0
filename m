Return-Path: <cyrus@holtmann.org>
Message-ID: <c830f11e501a70291cd4b5b3bde2f4a9.squirrel@www.codeaurora.org>
In-Reply-To: <20100803081258.GA5831@jh-x301>
References: <1280576713-1398-1-git-send-email-ingas@codeaurora.org>
    <1280576713-1398-3-git-send-email-ingas@codeaurora.org>
    <20100803081258.GA5831@jh-x301>
Date: Tue, 3 Aug 2010 08:37:05 -0700 (PDT)
Subject: Re: [PATCH 2/6] Clean up code that generates extended inquiry
     response.
From: ingas@codeaurora.org
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>> ---
>>  src/sdpd-service.c |   46
>> ++++++++++++++++++++++++++++++----------------
>>  1 files changed, 30 insertions(+), 16 deletions(-)
>
> So your commit message says two things: "Clean up code..." and "Minor
> fix..". Cleanups and fixes should be in separate patches. Don't be
> afraid of "too small" or trivial patches. As long as a patch contains a
> single logically independent change it's fine.
>

Just a clarification. I will still have to have the "clean up" patch as a
part of this patch set since it relies on the header file with defines
(getting rid of magic numbers). Not sure, if you want me to cut the "fix"
one to be separate patch submission altogether...

Thanks,

Inga

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.



