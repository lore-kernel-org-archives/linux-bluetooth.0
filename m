Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1304704468.2427.1.camel@novo.hadess.net>
References: <1304620983.16101.16.camel@novo.hadess.net> <BANLkTinBw-qXODF03rtcW+M3GEjK7yC3NQ@mail.gmail.com>
 <1304693325.16101.34.camel@novo.hadess.net> <BANLkTim+KAu03JSJ--wkYGs0a9kD6hzC7w@mail.gmail.com>
 <1304704211.2427.0.camel@novo.hadess.net> <1304704468.2427.1.camel@novo.hadess.net>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Fri, 10 Jun 2011 03:02:16 -0300
Message-ID: <BANLkTikMkaBroKb670vvWCarP-ayyKO5YA@mail.gmail.com>
Subject: Re: Warning fixes for GCC 4.6
To: Bastien Nocera <hadess@hadess.net>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, May 6, 2011 at 2:54 PM, Bastien Nocera <hadess@hadess.net> wrote:
> On Fri, 2011-05-06 at 18:50 +0100, Bastien Nocera wrote:
>> On Fri, 2011-05-06 at 20:43 +0300, Luiz Augusto von Dentz wrote:
>> > Hi,
>> >
>> > On Fri, May 6, 2011 at 5:48 PM, Bastien Nocera <hadess@hadess.net> wrote:
>> > >> @@ -250,7 +250,7 @@ static int decode_key(const char *str)
>> > >>  static void send_event(int fd, uint16_t type, uint16_t code, int32_t value)
>> > >>  {
>> > >>       struct uinput_event event;
>> > >> -     int err;
>> > >> +     int __attribute__((__unused__)) err;
>> > >>
>> > >>       memset(&event, 0, sizeof(event));
>> > >>       event.type      = type;
>> > >>
>> > >> Can't we just removed err here, Im afraid using
>> > >> __attribute__((__unused__)) is not a good practice and we should try
>> > >> to avoid using it.
>> > >
>> > > We either get a warning that the return value is unused, or that we
>> > > should be checking the return value. Which one do you prefer?
>> >
>> > I guess I would prefer checking the return properly if you don't mind.
>>
>> Done.
>>
>> > Also like Gustavo mentioned, it would be great to have the gdbus
>> > changes in a separate patch so we can apply to other project which
>> > uses it.
>>
>> Done.
>
> And without the now unnecessary changes to btio/btio.c (flushable
> problem is already fixed).
>

Any chance of landing these patches? There are already more places
needing fixes. I can send them once these go in.


Lucas De Marchi
