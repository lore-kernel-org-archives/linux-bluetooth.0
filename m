Return-Path: <SRS0+19518ea8d5ecdcecdd27+262+infradead.org+dwmw2@pentafluge-143843.srs.infradead.org>
Subject: Re: [Bluez-devel] autoconf breaks portability. Film at 11.
From: David Woodhouse <dwmw2@infradead.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1084368666.25099.38.camel@pegasus>
References: <1084268833.11301.0.camel@hades.cambridge.redhat.com>
	 <1084368666.25099.38.camel@pegasus>
Content-Type: text/plain
Message-Id: <1084369122.4426.106.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Wed, 12 May 2004 14:38:42 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, 2004-05-12 at 15:31 +0200, Marcel Holtmann wrote:
> Hi David,
> 
> > I cannot build libs2. The autoconf stuff is broken. The last thing it
> > says is this:
> > 
> > configure.in:19: required file `./ltmain.sh' not found
> > 
> > Please can we ditch this crap and use sane makefiles instead?
> 
> I heard of that problem, but I can't reproduce it. If you call
> "./bootstrap" every that is necessary should be created.

Still no substitute for proper makefiles. Do we _really_ need the system
to check for itself how to build Fortran shared libraries? Yes, that's
one of the things it does.

Btw, swave() in hciattach still uses 10 characters of a 9-char array. 

--- bluez-utils-2.7/tools/hciattach.c.orig	2004-05-11 23:08:57.668856200 +0100
+++ bluez-utils-2.7/tools/hciattach.c	2004-05-11 23:11:43.626626784 +0100
@@ -640,7 +640,7 @@
 static int swave(int fd, struct uart_t *u, struct termios *ti)
 {
 	struct timespec tm = {0, 500000};
-	char cmd[9], rsp[100];
+	char cmd[10], rsp[100];
 	int r;
 
 	// Silicon Wave set baud rate command


-- 
dwmw2
