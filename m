Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMOw1v7Y3EORhpSyydjhieG4Owx=0d5QAp=G66RweF7-cCshXQ@mail.gmail.com>
References: <1353314786-11427-1-git-send-email-luiz.dentz@gmail.com>
	<1353314786-11427-2-git-send-email-luiz.dentz@gmail.com>
	<CAMOw1v7Y3EORhpSyydjhieG4Owx=0d5QAp=G66RweF7-cCshXQ@mail.gmail.com>
Date: Mon, 19 Nov 2012 14:49:46 +0200
Message-ID: <CABBYNZJ79UfsU9=ejGSEBGueca1FJouKt15LpukEy6TtK+QFYg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/4] gdbus: Automatically register '/' path
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Mon, Nov 19, 2012 at 2:06 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> Hi Luiz,
>
> On Mon, Nov 19, 2012 at 6:46 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> This makes g_dbus_setup_bus to automatically register '/' path so
>> user application that don't export any interface on '/' will have it
>> registered for ObjectManager.
>>
>> Note that it is now required to call g_dbus_close before exit.
>
> I'm no really fan of this. Why do we need to register '/' now?  If we
> are not going to support ObjectManager interfaces in subtrees, it
> would be easier to just move the ObjectManager to the shortest path
> registered rather than always registering '/'.

Maybe I should have made clear this in the description, if you look at
the spec it suggest that each sub-tree root should implement
ObjectManager, the current implementation does that but if you think
about it probably doesn't make sense to have sub-trees because that
would creates extra round trips that ObjectManager was meant to
prevent, also Im not completely sure now but I remember someone
mentioning the '/' is kind special and should always be available no
matter what, so by registering '/' directly on g_dbus_setup_bus we
guarantee we have it always and that no sub-tree is going to be
generated since '/' is the root no matter what path the user code
register.

--
Luiz Augusto von Dentz
