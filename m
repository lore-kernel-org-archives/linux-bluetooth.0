Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140405065017.GA3981@t440s.P-661HNU-F1>
References: <20140404230201.5A1BB1009F7@puck.mtv.corp.google.com>
	<20140405065017.GA3981@t440s.P-661HNU-F1>
Date: Mon, 7 Apr 2014 17:38:57 -0700
Message-ID: <CAGXr9JEQe+8WBYL8dt2A5sNJ9jMn+CwTd=U_DixzCFOmXEKU1w@mail.gmail.com>
Subject: Re: [PATCH 1/2] input: Fix input.conf IdleTimeout handling
From: Petri Gynther <pgynther@google.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, Apr 4, 2014 at 11:50 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Petri,
>
> On Fri, Apr 04, 2014, Petri Gynther wrote:
>> IdleTimeout is an optional config item in input.conf. Don't complain
>> if it is not defined. Instead, do the opposite and show its value in
>> debug logs only when it is defined.
>> ---
>>  profiles/input/manager.c | 13 ++++++-------
>>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> Both patches have been applied. I also applied an extra patch to make
> the is_connected functions use bool instead of int.

Thanks for applying these patches. Next, I will send out the revised
"uHIDP: HIDP in userspace" patch, which will address your code review
comments from March 17.

-- Petri

>
> Johan
