Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Aug 2010 00:59:21 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Alexander Orlenko <zxteam@gmail.com>
Cc: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Bastien Nocera <hadess@hadess.net>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [GSoC'10] : New Command Line Tool(s) for bluez
Message-ID: <20100817035921.GA5900@vigoh>
References: <AANLkTimnLyeZqNvNecognr_U9alZiC9bKNUOWjX9H_Hq@mail.gmail.com>
 <1274360918.27274.3302.camel@localhost.localdomain>
 <AANLkTik3d0rY2QNrhevwzPz28VQwKuj7A5s-9l152H4Y@mail.gmail.com>
 <AANLkTimW1SmfZ+j=F7kTSwosdz=kh+g9ofcqdTeGE7CB@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTimW1SmfZ+j=F7kTSwosdz=kh+g9ofcqdTeGE7CB@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alexander,

* Alexander Orlenko <zxteam@gmail.com> [2010-08-16 10:24:23 +1100]:

> Hi everyone,
> 
> I updated project info page at http://hostisdown.org/gsoc/projects/bluez-tools
> Created project home page: http://code.google.com/p/bluez-tools
> Current release available for download: 0.1.18-6432
> 
> Code of my project does not based on non-GTK parts of
> libgnome-bluetooth. I wrote glib gobjects for all bluez dbus
> interfaces.
> I will continue developing my project after end of GSoC.

Why have you decided to write a binary for each functionality? What do
you think about have them all in only one binary? (or at least the
bluetoothd related ones)


-- 
Gustavo F. Padovan
http://padovan.org
