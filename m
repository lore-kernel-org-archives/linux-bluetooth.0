Return-Path: <cyrus@holtmann.org>
Message-ID: <37b5a27ff0dcb3a0c1ec2192b7bf0723.squirrel@www.codeaurora.org>
In-Reply-To: <20100731231454.GB29039@vigoh>
References: <1280514626-22559-1-git-send-email-ingas@codeaurora.org>
    <1280514626-22559-4-git-send-email-ingas@codeaurora.org>
    <20100731231454.GB29039@vigoh>
Date: Sun, 1 Aug 2010 23:18:34 -0700 (PDT)
Subject: Re: [PATCH 3/4] Added command argument "-J" to indicate preference
     of using AMP vs BR/EDR.
From: ingas@codeaurora.org
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org, rshaffer@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> Hi Inga,
>
> * Inga Stotland <ingas@codeaurora.org> [2010-07-30 11:30:25 -0700]:
>
>> Possible values: "require_br_edr", "prefer_amp", "prefer_br_edr"
>> ---
>>  test/l2test.c |   34 +++++++++++++++++++++++++++++++++-
>>  1 files changed, 33 insertions(+), 1 deletions(-)
>
> I would prefer to review and merge the kernel bits first and then go to
> the userspace stuff. Doing that we'll have more sure that the socket
> options won't change.
>
> --
> Gustavo F. Padovan
> http://padovan.org
> --

I don't disagree with you. The kernel bits are coming this week. we will
retest l2test again when kernel stuff is upstreamed. This is just a sample
of how we envision the socket options to control the use of AMP...

And anyway, it takes me up to five iterations to get the style right :)

Regards,

Inga


--
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.




