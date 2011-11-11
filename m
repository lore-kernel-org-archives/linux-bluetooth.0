Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Nov 2011 11:46:00 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Fix simple-player test script to make it work with
 dbus-python-0.84
Message-ID: <20111111144600.GA23134@samus.indt.org>
References: <1320973115-13322-1-git-send-email-vinicius.gomes@openbossa.org>
 <CAMOw1v5hh9VGgzHayeukEFAz_KJxSN6T5DUfreRmmwi04kqBFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAMOw1v5hh9VGgzHayeukEFAz_KJxSN6T5DUfreRmmwi04kqBFg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On 11:23 Fri 11 Nov, Lucas De Marchi wrote:
> Hi Vinicius
> 
> On Thu, Nov 10, 2011 at 10:58 PM, Vinicius Costa Gomes
> <vinicius.gomes@openbossa.org> wrote:
> > ---
> > In every machine that I tried with dbus-python 0.84, something like this was
> > needed, but I didn't find out why nobody complained about this earlier.
> 
> Weird... I have exactly the same version here.
> 
> >
> >
> >  test/simple-player |    6 +++---
> >  1 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/test/simple-player b/test/simple-player
> > index 166caff..70701da 100755
> > --- a/test/simple-player
> > +++ b/test/simple-player
> > @@ -104,7 +104,7 @@ if __name__ == '__main__':
> >                                        "Shuffle" : "off",
> >                                        "Scan" : "off",
> >                                        "Status" : "playing",
> > -                                       "Position" : dbus.UInt32(0) })
> > +                                       "Position" : dbus.UInt32(0) }, signature="sv")
> 
> From http://dbus.freedesktop.org/doc/dbus-python/api/: if signature is
> None (the default) it will be guessed from the elements in the dict.
> However, I think it doesn't hurt to put it explicitly.
> 

Makes sense, but at least here, the presence of both integers and
strings seems to confuse dbus-python.

> >
> >        metadata = dbus.Dictionary({ "Title" : "Title",
> >                                        "Artist" : "Artist",
> > @@ -112,7 +112,7 @@ if __name__ == '__main__':
> >                                        "Genre" : "Genre",
> >                                        "NumberOfTracks" : dbus.UInt32(10),
> >                                        "Number" : dbus.UInt32(1),
> > -                                       "Duration" : dbus.UInt32(10000) })
> > +                                       "Duration" : dbus.UInt32(10000) }, signature="sv")
> >
> >        print('Register media player with:\n\tProperties: %s\n\tMetadata: %s' \
> >                                                % (properties, metadata))
> > @@ -120,6 +120,6 @@ if __name__ == '__main__':
> >        handler = InputHandler(player)
> >        gobject.io_add_watch(sys.stdin, gobject.IO_IN, handler.handle)
> >
> > -       media.RegisterPlayer(path, properties, metadata)
> > +       media.RegisterPlayer(dbus.ObjectPath(path), properties, metadata)
> >
> >        mainloop.run()
> 
> 
> Anyway... it works here with your patch as well.

Thanks.

> 
> ACK


Cheers,
-- 
Vinicius
