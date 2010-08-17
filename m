Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTimyr6JRKNndW-PmW-NPkVj0fJQ8eTNJmD9RqOR6@mail.gmail.com>
References: <AANLkTimnLyeZqNvNecognr_U9alZiC9bKNUOWjX9H_Hq@mail.gmail.com>
	<1274360918.27274.3302.camel@localhost.localdomain>
	<AANLkTik3d0rY2QNrhevwzPz28VQwKuj7A5s-9l152H4Y@mail.gmail.com>
	<AANLkTimW1SmfZ+j=F7kTSwosdz=kh+g9ofcqdTeGE7CB@mail.gmail.com>
	<20100817035921.GA5900@vigoh>
	<AANLkTimyr6JRKNndW-PmW-NPkVj0fJQ8eTNJmD9RqOR6@mail.gmail.com>
Date: Tue, 17 Aug 2010 13:46:26 +0530
Message-ID: <AANLkTimM9g260uvEDS2TR1PgOMHihXQ4t3z1UHcQ=qR=@mail.gmail.com>
Subject: Re: [GSoC'10] : New Command Line Tool(s) for bluez
From: alok barsode <alokbarsode@gmail.com>
To: Alexander Orlenko <zxteam@gmail.com>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Bastien Nocera <hadess@hadess.net>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey Gustavo,

On Tue, Aug 17, 2010 at 10:25 AM, Alexander Orlenko <zxteam@gmail.com> wrote:
>> Why have you decided to write a binary for each functionality? What do
>> you think about have them all in only one binary? (or at least the
>> bluetoothd related ones)
>
> My mentor (Alok Barsode) advised to write different tools for
> different functionality. I originally wanted to write a one utility
> for all. At the beginning of the project, I asked the opinions what
> should I choose (a one binary or some binaries). But almost no one
> responded.

I had proposed different binaries so that we don't bloat up a single
binary. Also with a lot of
command line options its easy to have separate binaries. Other wise
the cmd line options would be huge. I think is the same reason why the
python scripts tests/ are separate and not put in 1 script.

Cheers,
Alok.
>
> On 17 August 2010 14:59, Gustavo F. Padovan <gustavo@padovan.org> wrote:
>> Hi Alexander,
>>
>> * Alexander Orlenko <zxteam@gmail.com> [2010-08-16 10:24:23 +1100]:
>>
>>> Hi everyone,
>>>
>>> I updated project info page at http://hostisdown.org/gsoc/projects/bluez-tools
>>> Created project home page: http://code.google.com/p/bluez-tools
>>> Current release available for download: 0.1.18-6432
>>>
>>> Code of my project does not based on non-GTK parts of
>>> libgnome-bluetooth. I wrote glib gobjects for all bluez dbus
>>> interfaces.
>>> I will continue developing my project after end of GSoC.
>>
>> Why have you decided to write a binary for each functionality? What do
>> you think about have them all in only one binary? (or at least the
>> bluetoothd related ones)
>>
>>
>> --
>> Gustavo F. Padovan
>> http://padovan.org
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
