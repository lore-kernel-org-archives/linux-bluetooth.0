Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20040328020755.5494.qmail@web21003.mail.yahoo.com>
From: =?iso-8859-1?q?Gary=20Martin?= <gary_martin_au@yahoo.com.au>
Subject: Re: [Bluez-users] Desperate newbie
To: bluez-users@lists.sourceforge.net
In-Reply-To: <200403280158.30064.cijoml@volny.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 28 Mar 2004 12:07:55 +1000 (EST)

Thanks for the suggestion Michal. I changed the class from 0x100; to 0x10c; in the file
hcid.conf, but nothing has changed. I'm glad it is not only me that is mystified.

Gary


--- "Michal Semler (volny.cz)" <cijoml@volny.cz> wrote: > Hi, 
> 
> try change your service class to:
> 
> class 0x10c;
> 
> Michal
> 

Find local movie times and trailers on Yahoo! Movies.
http://au.movies.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
