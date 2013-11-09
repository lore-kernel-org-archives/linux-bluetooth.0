Return-Path: <cyrus@holtmann.org>
Message-ID: <1384030812.3880.47.camel@nuvo>
Subject: Re: obexd broken for absolute paths
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Sat, 09 Nov 2013 22:00:12 +0100
In-Reply-To: <CABBYNZJtvdd0iDmcuUe7S9mi68U1nQOLTy577vu0T-kpa9wMBA@mail.gmail.com>
References: <1383938500.3880.23.camel@nuvo> <1384017476.3880.40.camel@nuvo>
	 <CABBYNZJtvdd0iDmcuUe7S9mi68U1nQOLTy577vu0T-kpa9wMBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, 2013-11-09 at 20:35 +0200, Luiz Augusto von Dentz wrote:
> Hi Bastian,
> 
> On Sat, Nov 9, 2013 at 7:17 PM, Bastien Nocera <hadess@hadess.net> wrote:
> > On Fri, 2013-11-08 at 20:21 +0100, Bastien Nocera wrote:
> >> Heya,
> >>
> >> I was trying to test gnome-user-share's Bluetooth support for BlueZ 5,
> >> and was quite surprised it didn't work one bit, with transfers failing
> >> as soon as they were created.
> >>
> >> I made this simple change to test/simple-obex-agent so you could
> >> replicate the failure. Obviously, change the download path to exist on
> >> your system:
> >> -               return properties['Name']
> >> +               return ("%s/%s" % ("/home/hadess/Downloads/", properties['Name']))
> >>
> >> This will see OBEX Push transfers fail as soon as accepted.
> >
> > Turns out this is a feature of filesystem plugin in obexd, and a bit of
> > a problem as well:
> > - There's no way to change the folder without changing the service file
> 
> Yep, I remember discussing with Gustavo Padovan that this should
> probably be set by the agent upon registration.

I thought about that, but it's really a security issue. obexd might be
running in a different context than the "application" telling it where
to write. For example, my share application might be restricted to write
new files in ~/Downloads, but could tell obexd to write to ~/.ssh/etc.

> > - It doesn't default to use the XDG_RUNTIME_DIR
> 
> That is a good default considering we don't implement the change
> above, otherwise for auto accept I believe tmp is usually a better
> option.

This is what I intend to use in gnome-user-share. obexd would write
files with unique filenames to /run/user/<id>/obexd and move it
~/Downloads after uniquifying the name (eg. sending 2 files called
"foo.jpg" should give me 2 files, not overwrite the first one as it does
now).

Cheers

