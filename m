Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] [ECONNRESET]Problem with last buffer readed with
	a read or recv
From: Marcel Holtmann <marcel@holtmann.org>
To: Paolino paperino <vonzoltan@yahoo.it>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20041022080322.69524.qmail@web40603.mail.yahoo.com>
References: <20041022080322.69524.qmail@web40603.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1098443254.4704.42.camel@pegasus>
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
Date: Fri, 22 Oct 2004 13:07:33 +0200

Hi Andrea,

> Thanks Marcel i attach the server and client source
> code.
> brief man:
> clientTestRC <btadddr>
> serverTestRC
> 
> The code is structured to use also TCP socket, it is
> only necessary to decomment an undef and recompile.
> In tcp all work correctly...last read retrn a 0.

the line "addr.rc_channel = htobs(10);" is wrong, because rc_channel is
only a uint8_t and so you don't need any byte swapping magic. Remove the
call to htobs() and simply set the channel number.

On the server side you forgot to init clientAddrLen before you called
accept(). Do a "clientAddrLen = sizeof(clientAddr);" first.

> Out snapshot server:
> [andrea@ZANDEGIA andrea]$ ./serverTestRC
> Binding...
> Bounded on channel 10
> Listenning...
> accept ok
> loop 0
> loop 1
> loop 2
> loop 3
> loop 4
> [andrea@ZANDEGIA andrea]$
> 
> Out snapshot client:
> [andrea@tsunami Bluetoooth]$ ./clientTestRC
> 00:10:C6:4D:38:AC
> bluetooth_initclient_socket called
> connecting...
> Connection opened
> Receiving ...
> nread value 1019
> nread value 1029
> nread value 1019
> nread value 1029
> nread value 1019
> nread value 1029
> nread value 2038
> nread value 10
> nread value 2048
> nread value -1
> [andrea@tsunami Bluetoooth]$

for me this looks ok, because you close the connection from the server
side and recv returns with an error. Does it makes any difference when
you use read/write instead of recv/send?

I seems that you really wanna the behaviour described in the recv manual
page:

	RETURN VALUE

	These calls return the number of bytes received, or -1 if an
	error occurred. The return value will be 0 when the peer has
	performed an orderly shutdown.

For this behaviour you must send me a kernel patch that implements this,
but I will only accept it if you change the L2CAP in the same way.

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
