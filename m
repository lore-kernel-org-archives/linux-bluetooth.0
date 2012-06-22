Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAAngNMaf74zzcEdz9bM13EmQH7+2iW9C4GrfZ2W1PGqkzUAS2g@mail.gmail.com>
References: <1339761848-7472-1-git-send-email-hdante@profusion.mobi>
	<CAJdJm_OrV7Xua91zUcyATHCWtHHAZUsOYJbVL8Vn_194O8_=Hw@mail.gmail.com>
	<CAFAvTnNJp0Q1JAt+HUy4X5mBG_xO+fQgUYoYiy+90uHJNtx9Mw@mail.gmail.com>
	<CAFAvTnNcj8ODBqbKJpZzHmFE0Hy_oVtng9Lc-5Ess353Dv2LuQ@mail.gmail.com>
	<CAAngNMaxPad3h8hXpCg4hN_gunjAjesQTeSv45a34X6+mG5+sw@mail.gmail.com>
	<CAMOw1v7ZfiuMxXhXRo2RcB7-WK21gbfip3hXTuRYy=WCj2iaAQ@mail.gmail.com>
	<CAAngNMausNpp4oUvNLp3wiUe7xagbDekQ44ytuVUqz_h3swfBQ@mail.gmail.com>
	<CAAngNMaf74zzcEdz9bM13EmQH7+2iW9C4GrfZ2W1PGqkzUAS2g@mail.gmail.com>
Date: Fri, 22 Jun 2012 18:10:16 -0300
Message-ID: <CAFAvTnOv-wYPt4aOkUf_PHBjU2BdKy0NF2rOKLGthKLY16cq2g@mail.gmail.com>
Subject: Re: [PATCH RFC] gdbus: Rename variables named "signal" (so that it
 can be compiled with -Wshadow)
From: Henrique Dante <hdante@profusion.mobi>
To: Joao Paulo Rechi Vita <jprvita@openbossa.org>
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

 Any conclusions about this ?

On Wed, Jun 20, 2012 at 10:59 AM, Joao Paulo Rechi Vita
<jprvita@openbossa.org> wrote:
> On Wed, Jun 20, 2012 at 10:20 AM, Joao Paulo Rechi Vita
> <jprvita@openbossa.org> wrote:
>> On Tue, Jun 19, 2012 at 6:41 PM, Lucas De Marchi
>> <lucas.demarchi@profusion.mobi> wrote:
>>> On Tue, Jun 19, 2012 at 3:29 PM, Joao Paulo Rechi Vita
>>> <jprvita@openbossa.org> wrote:
>>>> On Fri, Jun 15, 2012 at 9:45 AM, Henrique Dante <hdante@profusion.mobi> wrote:
>>>>> On Fri, Jun 15, 2012 at 9:43 AM, Henrique Dante <hdante@profusion.mobi> wrote:
>>>>>> On Fri, Jun 15, 2012 at 9:29 AM, Anderson Lizardo
>>>>>> <anderson.lizardo@openbossa.org> wrote:
>>>>>>> Hi Henrique,
>>>>>>>
>>>>>>> On Fri, Jun 15, 2012 at 8:04 AM, Henrique Dante de Almeida
>>>>>>> <hdante@profusion.mobi> wrote:
>>>>>>>> ---
>>>>>>>>  gdbus/object.c |   39 +++++++++++++++++++++------------------
>>>>>>>>  gdbus/watch.c  |    4 ++--
>>>>>>>>  2 files changed, 23 insertions(+), 20 deletions(-)
>>>>>>>
>>>>>>> Would it be interesting to add this option to acinclude.m4? Or does it
>>>>>>> generate too much noise?
>>>>>>
>>>>>>  It generates few warnings. Depending on the acceptance of this patch,
>>>>>> I could fix bluez as a whole and add -Wshadow to acinclude.m4.
>>>>>
>>>>>  Actually, I had a partial build here. Ignore the previous answer, it
>>>>> generates a lot of warnings.
>>>>>
>>>>
>>>> If we're not going to enable -Wshadow by default, does it make sense
>>>> to apply this patch? Who is going to check if no new shadow warnings
>>>> are being inserted in new commits?
>>>
>>> I'm all for doing the following:
>>>
>>> 1) Fix all the places with shadow variables
>>> 2) Add -Wshadow to the warning flags
>>>
>>> There are lots of them.
>>>
>>
>> Yes, that makes sense.
>>
>
> Or not completely, as researching a little bit on what kind of
> warnings -Wshadow generates shows that not all of them are useful [1]
> (I'm quoting the relevant part of this link below). I think before
> getting our hands dirty to change this, we should look if we want to
> live with all the restrictions imposed by it. Opinions?
>
> [1] http://kerneltrap.org/node/7434
>
> """
> From: Linus Torvalds [email blocked]
> Subject: Re: [PATCH] Don't compare unsigned variable for <0 in sys_prctl()
> Date:   Tue, 28 Nov 2006 16:13:05 -0800 (PST)
>
>
>
> On Wed, 29 Nov 2006, Jesper Juhl wrote:
>>
>> I would venture that "-Wshadow" is another one of those.
>
> I'd agree, except for the fact that gcc does a horribly _bad_ job of
> -Wshadow, making it (again) totally unusable.
>
> For example, it's often entirely interesting to hear about local variables
> that shadow each other. No question about it.
>
> HOWEVER. It's _not_ really interesting to hear about a local variable that
> happens to have a common name that is also shared by a extern function.
>
> There just isn't any room for confusion, and it's actually not even that
> unusual - I tried using -Wshadow on real programs, and it was just
> horribly irritating.
>
> In the kernel, we had obvious things like local use of "jiffies" that just
> make _total_ sense in a small inline function, and the fact that there
> happens to be an extern declaration for "jiffies" just isn't very
> interesting.
>
> Similarly, with nested macro expansion, even the "local variable shadows
> another local variable" case - that looks like it should have an obvious
> warning on the face of it - really isn't always necessarily that
> interesting after all. Maybe it is a bug, maybe it isn't, but it's no
> longer _obviously_ bogus any more.
>
> So I'm not convinced about the usefulness of "-Wshadow". ESPECIALLY the
> way that gcc implements it, it's almost totally useless in real life.
>
> For example, I tried it on "git" one time, and this is a perfect example
> of why "-Wshadow" is totally broken:
>
>        diff-delta.c: In function 'create_delta_index':
>        diff-delta.c:142: warning: declaration of 'index' shadows a global declaration
>
> (and there's a _lot_ of those). If I'm not allowed to use "index" as a
> local variable and include <string.h> at the same time, something is
> simply SERIOUSLY WRONG with the warning.
>
> So the fact is, the C language has scoping rules for a reason. Can you
> screw yourself by usign them badly? Sure. But that does NOT mean that the
> same name in different scopes is a bad thing that should be warned about.
>
> If I wanted a language that didn't allow me to do anything wrong, I'd be
> using Pascal. As it is, it turns out that things that "look" wrong on a
> local level are often not wrong after all.
>
>                        Linus
> """
>
> --
> João Paulo Rechi Vita
> Openbossa Labs - INdT
