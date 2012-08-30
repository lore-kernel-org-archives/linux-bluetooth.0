Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1346339333.23377.10.camel@aeonflux>
References: <1346332740-29319-1-git-send-email-anderson.lizardo@openbossa.org>
	<1346339333.23377.10.camel@aeonflux>
Date: Thu, 30 Aug 2012 11:26:20 -0400
Message-ID: <CAJdJm_NXvcfYeCT5gaYpDD0Oshk89ohUaj5BJ66CL29YwD7UgQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] build: Use AC_USE_SYSTEM_EXTENSIONS for POSIX/C extensions
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Aug 30, 2012 at 11:08 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Anderson,
>
>> Using this macro in configure.ac enables certain extensions that BlueZ
>> currently depends on. The macro is recommended instead of defining
>> _GNU_SOURCE on each C file.
>
> what is the advantage of this. I am actually fine with using _GNU_SOURCE
> in the C files. It is according to the man pages.

The only advantage I see is that we don't have to worry about
reviewing these defines as the symbols get incorporated in newer
standards. For instance, this patch was brought up because O_CLOEXEC
does not exist on POSIX.1-2001, but was incorporated POSIX.1-2008, so
for newer systems _GNU_SOURCE is not necessary for it anymore, but for
some (still maintained) distros it is.

Sometimes we remove code that used these extensions, and simply forget
the _GNU_SOURCE there as well.

It is just a minor build system simplification, if you think it is not
worthy, please reconsider my original patch that adds _GNU_SOURCE just
where it is necessary.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
