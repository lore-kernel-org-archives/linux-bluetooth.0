Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <BAY104-F16C20570F646F1FC09FE46C1990@phx.gbl>
From: "blookk -" <blookk@hotmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Subject: [Bluez-users] hci.c  hacked
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 27 Dec 2004 11:36:54 +0000


Hello Marcel!

When I compiled the BlueZ for ARM7TDMI with uclibc 0.9.19  I detect a 
problem in "hci.c" . In "poll" call because seems that my arquitecture 
doesn't support this call. I modified the "hci.c" and use "select" instead 
of "poll". The modification is this:

		if (to) {
			struct pollfd p;
			int n;

			//p.fd = dd; p.events = POLLIN;

			n = select( dd + 1, &temp_rfds, NULL, NULL, &tv );
			printf("Descriptor in select: %d\n",n);
			printf("timeover: %d\n",to);
			switch( n )
			{
			    case -1: // Error
			        goto failed;
				break;

			    case 0:  // Timeout
			        continue;
				break;

			    default: // Data...
			        printf( "The file descriptor with data\n" );
				if( FD_ISSET( dd, &temp_rfds ) )
				{
				     printf( "The file descriptor was signaled\n" );
				}
				break;
			}

			//while ((n = poll(&p, 1, to)) < 0) {
			//printf("(4.3.4)\n");
			//	if (errno == EAGAIN || errno == EINTR)
			//		continue;
			//	goto failed;
			//}

			//if (!n) {
			//	errno = ETIMEDOUT;
			//	goto failed;
			//}

			to -= 10;
			if (to < 0) to = 0;

		}

with this changes the program don't work , but I don't know why.
Do you know where is the problem?

Regards.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
