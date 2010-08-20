Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100820125948.GA16376@jh-x301>
References: <AANLkTin+CRVwKgC+UaDK6q4PRrw9eGi3c7++PSxWODcu@mail.gmail.com>
	<20100820125948.GA16376@jh-x301>
Date: Fri, 20 Aug 2010 14:32:06 +0100
Message-ID: <AANLkTi=YeYGdojmXt-0gRdXPafsupP6CZc4r7dj2ufAg@mail.gmail.com>
Subject: Re: [PATCH] Remove dup VCard2.1 SDP format for OPP
From: Tom Counihan <tomcounihan@googlemail.com>
To: Tom Counihan <tomcounihan@googlemail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Aug 20, 2010 at 1:59 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Tom,
>
> On Fri, Aug 20, 2010, Tom Counihan wrote:
>> OPP SDP record appears to have a duplicate
>> entry for Supported Formats List.
>>
>> ---
>>  plugins/opp.c |    1 -
>>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> The patch looks fine but doesn't apply against latest git:
>
> error: patch failed: plugins/opp.c:83
> error: plugins/opp.c: patch does not apply
> Patch failed at 0001 Remove dup VCard2.1 SDP format for OPP
>
> Could you make sure that it applies cleanly to latest git and then
> resend? Thanks.

I'll send again - I'm assuming that the cause here is we had a race
condition between inbound patches?
>
> Johan
>
