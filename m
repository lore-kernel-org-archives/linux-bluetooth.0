Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <BAY102-F33BFE2838AD565BE5C0FE1D2BD0@phx.gbl>
From: "theresa g." <tereza99@hotmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Subject: [Bluez-devel] rctest.c : question about do_listen function
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 29 Nov 2004 11:00:30 -0800

hello everyone,

I have looked at the rctest.c file (inside the bluez-utils-2.11/test 
directory) to get insight on how to write my own server app.  It all makes 
sense, except for the listen() call inside the do_listen function, which 
follows:

	if( listen(s, 10) ) {
		syslog(LOG_ERR,"Can not listen on the socket. %s(%d)", strerror(errno), 
errno);
		exit(1);
	}

I'm somewhat of a newbie to all this stuff (including sockets) so I question 
why the listen return is being checked for a 1 for error when the man pages 
say -1 is returned on error and 0 is returned on success.

Insight to this would really be appreciated!

Thanks in advance,
Theresa




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
