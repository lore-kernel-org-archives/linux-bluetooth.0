Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMOw1v4hsQa3VNT+qaF9eZPiu88G7cyd0jwTR=Bd1Pnj3yyQWw@mail.gmail.com>
References: <1354193256-30610-1-git-send-email-mikel.astiz.oss@gmail.com>
	<CAMOw1v4hsQa3VNT+qaF9eZPiu88G7cyd0jwTR=Bd1Pnj3yyQWw@mail.gmail.com>
Date: Fri, 30 Nov 2012 12:38:51 +0100
Message-ID: <CANT-zCUaYiwyS9GaUd==8rASv3KF0YQoUT5JynhDtpKMeyMqJg@mail.gmail.com>
Subject: Re: [RFC v2 00/15] Manager/Adapter transition to ObjectManager
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Thu, Nov 29, 2012 at 7:12 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> On Thu, Nov 29, 2012 at 10:47 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
>> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>>
>> Note that this patchset requires the gdbus fix affecting were the ObjectManager gets registered, as submitted by Luiz.
>
> Those were replaced with my patches today.  Do my patches do what you need?

Yes, the patches (which are now pushed) do the job.

So at this point there is no other dependency and thus these patches
can be applied and tested with upstream master.

Cheers,
Mikel
