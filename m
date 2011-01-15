Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <E5842985-417B-4ECF-9611-89E4B288B882@signove.com>
References: <1295018061-5849-1-git-send-email-wagi@monom.org>
 <AANLkTimj_-AjrC16MzTb+6kMjtkXQkbKjOb5NO9jXCSa@mail.gmail.com> <E5842985-417B-4ECF-9611-89E4B288B882@signove.com>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Date: Sat, 15 Jan 2011 15:31:17 +0100
Message-ID: <AANLkTineUhE46UhyFX=MY_-D6PbniHYCz9u7gGF5Cg4Q@mail.gmail.com>
Subject: Re: [PATCH v0 0/2] gdbus introspection fixes
To: =?ISO-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
Cc: Daniel Wagner <wagi@monom.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

2011/1/15 Elvis Pfützenreuter <epx@signove.com>:
>
> On Jan 15, 2011, at 11:05 AM, Jose Antonio Santos Cadenas wrote:
>
>> Hi,
>>
>> 2011/1/14 Daniel Wagner <wagi@monom.org>:
>>> From: Daniel Wagner <daniel.wagner@bmw-carit.de>
>>>
>>> Hi Johan,
>>>
>>> During some connman debug session I found some small hickups in the
>>> introspection code in gdbus. Marcel ask me to check with you first.
>>>
>>
>> I've been thinking about the way that dbus is used in BlueZ and I am
>> concerned about why we don't use glib-dbus instead of dbus directly.
>> This way the dbus specific code will be maintained by glib-dbus.
>>
>> I've thought it several times and I've never said anything because is
>> a big change and as everything was working I preferred not to make
>> noise with this. But now that some bugs appeared we can probably think
>> on this changing the BlueZ DBus code and all the plugins interfaces.
>> The only problem I see is that this will probably require a version
>> change because the way plugins expose their interface will change.
>
>
> One (big) thing that makes me not to like glib-dbus is having to cope with GObject. ALso, it makes certain things more complicated and convoluted than they are in low-level API (e.g passing an array), it is poorly documented, and, incredibly enough, lacks things like the uint16 type.

I've been studying the problem of types, specially uint16. You are
right, they are not implemented, and they never will because GObject
will never support them, nevertheless it is not very important since
other types like unit32 can hold them (read this email thread for more
info http://mail.gnome.org/archives/gtk-devel-list/2001-August/msg00492.html).
The array issue that you mentioned I think is not as complicated, it
uses specific Glib types, you only have to learn how to use them (and
the Glib documentation is quite good).

>
> My feeling goes the other way round: I wish we had the gdbus API *outside* BlueZ, as a library, so any C application could enjoy it.

It's a different view of the problem :), let's see if they are more
opinions out there.

Regards
