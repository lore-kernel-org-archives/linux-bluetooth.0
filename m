Return-Path: <cyrus@holtmann.org>
Date: Tue, 9 Dec 2014 17:50:17 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 07/15] core: device: Use bt_att_register_disconnect.
Message-ID: <20141209155017.GA23597@t440s.P-661HNU-F1>
References: <1418085655-7304-1-git-send-email-armansito@chromium.org>
 <1418085655-7304-8-git-send-email-armansito@chromium.org>
 <20141209080756.GA4214@t440s.lan>
 <CAHrH25TMKQQFe0QejpRJ61Biy4PqXX5g_Gj01zid=AW8upMOrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHrH25TMKQQFe0QejpRJ61Biy4PqXX5g_Gj01zid=AW8upMOrQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Tue, Dec 09, 2014, Arman Uguray wrote:
> > On Tue, Dec 9, 2014 at 12:07 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> > Hi Arman,
> >
> > On Mon, Dec 08, 2014, Arman Uguray wrote:
> >> +     dev->att = bt_att_ref(g_attrib_get_att(attrib));
> >
> > I'd expect a function called "get" to return a new reference, so the
> > extra ref() shouldn't be needed.
> >
> 
> I see it mostly as a raw getter and adding ref semantics to it seems
> confusing to me. Unless we call it g_attrib_get_att_ref or something
> to that end.

Could be that this is also just because of me spending too much time
looking at kernel code. There pretty much everywhere foo_ref() is called
foo_get() and foo_unref() is called foo_put(). I thought this was the
common behavior for user space *get() functions too, but looking now I
could only find agent_get() following this practice. The most annoying
thing about your code was really the nested function calls so whatever
solution gets rid of that is a step towards the better.

Johan
