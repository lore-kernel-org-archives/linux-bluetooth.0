Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] [ECONNRESET]Problem with last buffer readed with
	a read or recv
From: Marcel Holtmann <marcel@holtmann.org>
To: Paolino paperino <vonzoltan@yahoo.it>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20041020140143.52337.qmail@web40611.mail.yahoo.com>
References: <20041020140143.52337.qmail@web40611.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1098288811.13853.30.camel@pegasus>
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
Date: Wed, 20 Oct 2004 18:13:31 +0200

Hi Andrea,

> I writed a RFCOMM cleint side socket and its servere
> side. The server sends an arbitrary sequence of 2048
> bytes throught the write function. The client side
> read as far as it receive a 0 or -1 frem the read.
> The code is like this:
> char *buffer[2048];
> do {
>    tmpPtr += nread;		
>    nread = recv(fd, buffer, length, 0);
> } while (nread > 0);
> 
> The problem arise when the server correctly send its
> last bucket, the client must read it (read 2048
> bytes), at the next read the client must get an EOF
> (0) value from the recv...but this not happen it
> receive -1 and errno=ECONNRESET. The same code works
> as expected using TCP streams, but when it is used
> over RFCOMM SOCK_STREAM it causes this anomaly.
> 
> Somebody could explain what happens, why the recv call
> doesn't return a 0 when last data are reached on the
> stream, but give an error message?

are you sure that your client/server code is correct, because until you
don't close the socket on the server side, the client can't receive any
additional information. It simply blocks. Show us the full code for both
sides.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
