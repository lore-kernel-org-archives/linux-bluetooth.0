Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] RFCOMM support for nonblocking sockets
From: Marcel Holtmann <marcel@holtmann.org>
To: "Collin R. Mulliner" <collin@betaversion.net>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040601190522.78ecb2d9@coredump>
References: <20040601183206.7f99aacf@coredump>
	 <1086108068.4702.67.camel@pegasus>  <20040601190522.78ecb2d9@coredump>
Content-Type: text/plain
Message-Id: <1086110752.4578.6.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 01 Jun 2004 19:25:52 +0200

Hi Collin,

> I'm on 2.6.6-mh2 (should be the newest) ...

since today it is -mh3, but that doesn't matters ;)

> the code is:
> 
> sock = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
> 
> if (sock >= 0) {
> 	if (fcntl(sock, F_SETFL, O_NONBLOCK) != 0) {
> 		perror("fcntl()");
> 	}
> }

I don't know if this is the problem, but set the socket to non-blocking
after the bind() and the setsockopt() calls.

> psa.rc_family = AF_BLUETOOTH;
> psa.rc_channel = 0;
> 
> // src == BDADDR_ANY
> if (bacmp(&src, BDADDR_ANY) != 0) {
> 	psa.rc_bdaddr = src;
> 	if (bind(sock, (struct sockaddr *)&psa, sizeof(psa)) < 0) {	
> 		perror("Can't bind()");
> 		return(-1);
> 	}
> }

This check is not needed, because you can bind also src == BDADDR_ANY.
		
> psa.rc_channel = 1;
> psa.rc_bdaddr = dst;

Please try to use bacpy() to fill the rc_bdaddr.

> go:
> if (connect(sock, (struct sockaddr *)&psa, sizeof(psa)) != 0) {	
> 	if(errno == EINPROGRESS) {
> 		// never reached!
> 		pf[0].fd = sock;
> 		pf[0].events = POLLOUT;
> 		poll(pf, 1, -1);
> 		goto go;
> 	}
> 	else {
> 		perror("Connect()");
> 		// allways prints "Resource temporarily unavailable"
> 	}

Run "hcidump -x" to see what is going on. Print out the errno.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
