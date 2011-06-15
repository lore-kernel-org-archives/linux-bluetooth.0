Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1308136231.2518.5.camel@aeonflux>
References: <20110614211507.GB27437@piper>
	<20110614213143.GD2613@joana>
	<1308136231.2518.5.camel@aeonflux>
Date: Wed, 15 Jun 2011 15:05:18 +0300
Message-ID: <BANLkTinu9j=6QWYcQUrPeEnB0MMgUYM7zg@mail.gmail.com>
Subject: Re: Per-project patch prefixes
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jun 15, 2011 at 2:10 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Gustavo,
>
>> > Now, this list receives patches for at least 3 different projects, so =
how
>> > about using different subject prefixes for each priject? The first thi=
ng
>> > that comes to mind is this:
>>
>> This is a great idea. It can a lot when identifying patches, and you can=
 do
>> this to the project's .git/config:
>>
>> [format]
>> =A0 =A0 =A0 =A0 subjectprefix =3D "bluetooth-next"
>
> as long as patches come in as [PATCH bluetooth-next v2] or something
> similar I am fine with this. I want the [PATCH ...] prefix kept alive
> since that is one thing that git did right from the beginning.

So an obexd patch would look like this:

[PATCH obexd 1/4] Add initial support for OBEX Action command

--=20
Luiz Augusto von Dentz
Computer Engineer
