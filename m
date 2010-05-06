Return-Path: <cyrus@holtmann.org>
Subject: Re: [bugreport]
From: Bastien Nocera <hadess@hadess.net>
To: Fabian Greffrath <fabian@greffrath.com>
Cc: Serhiy Kachaniuk <serzholino@gmail.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <4BE2947F.9030103@greffrath.com>
References: <p2q793f89501005052222u4393c8dfhb55bea4454c454b9@mail.gmail.com>
	 <4BE270EE.5080306@greffrath.com>
	 <y2t793f89501005060301t9bdc8c73v266a798160027d4d@mail.gmail.com>
	 <4BE2947F.9030103@greffrath.com>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Thu, 06 May 2010 11:11:46 +0100
Message-ID: <1273140706.13354.1376.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2010-05-06 at 12:05 +0200, Fabian Greffrath wrote:
> Am 06.05.2010 12:01, schrieb Serhiy Kachaniuk:
> > Interesting moment: when run without sudo with version 4.60 it shows
> > name, but prints error on getting class of device:
> 
> Maybe a stupid question, but do you have an application like GNOME's 
> bluetooth applet running (that keeps the shared lib in memory) while 
> switching bluez versions?

gnome-bluetooth doesn't use libbluetooth, and a newly started app would
be using the library that's on disk anyway, not the one in memory if
they were different (you could see that in lsof which would show an
older running application as using the library with a "(deleted)"
comment).

