Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] killing a persisted pand session
From: Marcel Holtmann <marcel@holtmann.org>
To: wim delvaux <wim.delvaux@adaptiveplanet.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200403070058.50508.wim.delvaux@adaptiveplanet.com>
References: <200403070058.50508.wim.delvaux@adaptiveplanet.com>
Content-Type: text/plain
Message-Id: <1078622263.2807.2.camel@pegasus>
Mime-Version: 1.0
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
Date: Sun, 07 Mar 2004 02:17:43 +0100

Hi Wim,

> If i run
> 
> pand --persist --connect XXXX
> 
> this means that pand will try to reestablish the connection to XXX whenever it 
> needs to.
> 
> Now I want to terminate that application.
> 
> Should I run 
> 
> pand -k XXX ?
> 
> or
> 
> pand -K ?
> 
> or
> 
> kill `pidof pand` ( or a bit more complicated)
> 
> I have tried
> 
> pand -k
> 
> which seems the most logical but this only closes the connection which then 
> gets reestablished after the interval timeout (5 secs).  I would expect a -k 
> to really 'kill' the connection and terminate the corresponding pand

you have to kill the pand process first and then run 'pand -k' to kill
the active connections.

Or you extend pand that it will kill the current connection by itself if
it receives SIG_TERM. Patches are welcome ;)

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
