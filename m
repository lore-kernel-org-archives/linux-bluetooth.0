Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMOw1v7ZfiuMxXhXRo2RcB7-WK21gbfip3hXTuRYy=WCj2iaAQ@mail.gmail.com>
References: <1339761848-7472-1-git-send-email-hdante@profusion.mobi>
	<CAJdJm_OrV7Xua91zUcyATHCWtHHAZUsOYJbVL8Vn_194O8_=Hw@mail.gmail.com>
	<CAFAvTnNJp0Q1JAt+HUy4X5mBG_xO+fQgUYoYiy+90uHJNtx9Mw@mail.gmail.com>
	<CAFAvTnNcj8ODBqbKJpZzHmFE0Hy_oVtng9Lc-5Ess353Dv2LuQ@mail.gmail.com>
	<CAAngNMaxPad3h8hXpCg4hN_gunjAjesQTeSv45a34X6+mG5+sw@mail.gmail.com>
	<CAMOw1v7ZfiuMxXhXRo2RcB7-WK21gbfip3hXTuRYy=WCj2iaAQ@mail.gmail.com>
Date: Wed, 20 Jun 2012 10:20:42 -0300
Message-ID: <CAAngNMausNpp4oUvNLp3wiUe7xagbDekQ44ytuVUqz_h3swfBQ@mail.gmail.com>
Subject: Re: [PATCH RFC] gdbus: Rename variables named "signal" (so that it
 can be compiled with -Wshadow)
From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: Henrique Dante <hdante@profusion.mobi>,
	Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jun 19, 2012 at 6:41 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> On Tue, Jun 19, 2012 at 3:29 PM, Joao Paulo Rechi Vita
> <jprvita@openbossa.org> wrote:
>> On Fri, Jun 15, 2012 at 9:45 AM, Henrique Dante <hdante@profusion.mobi> wrote:
>>> On Fri, Jun 15, 2012 at 9:43 AM, Henrique Dante <hdante@profusion.mobi> wrote:
>>>> On Fri, Jun 15, 2012 at 9:29 AM, Anderson Lizardo
>>>> <anderson.lizardo@openbossa.org> wrote:
>>>>> Hi Henrique,
>>>>>
>>>>> On Fri, Jun 15, 2012 at 8:04 AM, Henrique Dante de Almeida
>>>>> <hdante@profusion.mobi> wrote:
>>>>>> ---
>>>>>>  gdbus/object.c |   39 +++++++++++++++++++++------------------
>>>>>>  gdbus/watch.c  |    4 ++--
>>>>>>  2 files changed, 23 insertions(+), 20 deletions(-)
>>>>>
>>>>> Would it be interesting to add this option to acinclude.m4? Or does it
>>>>> generate too much noise?
>>>>
>>>>  It generates few warnings. Depending on the acceptance of this patch,
>>>> I could fix bluez as a whole and add -Wshadow to acinclude.m4.
>>>
>>>  Actually, I had a partial build here. Ignore the previous answer, it
>>> generates a lot of warnings.
>>>
>>
>> If we're not going to enable -Wshadow by default, does it make sense
>> to apply this patch? Who is going to check if no new shadow warnings
>> are being inserted in new commits?
>
> I'm all for doing the following:
>
> 1) Fix all the places with shadow variables
> 2) Add -Wshadow to the warning flags
>
> There are lots of them.
>

Yes, that makes sense.

-- 
João Paulo Rechi Vita
Openbossa Labs - INdT
