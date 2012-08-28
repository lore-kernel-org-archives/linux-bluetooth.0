Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1346137014.9800.19.camel@pohly-mobl1.fritz.box>
References: <1345816795-14092-1-git-send-email-luiz.dentz@gmail.com>
	<1345816795-14092-7-git-send-email-luiz.dentz@gmail.com>
	<1346137014.9800.19.camel@pohly-mobl1.fritz.box>
Date: Tue, 28 Aug 2012 10:52:27 +0300
Message-ID: <CABBYNZKi47Nigic1w=bZonOMf8FM5A=bz+aQoBaM9PnGsALxkg@mail.gmail.com>
Subject: Re: [PATCH obexd 7/7] client-doc: Update documentation of
 PhonebookAccess interface
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Patrick Ohly <patrick.ohly@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Patrick,

On Tue, Aug 28, 2012 at 9:56 AM, Patrick Ohly <patrick.ohly@intel.com> wrote:
> On Fri, 2012-08-24 at 16:59 +0300, Luiz Augusto von Dentz wrote:
>> +                             array{string} Fields:
>> +
>> +                                     Item vcard fields, default is all
>> +                                     values.
>> +
>> +                                     Possible values:
>> +
>> +                                             "VERSION",
>> +                                             "FN",
>> +                                             "N",
>> +                                             "PHOTO",
>> +                                             "BDAY",
>> +                                             "ADR",
>> +                                             "LABEL",
>> +                                             "TEL",
>> +                                             "EMAIL",
>> +                                             "MAILER",
>> +                                             "TZ",
>> +                                             "GEO",
>> +                                             "TITLE",
>> +                                             "ROLE",
>> +                                             "LOGO",
>> +                                             "AGENT",
>> +                                             "ORG",
>> +                                             "NOTE",
>> +                                             "REV",
>> +                                             "SOUND",
>> +                                             "URL",
>> +                                             "UID",
>> +                                             "KEY",
>> +                                             "NICKNAME",
>> +                                             "CATEGORIES",
>> +                                             "PROID",
>> +                                             "CLASS",
>> +                                             "SORT-STRING",
>> +                                             "X-IRMC-CALL-DATETIME"
>
> What about selecting the bits which don't have a named property
> associated with them? They are reported by ListFilterFields() and thus
> seem to be supported.

ListFilterFields is removed in this case, anyway setting bits is still
supported but Im not so sure I would keep it since apparently there is
no way to discover what they mean which could be different from stack
to stack.

> Should the API spec really specify the full list? IMHO the documentation
> should make it clear that the list is not exhaustive - more fields might
> be added in future releases of the PBAP standard and obexd, without
> changing the obexd API.

If we can discover what the bits mean then yes, but unfortunately this
is hardcoded in the PBAP spec (see page 30), so we are only defining
the one we know the meaning.

> In SyncEvolution, I use ListFilterFields() to a) do sanity checks on
> user input and to b) build a list of all fields from which the user can
> exclude specific fields. Because the field list is not hard-coded, that
> will work for fields which are not defined yet.

As you can see from the spec this is pretty static so adding a round
trip to discover the list sounds wrong to me, but perhaps you have
some way to discover the meaning of the bits not defined in the spec?

-- 
Luiz Augusto von Dentz
