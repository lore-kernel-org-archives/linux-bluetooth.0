Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1392742461.6118.25.camel@pohly-mobl1.fritz.box>
References: <1392393184-15266-1-git-send-email-luiz.dentz@gmail.com>
	<1392393184-15266-8-git-send-email-luiz.dentz@gmail.com>
	<1392714551.5951.275.camel@pohly-mobl1.fritz.box>
	<CABBYNZ+-hu0G6cja-uBWPFuywj7S+bBDhitNoBhUnFnTFjYDcA@mail.gmail.com>
	<1392742461.6118.25.camel@pohly-mobl1.fritz.box>
Date: Wed, 19 Feb 2014 19:11:41 +0200
Message-ID: <CABBYNZL82SJPZws+b0syb0nx8OVHCwfB4Tr3cDem9JWBvy5oCQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 8/8] doc/obex-api: Update documentation
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Patrick Ohly <patrick.ohly@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Patrick,

On Tue, Feb 18, 2014 at 6:54 PM, Patrick Ohly <patrick.ohly@intel.com> wrote:
> On Tue, 2014-02-18 at 11:30 +0200, Luiz Augusto von Dentz wrote:
>> Hi Patrick,
>>
>> On Tue, Feb 18, 2014 at 11:09 AM, Patrick Ohly <patrick.ohly@intel.com> wrote:
>> > On Fri, 2014-02-14 at 17:53 +0200, Luiz Augusto von Dentz wrote:
>> >> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>> >>
>> >> This adds Suspend and Resume methods and 'suspended' value as status in
>> >> the Transfer interface documentation.
>> >> ---
>> >>  doc/obex-api.txt | 18 ++++++++++++++++--
>> >>  1 file changed, 16 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/doc/obex-api.txt b/doc/obex-api.txt
>> >> index 1f22fea..0f57ce1 100644
>> >> --- a/doc/obex-api.txt
>> >> +++ b/doc/obex-api.txt
>> >> @@ -90,12 +90,26 @@ Methods           void Cancel()
>> >>                                        org.bluez.obex.Error.InProgress
>> >>                                        org.bluez.obex.Error.Failed
>> >>
>> >> +             void Suspend()
>> >> +
>> >> +                     Suspend transference.
>> >> +
>> >> +                     Possible errors: org.bluez.obex.Error.NotAuthorized
>> >> +                                      org.bluez.obex.Error.NotInProgress
>> >> +
>> >> +             void Resume()
>> >> +
>> >> +                     Resume transference.
>> >> +
>> >> +                     Possible errors: org.bluez.obex.Error.NotAuthorized
>> >> +                                      org.bluez.obex.Error.NotInProgress
>> >                                                                 ^^^^^^^^^^^^^
>> >
>> > Should this be a NotSuspended error? Or is it not an error to resume a
>> > transfer which is currently not suspended?
>>
>> Hmm, I would go for InProgress like in Cancel although now that you
>> mentioned we could perhaps ignore such errors if you don't see any
>> value on those.
>
> I think I would prefer to *not* get errors when Suspend() is called on
> an already suspended transfer or when Resume() is called on a running
> transfer. The rationale is that the caller will typically only care
> about the end result and not so much whether it was the one who
> triggered the change. If we remove NotInProgress resp. InProgress errors
> from the API, then such a caller can treat all errors as fatal problem,
> without having to check the exact error.

Actually the NotInProgress error is for transfer queued, I guess for
this case it makes sense to return an error since otherwise we would
have to queue commands to be send when the transfer becomes active I
believe this should probably be considered an error.


-- 
Luiz Augusto von Dentz
