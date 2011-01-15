Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1295018061-5849-1-git-send-email-wagi@monom.org>
References: <1295018061-5849-1-git-send-email-wagi@monom.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Date: Sat, 15 Jan 2011 14:05:13 +0100
Message-ID: <AANLkTimj_-AjrC16MzTb+6kMjtkXQkbKjOb5NO9jXCSa@mail.gmail.com>
Subject: Re: [PATCH v0 0/2] gdbus introspection fixes
To: Daniel Wagner <wagi@monom.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2011/1/14 Daniel Wagner <wagi@monom.org>:
> From: Daniel Wagner <daniel.wagner@bmw-carit.de>
>
> Hi Johan,
>
> During some connman debug session I found some small hickups in the
> introspection code in gdbus. Marcel ask me to check with you first.
>

I've been thinking about the way that dbus is used in BlueZ and I am
concerned about why we don't use glib-dbus instead of dbus directly.
This way the dbus specific code will be maintained by glib-dbus.

I've thought it several times and I've never said anything because is
a big change and as everything was working I preferred not to make
noise with this. But now that some bugs appeared we can probably think
on this changing the BlueZ DBus code and all the plugins interfaces.
The only problem I see is that this will probably require a version
change because the way plugins expose their interface will change.

> cheers,
> daniel

Regards.

Jose.
