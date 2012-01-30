Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1327952977.1955.160.camel@aeonflux>
References: <1327448862-21964-1-git-send-email-scott@netsplit.com>
	<1327952977.1955.160.camel@aeonflux>
Date: Mon, 30 Jan 2012 13:40:04 -0800
Message-ID: <CA+bD78giy6nJG_iLg_MazNYo4Tgqc+Mpe9aTtSRc1aDYgs6JJw@mail.gmail.com>
Subject: Re: [RFC PATCHv2] autopair: add autopair plugin
From: Scott James Remnant <scott@netsplit.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, keybuk@chromium.org, hadess@hadess.net
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jan 30, 2012 at 11:49 AM, Marcel Holtmann <marcel@holtmann.org> wro=
te:

>> +<!--
>> + =A0The autopair plugin will match devices, following the order of the =
XML
>> + =A0file [1], on any combination of type, OUI, or name.
>> +
>> + =A0[1]: So specific devices should be at the top, and generic ones at =
the bottom,
>> + =A0so settings for specific devices are overridden as expected.
>> +-->
>> +
>> +<!DOCTYPE devices [
>> + =A0 =A0 <!ELEMENT devices (device)+>
>> + =A0 =A0 <!ELEMENT device EMPTY>
>> + =A0 =A0 <!ATTLIST device type (any|mouse|tablet|keyboard|headset|headp=
hones|audio|printer|network) "any">
>> + =A0 =A0 <!ATTLIST device oui CDATA #IMPLIED>
>> + =A0 =A0 <!ATTLIST device name CDATA #IMPLIED>
>> + =A0 =A0 <!ATTLIST device pin CDATA #REQUIRED>
>> +]>
>
> I think we need to have a discussion on this database format first. I
> honestly do not like it at all. It does matching and result handling in
> a single XML element. That seems like a bad idea.
>
> And in addition making pin attribute required and then trying to disable
> PIN with "NULL" magic is something that I rather not have.
>
> I am also wondering why this has to be XML and not simple key-value INI
> style files.
>
I tend to agree ;-)

The reason it couldn't be pure INI-style (at least, parseable by glib)
though is because you then need unique group names for each match,
which is equally urgh to write.

Scott
--=20
Have you ever, ever felt like this?
Had strange things happen? =A0Are you going round the twist?
