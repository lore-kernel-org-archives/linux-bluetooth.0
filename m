Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1345637062.29868.313.camel@pohly-mobl1.fritz.box>
References: <1345533815-5611-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1345537878.29868.185.camel@pohly-mobl1.fritz.box>
	<CABBYNZLUS-BrZ=FN28gLgrA=1vS1JA-exECd3xgjj2EfPrAuyw@mail.gmail.com>
	<1345637062.29868.313.camel@pohly-mobl1.fritz.box>
Date: Wed, 22 Aug 2012 14:42:35 +0200
Message-ID: <CANT-zCVm1AL+1vD7VkrgdO7i80sbe_pWV2B2P5yiGA3+AJ1zuQ@mail.gmail.com>
Subject: Re: [PATCH obexd v0] client-doc: Guarantee prefix in transfer paths
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Patrick Ohly <patrick.ohly@intel.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Patrick,

On Wed, Aug 22, 2012 at 2:04 PM, Patrick Ohly <patrick.ohly@intel.com> wrote:
> On Wed, 2012-08-22 at 14:39 +0300, Luiz Augusto von Dentz wrote:
>> Hi Patrick,
>>
>> On Tue, Aug 21, 2012 at 11:31 AM, Patrick Ohly <patrick.ohly@intel.com> wrote:
>> >> diff --git a/doc/client-api.txt b/doc/client-api.txt
>> >> index 839a78c..7ca65cc 100644
>> >> --- a/doc/client-api.txt
>> >> +++ b/doc/client-api.txt
>> >> @@ -466,7 +466,7 @@ Transfer hierarchy
>> >>
>> >>  Service              org.bluez.obex.client
>> >>  Interface    org.bluez.obex.Transfer
>> >> -Object path  [variable prefix]/{transfer0,transfer1,...}
>> >> +Object path  [variable prefix]/{session0,session1,...}/{transfer0,...}
>> >>
>> >>  Methods              dict GetProperties()
>> >
>> > It would be even better to explicitly mention that the "[variable
>> > prefix]" here is the same as the "[variable prefix]" in the Session.
>> >
>> > Or perhaps change it like this?
>> >
>> > -Object path    [variable prefix]/{transfer0,transfer1,...}
>> > +Object path    [session prefix]/{transfer0,...}
>>
>> Hmm, I prefer the original proposal since that imo looks more clear
>> how the path is formatted, anyway the point here is that the transfers
>> are tied to sessions.
>
> But as Marcel said, "variable prefix" means "no guarantee made about its
> content, none whatsoever". Without knowing Bluez conventions, that was
> also my understand when reading the API description. Assigning some
> other meaning to "variable prefix" would break with developer
> expectations.
>
> Unless the meaning of "variable prefix" gets redefined, "[variable
> prefix]/{session0,session1,...}" still doesn't allow the developer to do
> path_namespace filtering.
>
> How about this:
>
> -Object path  [variable prefix]/{transfer0,transfer1,...}
> +Object path  [prefix]/{session0,session1,...}/{transfer0,...}"
> +             with "prefix" as in the corresponding session

>From my point of view, this is beyond the scope of this patch. The
modification proposed here is in general consistent with the existing
documentation in the mentioned projects, and in particular with the
file being modified (see org.bluez.obex.Message).

I agree that the exact interpretation of "variable prefix" is
undocumented, but fixing that has a broad scope affecting several
projects. See for example org.bluez.Device or org.ofono.VoiceCall.

Personally, I find it relatively obvious that both variable prefixes
match. Otherwise there would be no reference to the session (or
BlueZ-adapter, oFono-modem, etc., depending on the case).

Regarding the lack of support in some bindings, I would say it's not
critical. After all, we're doing an optimization here (reduce number
of context-switches). If someone is using a limited binding, then
there's a performance penalty.

Cheers,
Mikel
