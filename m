Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1392893523.5772.2.camel@pohly-mobl1.fritz.box>
References: <1392393184-15266-1-git-send-email-luiz.dentz@gmail.com>
	<1392393184-15266-8-git-send-email-luiz.dentz@gmail.com>
	<1392714551.5951.275.camel@pohly-mobl1.fritz.box>
	<CABBYNZ+-hu0G6cja-uBWPFuywj7S+bBDhitNoBhUnFnTFjYDcA@mail.gmail.com>
	<1392742461.6118.25.camel@pohly-mobl1.fritz.box>
	<CABBYNZL82SJPZws+b0syb0nx8OVHCwfB4Tr3cDem9JWBvy5oCQ@mail.gmail.com>
	<1392893523.5772.2.camel@pohly-mobl1.fritz.box>
Date: Thu, 20 Feb 2014 14:09:15 +0200
Message-ID: <CABBYNZLzNh7qeaQQ_wvG6UwEQW6BG7qxY+E_BhOQFrZbXT_0OQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 8/8] doc/obex-api: Update documentation
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Patrick Ohly <patrick.ohly@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Patrick,

On Thu, Feb 20, 2014 at 12:52 PM, Patrick Ohly <patrick.ohly@intel.com> wrote:
> On Wed, 2014-02-19 at 19:11 +0200, Luiz Augusto von Dentz wrote:
>> Hi Patrick,
>>
>> On Tue, Feb 18, 2014 at 6:54 PM, Patrick Ohly <patrick.ohly@intel.com> wrote:
>> > On Tue, 2014-02-18 at 11:30 +0200, Luiz Augusto von Dentz wrote:
>> >> Hi Patrick,
>> >>
>> >> On Tue, Feb 18, 2014 at 11:09 AM, Patrick Ohly <patrick.ohly@intel.com> wrote:
>> > I think I would prefer to *not* get errors when Suspend() is called on
>> > an already suspended transfer or when Resume() is called on a running
>> > transfer. The rationale is that the caller will typically only care
>> > about the end result and not so much whether it was the one who
>> > triggered the change. If we remove NotInProgress resp. InProgress errors
>> > from the API, then such a caller can treat all errors as fatal problem,
>> > without having to check the exact error.
>>
>> Actually the NotInProgress error is for transfer queued, I guess for
>> this case it makes sense to return an error since otherwise we would
>> have to queue commands to be send when the transfer becomes active I
>> believe this should probably be considered an error.
>
> Agreed, if suspending can't be done, then an error needs to be returned.
>
> It would be good to add information about the error to the
> documentation, so that apps get at least some hint what they are
> supposed to do in case of such an error (like aborting the queued
> transfer (most likely) or waiting for it to start before suspending it
> (seems a bit odd, but perhaps it is useful sometimes)).

I went ahead and pushed with a note about NotInProgress error, if we
figure that is not enough we can reword it to be more clear, but at
least in terms of API and functionality it should be fine.


-- 
Luiz Augusto von Dentz
