Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTik3d0rY2QNrhevwzPz28VQwKuj7A5s-9l152H4Y@mail.gmail.com>
References: <AANLkTimnLyeZqNvNecognr_U9alZiC9bKNUOWjX9H_Hq@mail.gmail.com>
	<1274360918.27274.3302.camel@localhost.localdomain>
	<AANLkTik3d0rY2QNrhevwzPz28VQwKuj7A5s-9l152H4Y@mail.gmail.com>
Date: Mon, 16 Aug 2010 10:24:23 +1100
Message-ID: <AANLkTimW1SmfZ+j=F7kTSwosdz=kh+g9ofcqdTeGE7CB@mail.gmail.com>
Subject: Re: [GSoC'10] : New Command Line Tool(s) for bluez
From: Alexander Orlenko <zxteam@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi everyone,

I updated project info page at http://hostisdown.org/gsoc/projects/bluez-tools
Created project home page: http://code.google.com/p/bluez-tools
Current release available for download: 0.1.18-6432

Code of my project does not based on non-GTK parts of
libgnome-bluetooth. I wrote glib gobjects for all bluez dbus
interfaces.
I will continue developing my project after end of GSoC.

On 21 May 2010 18:29, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
>
> On Thu, May 20, 2010 at 4:08 PM, Bastien Nocera <hadess@hadess.net> wrote:
> > On Fri, 2010-05-21 at 00:04 +1100, Alexander Orlenko wrote:
> >> Hi everyone,
> >>
> >> My name is Alexander Orlenko, I am a GSoC student of this year. I am
> >> doing a project "bluez-tools",
> >> http://hostisdown.org/gsoc/projects/bluez-tools (a little more info
> >> about the project). I need some feedback about what approach should I
> >> take.
> >
> > I'm not sure whether you'd be interested, but you could base your code
> > on the non-GTK parts of libgnome-bluetooth, which already implements a
> > number of those things, and would just need to be wrapped up.
>
> There is also python code in bluez/test repository.
>
> -- Andrei
>
> >
> > Cheers
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
