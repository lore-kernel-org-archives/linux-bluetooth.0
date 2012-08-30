Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_NXvcfYeCT5gaYpDD0Oshk89ohUaj5BJ66CL29YwD7UgQ@mail.gmail.com>
References: <1346332740-29319-1-git-send-email-anderson.lizardo@openbossa.org>
 <1346339333.23377.10.camel@aeonflux> <CAJdJm_NXvcfYeCT5gaYpDD0Oshk89ohUaj5BJ66CL29YwD7UgQ@mail.gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Thu, 30 Aug 2012 17:02:43 -0300
Message-ID: <CAMOw1v7bbYbhL59-imjzppztpC+e9+enTWx4nnWeVAT0zjW4Ag@mail.gmail.com>
Subject: Re: [PATCH BlueZ] build: Use AC_USE_SYSTEM_EXTENSIONS for POSIX/C extensions
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Aug 30, 2012 at 12:26 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Marcel,
>
> On Thu, Aug 30, 2012 at 11:08 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> Hi Anderson,
>>
>>> Using this macro in configure.ac enables certain extensions that BlueZ
>>> currently depends on. The macro is recommended instead of defining
>>> _GNU_SOURCE on each C file.
>>
>> what is the advantage of this. I am actually fine with using _GNU_SOURCE
>> in the C files. It is according to the man pages.
>
> The only advantage I see is that we don't have to worry about
> reviewing these defines as the symbols get incorporated in newer
> standards. For instance, this patch was brought up because O_CLOEXEC
> does not exist on POSIX.1-2001, but was incorporated POSIX.1-2008, so
> for newer systems _GNU_SOURCE is not necessary for it anymore, but for
> some (still maintained) distros it is.
>
> Sometimes we remove code that used these extensions, and simply forget
> the _GNU_SOURCE there as well.

And also forget to add it. Then 3 months later comes a patch to fix it
by adding the definition.

Using the autofoo macro we stop the build-fix patches for things like this.


That is: it removes code, it's more future-proof and it has no
downsides. So, what's the point of not using it?


Some months ago I sent a patch to also remove a lot of dumb "#include
config.h". It has the same reasoning behind it: remove code and be
more future-proof. It was for connman, but if you are interested I can
send it to bluez/ofono/etc too -
http://permalink.gmane.org/gmane.linux.network.connman/7310


Lucas De Marchi
