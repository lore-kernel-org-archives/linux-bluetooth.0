Return-Path: <steve.crane@rococosoft.com>
Subject: Re: [Bluez-devel] Logitech MX900 mouse with Dell Inspiron 8600
From: Stephen Crane <steve.crane@rococosoft.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Edd Dumbill <edd@usefulinc.com>, Peter Klausler <peter@klausler.com>,
   Charles Bueche <charles@bueche.ch>,
   BlueZ Developers List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1070386758.18577.2.camel@pegasus>
References: <1070201531.8187.20.camel@bluez.bueche.ch>
	 <1070218289.8534.30.camel@bluez.bueche.ch>
	 <20031201093804.A1281@schnell.us.cray.com> <1070380522.19169.52.camel@saag>
	 <1070386758.18577.2.camel@pegasus>
Content-Type: text/plain
Message-Id: <1070446227.26243.69.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Date: 03 Dec 2003 10:10:27 +0000
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,
If this posting is anything to go by, 2.4.24 is the very last chance for
getting this into the 2.4 series, after that it's bugfixes only:

http://www.ussg.iu.edu/hypermail/linux/kernel/0312.0/0052.html

On Tue, 2003-12-02 at 17:39, Marcel Holtmann wrote:
> Hi Edd,
> 
> > Hmm, I'd thought I'd sent this to the list, but obviously didn't. 
> 
> yes you sent it to list. It still resides in my Bluetooth mailbox and it
> is working fine. I think Marcelo will take my backport of the uinput
> driver into 2.4.24 and so uinput should be the way to go, even if this
> means that we have to implement our own HID parser in userspace.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)
