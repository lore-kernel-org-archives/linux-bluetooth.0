Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1306352882.2681.43.camel@aeonflux>
References: <1306253521-30725-1-git-send-email-luiz.dentz@gmail.com>
	<1306283998.2681.17.camel@aeonflux>
	<BANLkTikKXPx-FgPB5nR6H9LKVTHGdLaggQ@mail.gmail.com>
	<1306352882.2681.43.camel@aeonflux>
Date: Wed, 25 May 2011 22:58:22 +0300
Message-ID: <BANLkTi=1w=_7aMBu0t-NRVu8c1wMrhebjg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Add conf file support
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, May 25, 2011 at 10:48 PM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
> Hi Luiz,
>
>> >> This should reduce the amount of options which normally don't change
>> >> each time obexd is executed.
>> >> ---
>> >> =A0Makefile.am =A0 | =A0 =A02 +-
>> >> =A0plugins/ftp.c | =A0 =A08 ++-
>> >> =A0src/main.c =A0 =A0| =A0173 +++++++++++++++++++++++++++++++++++++++=
-----------------
>> >> =A03 files changed, 127 insertions(+), 56 deletions(-)
>> >
>> > I do not want to have config file support for obexd.
>> >
>>
>> Alright, then I will just update the documentation of the current
>> options to be more detailed and remove the old configuration file that
>> still exists on the repository.
>
> I don't know how much Johan mentioned on IRC, but what we should be
> doing is by default enable all compiled in plugins and then use -p and
> -P command line switches to control what gets enabled and what not. And
> that can be done easily in the D-Bus autostart file.

That one I did in a separated patch, 1/3 in the new series I just have
sent today, it should work just like connman, ofono and BlueZ do.


--=20
Luiz Augusto von Dentz
Computer Engineer
