Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKpoaxMXA--qbXqq=TDW69KcmP=Uiv9nacq2vJ0gTvMNQ@mail.gmail.com>
References: <1335561285-3332-1-git-send-email-lucas.demarchi@profusion.mobi> <CABBYNZKpoaxMXA--qbXqq=TDW69KcmP=Uiv9nacq2vJ0gTvMNQ@mail.gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Sun, 29 Apr 2012 18:40:57 -0300
Message-ID: <CAMOw1v4xkAgNkhMRmLP=Q6ffieL9fAS8Ej3uZEJv7tSp_sU3tg@mail.gmail.com>
Subject: Re: [BlueZ v3 00/10] gdbus: Better D-Bus introspection
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Apr 29, 2012 at 8:52 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Lucas,
>
> On Sat, Apr 28, 2012 at 12:14 AM, Lucas De Marchi
> <lucas.demarchi@profusion.mobi> wrote:
>> This series improves D-Bus introspection in gdbus to ease the life of people
>> using our interface: they can rely on binding generator available for QT, GTK
>> and others.
>>
>> We are doing basically 3 things:
>>
>>  - Adding the name of the arguments in methods and signals
>>  - Adding some annotations:
>>        - deprecated
>>        - no-reply
>>  - Constifying the tables
>>
>
> My only problem with those patches is the use of '[' ']' as
> delimiters, we have first to agree with D-Bus people if this can be
> made reserved as other binding did with their internal delimiters:
>
> (reserved)      109 (ASCII 'm') Reserved for a 'maybe' type compatible with
> the one in GVariant, and must not appear in signatures used on D-Bus
> until specified here
> (reserved)      42 (ASCII '*')  Reserved for use in bindings/implementations
> to represent any single complete type, and must not appear in
> signatures used on D-Bus.
> (reserved)      63 (ASCII '?')  Reserved for use in bindings/implementations
> to represent any basic type, and must not appear in signatures used on
> D-Bus.
> (reserved)      64 (ASCII '@'), 38 (ASCII '&'), 94 (ASCII '^')  Reserved for
> internal use by bindings/implementations, and must not appear in
> signatures used on D-Bus. GVariant uses these type-codes to encode
> calling conventions.
>
> Or we use one of those above.

Since we are using '[' and ']' only internally. I don't see a problem
with that. If D-Bus start using it we can change later. Of course it's
better to convince D-Bus guys to reserve that, but IMO this shouldn't
be a blocker.

>From the chars you suggested, only '@' seems reasonable and I can
change to this char if we agree on it.

Lucas De Marchi
