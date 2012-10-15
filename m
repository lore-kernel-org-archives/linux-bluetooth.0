Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1349807669.27233.103.camel@aeonflux>
References: <1349806556-1978-1-git-send-email-dmp0x7c5@gmail.com>
	<1349806556-1978-2-git-send-email-dmp0x7c5@gmail.com>
	<1349807669.27233.103.camel@aeonflux>
Date: Mon, 15 Oct 2012 16:43:07 +0200
Message-ID: <CABBYNZLYHpWzEOKfv8wKE4s1Yzsd8cZCv38na707yf5XmktXGg@mail.gmail.com>
Subject: Re: [RFC obexd 02/11] build: Add --enable-fuse for gobexfuse
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: =?ISO-8859-2?Q?Micha=B3_Poczwardowski?= <dmp0x7c5@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

On Tue, Oct 9, 2012 at 8:34 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Michal,
>
>>  Makefile.am  |    9 +++++++++
>>  configure.ac |   15 +++++++++++++++
>>  2 files changed, 24 insertions(+), 0 deletions(-)
>>
>> diff --git a/Makefile.am b/Makefile.am
>> index 724dd5d..95b99a6 100644
>> --- a/Makefile.am
>> +++ b/Makefile.am
>> @@ -132,6 +132,15 @@ client_obex_client_SOURCES = $(gdbus_sources) $(gobex_sources) \
>>  client_obex_client_LDADD = @GLIB_LIBS@ @DBUS_LIBS@ @BLUEZ_LIBS@
>>  endif
>>
>> +if FUSE
>> +bin_PROGRAMS = fuse/gobexfuse
>
> I rather call this obexfuse or similar. I don't want to have any "g"
> prefixes in the future anymore.

Are you looking into this? I will probably need more time to look in
detail what you have done, but at least the binary name should be
changed as Marcel suggested.

-- 
Luiz Augusto von Dentz
