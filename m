Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <BAY114-W26F43C8D90463DC89CF35DD7A30@phx.gbl>
From: Mikael Bengtsson <micke_b.b@hotmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Mon, 15 Oct 2007 10:54:24 +0200
In-Reply-To: <BAY114-W266FADABD770552606A55AD7AF0@phx.gbl>
References: <BAY114-W266FADABD770552606A55AD7AF0@phx.gbl>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Problem detecting closed connection
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


I have an example of this problem. The following code snippet show a thread that controls a SCO connection. 


...
do
{
     poll_result = poll(ufds, 1, 1000);
     printf("Hello\n");
     if (poll_result == -1)
     {
          printf("Device got POLL-ERROR\n");
     }
     else if (poll_result == 0)
     {
          printf("Timeout\n");
     }
     else if (ufds[0].revents & POLLIN)
     {
         memset(buffer, 0, sizeof(buffer));
         bytes_read = read(ufds[0].fd, buffer, sizeof(buffer));
         printf("bytes_read == %d\n", bytes_read);
         if (bytes_read == 0)
            exit(1);
         ....
     }
} while (poll_result> 0);

Since this is a SCO connection, the read operation will always return 60 bytes every 3.75 ms. I observe that "Hello" and "bytes_read == %60" is written which is correct. When i switch off the slave, "Hello" and "bytes_read = 60" will continue for about 20 about seconds. This is also correct since it may take that long for a connection to be disconnected. After this, only the text "Hello" is written. However, I expected that the timeout event also should occur, that is, poll_result should have returned 0, or that the text "bytes_read == 0" should occur, and in that case the program should end. But the program prints "Hello" endlessly. Why doesn't this work?

I'm thinking of doing a thread with low level checks on the connections, I have two SCO and three ACL connections. This thread may check the connections periodically, but I don't have a clue what low level functions in BlueZ I should use.

I used hcitool to check what happened with a connection when switching off a slave. This program detected a closed connection after about 20 seconds. Maybe I could use something from that program?

-Mikael
________________________________
From: micke_b.b@hotmail.com
To: bluez-devel@lists.sourceforge.net
Date: Wed, 3 Oct 2007 10:40:08 +0200
Subject: [Bluez-devel] Problem detecting closed connection

Hello!

I have a problem detecting a device that has closed it's connection.

The software I'm developing sends and receives data through sockets to a slave device. When I switch of the slave device I expect that send and receive should return the value 0, as in ordinary sockets programming for TCP and UDP sockets. But instead send happily always returns a value which is bigger than 0. Why? Shouldn't Bluetooth sockets behave the same way as ordinary sockets? I have a quite old Bluez, version 2.15. Is there another way of detecting closed connections?

Regards:
-Mikael

________________________________
Express yourself instantly with MSN Messenger! MSN Messenger

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE!
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
