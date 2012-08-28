Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1346146381.9800.56.camel@pohly-mobl1.fritz.box>
References: <1345816795-14092-1-git-send-email-luiz.dentz@gmail.com>
	<1345816795-14092-7-git-send-email-luiz.dentz@gmail.com>
	<1346137014.9800.19.camel@pohly-mobl1.fritz.box>
	<CABBYNZKi47Nigic1w=bZonOMf8FM5A=bz+aQoBaM9PnGsALxkg@mail.gmail.com>
	<1346146381.9800.56.camel@pohly-mobl1.fritz.box>
Date: Tue, 28 Aug 2012 15:03:30 +0300
Message-ID: <CABBYNZJRARi7F1LCDn5Zq_6SACrLs0NyP-rEe1oeCSGPJ3_4Jw@mail.gmail.com>
Subject: Re: [PATCH obexd 7/7] client-doc: Update documentation of
 PhonebookAccess interface
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Patrick Ohly <patrick.ohly@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Patrick,

On Tue, Aug 28, 2012 at 12:33 PM, Patrick Ohly <patrick.ohly@intel.com> wrote:
> The user of a specific device would have to know that.
>
> SyncEvolution's "exclude fields" logic is based on the assumption that
> requesting everything, including the custom bits, will result in
> everything the device supports, just like not specifying any filter at
> all.

So there is a possibility that we detect what kind of extra bits the
remote stack implements based on vendor id/product id, but I would
like to avoid specific behavior per device. Besides it seems what we
want is all custom bits.

>> > Should the API spec really specify the full list? IMHO the documentation
>> > should make it clear that the list is not exhaustive - more fields might
>> > be added in future releases of the PBAP standard and obexd, without
>> > changing the obexd API.
>>
>> If we can discover what the bits mean then yes, but unfortunately this
>> is hardcoded in the PBAP spec (see page 30), so we are only defining
>> the one we know the meaning.
>
> It's okay to only document those, but it should still allow the use of
> the other things. Otherwise a user of the API would have to patch obexd
> to use the extensions.
>
>> > In SyncEvolution, I use ListFilterFields() to a) do sanity checks on
>> > user input and to b) build a list of all fields from which the user can
>> > exclude specific fields. Because the field list is not hard-coded, that
>> > will work for fields which are not defined yet.
>>
>> As you can see from the spec this is pretty static so adding a round
>> trip to discover the list sounds wrong to me,
>
> Hard-coding it in SyncEvolution seems equally wrong to me. If the list
> changes, then only obexd needs to be updated, not "obexd +
> SyncEvolution".
>
> It's only one round-trip per session. As a tradeoff between performance
> and being future-proof I think doing the call is worth it.

Fair enough so Im keeping ListFilterFields with original names to be
direct match to the vcard fields, I hope this is really useful for
someone.

-- 
Luiz Augusto von Dentz
