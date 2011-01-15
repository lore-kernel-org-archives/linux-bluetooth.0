Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <E5842985-417B-4ECF-9611-89E4B288B882@signove.com>
References: <1295018061-5849-1-git-send-email-wagi@monom.org>
	<AANLkTimj_-AjrC16MzTb+6kMjtkXQkbKjOb5NO9jXCSa@mail.gmail.com>
	<E5842985-417B-4ECF-9611-89E4B288B882@signove.com>
Date: Sat, 15 Jan 2011 16:34:16 +0200
Message-ID: <AANLkTimSp9bYy24ScN3_fc+dS6wPLPeLgNQsWEQft-7_@mail.gmail.com>
Subject: Re: [PATCH v0 0/2] gdbus introspection fixes
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>,
	Daniel Wagner <wagi@monom.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sat, Jan 15, 2011 at 3:31 PM, Elvis Pfützenreuter <epx@signove.com> wrote:
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

Exactly, GObject code doesn't really helps us, in fact I consider
glib-dbus very bad for using in a daemon/server code. Also there is
another nice thing about gdbus, it keeps us away of wrappers libraries
to use other D-Bus services because our mainloop integration is not
compatible with glib-dbus nor QDbus.

> My feeling goes the other way round: I wish we had the gdbus API *outside* BlueZ, as a library, so any C application could enjoy it

It probably easier to maintain this way, less build dependencies and
no compromise with API changes, besides iirc gdbus name has been taken
by the new GObject binding. If gnome guys could take it as part of
glib's code and build GObject binding on top of our gdbus, IMO that
would be very convenient for everybody.


-- 
Luiz Augusto von Dentz
Computer Engineer
