Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1306283998.2681.17.camel@aeonflux>
References: <1306253521-30725-1-git-send-email-luiz.dentz@gmail.com>
	<1306283998.2681.17.camel@aeonflux>
Date: Wed, 25 May 2011 09:14:17 +0300
Message-ID: <BANLkTikKXPx-FgPB5nR6H9LKVTHGdLaggQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Add conf file support
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, May 25, 2011 at 3:39 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Luiz,
>
>> This should reduce the amount of options which normally don't change
>> each time obexd is executed.
>> ---
>> =A0Makefile.am =A0 | =A0 =A02 +-
>> =A0plugins/ftp.c | =A0 =A08 ++-
>> =A0src/main.c =A0 =A0| =A0173 +++++++++++++++++++++++++++++++++++++++---=
--------------
>> =A03 files changed, 127 insertions(+), 56 deletions(-)
>
> I do not want to have config file support for obexd.
>

Alright, then I will just update the documentation of the current
options to be more detailed and remove the old configuration file that
still exists on the repository.


--=20
Luiz Augusto von Dentz
Computer Engineer
