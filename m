Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1305916644.2681.10.camel@aeonflux>
References: <1305620264-22304-1-git-send-email-luiz.dentz@gmail.com>
	<20110520180401.GA23399@dell.amr.corp.intel.com>
	<1305916644.2681.10.camel@aeonflux>
Date: Fri, 20 May 2011 22:17:16 +0300
Message-ID: <BANLkTinK4UZm7LDbGe6jt0LCaiUFikE4hA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Add conf file support
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan, Marcel,

On Fri, May 20, 2011 at 9:37 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Johan,
>
>> > This should reduce the amount of options which normally don't change e=
ach
>> > time obexd is executed.
>> > ---
>> > =A0Makefile.am =A0 =A0| =A0 =A02 +-
>> > =A0plugins/ftp.c =A0| =A0 =A08 ++-
>> > =A0src/main.c =A0 =A0 | =A0176 +++++++++++++++++++++++++++++++++++++++=
-----------------
>> > =A0src/obexd.conf | =A0 19 ++++++
>> > =A04 files changed, 149 insertions(+), 56 deletions(-)
>> > =A0create mode 100644 src/obexd.conf
>>
>> This doesn't compile with gcc 4.6:
>>
>> src/main.c: In function =91main=92:
>> src/main.c:267:12: error: variable =91config=92 set but not used [-Werro=
r=3Dunused-but-set-variable]
>>
>> Please fix and resend.

Gonna fix that,

> didn't we agree on not having an obexd configuration file. That stuff
> should be part of the D-Bus service autostart file.

Well you still have to specify the configuration location on service
file, so it not like bluetoothd which always loads from a specific
location. Besides the point here is to group together configurations
that a normal user should be able to customize, so the configuration
could be on user home e.g. /home/user/.obexd.conf.

--=20
Luiz Augusto von Dentz
Computer Engineer
