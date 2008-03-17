Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 17 Mar 2008 17:28:34 +0800
Message-ID: <FFED2D1514034841A6270D98984E7D0C01E24AEE@pdsmsx415.ccr.corp.intel.com>
In-Reply-To: <FFED2D1514034841A6270D98984E7D0C01E24A26@pdsmsx415.ccr.corp.intel.com>
References: <FFED2D1514034841A6270D98984E7D0C01E24A26@pdsmsx415.ccr.corp.intel.com>
From: "Zhu, Peter J" <peter.j.zhu@intel.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] problem of dropped packet in RFCOMM socket
	programming
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

Hi,

By using hcidump, I found all the packages are received by BT itself, so
the only potential issue might come from BT socket programming. Any
clue?

Thanks,
Peter


Zhu, Peter J wrote:
> Hello,
> 
> I'm a new guy in bluez progamming. If problem described here was
> already addressed, please let me know and forgive me.
> 
> I try to write a client/server application utilizing RFCOMM socket
> between bluetooth devices. Currently the two devices are both desktop
> armed with USB BT dongle. The connection and read/write are successful
> but I do see some data continuously and frequently sent by client was
> NOT received by server. For example I try to send a buffer of long
> data 30 times with client but sometimes server can get only 28 times
> or 29 times. Any solution or help are really really appreciated.
> Please see my simple programs below.
> 
> server programm:
> #include <stdio.h>
> #include <unistd.h>
> #include <errno.h>
> #include <stdlib.h>
> #include <sys/socket.h>
> #include <bluetooth/bluetooth.h>
> #include <bluetooth/rfcomm.h>
> 
> 
> void do_proxy(int sockfd)
> {
>     ssize_t bytes_read;
>     char buf[1024] = {0};
>     int count = 0;
> 
> again:
>     while ( (bytes_read = recv(sockfd, buf, sizeof(buf), 0)) > 0)
>         fprintf(stderr, "received [%s] %d lines\n", buf, ++count);
>     if (bytes_read < 0 && errno == EINTR)
>         goto again;
>     else if (bytes_read < 0)
>         perror("uh oh");
> 
> }
> 
> int main(int argc, char **argv)
> {
>     struct sockaddr_rc loc_addr = { 0 }, rem_addr = { 0 };
>     char buf[1024] = { 0 };
>     int s, client, bytes_read;
>     unsigned int opt = sizeof(rem_addr);
> 
>     // allocate socket
>     s = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
> 
>     // bind socket to port 1 of the first available bluetooth adapter
>     loc_addr.rc_family = AF_BLUETOOTH;
>     loc_addr.rc_bdaddr = *BDADDR_ANY;
>     loc_addr.rc_channel = 25;
>     bind(s, (struct sockaddr *)&loc_addr, sizeof(loc_addr));
> 
>     // put socket into listening mode
>     listen(s, 1);
> 
>     for (; ;) {
>         // accept one connection
>         client = accept(s, (struct sockaddr *)&rem_addr, &opt);
> 
>         ba2str( &rem_addr.rc_bdaddr, buf );
>         fprintf(stderr, "accepted connection from %s\n", buf);
>         memset(buf, 0, sizeof(buf));
>         do_proxy(client);
> 
>         // close connection
>         close(client);
>     }
>     close(s);
>     return 0;
> }
> 
> client program:
> #include <stdio.h>
> #include <unistd.h>
> #include <sys/socket.h>
> #include <bluetooth/bluetooth.h>
> #include <bluetooth/rfcomm.h>
> 
> int main(int argc, char **argv)
> {
>     struct sockaddr_rc addr = { 0 };
>     int s, status;
>     /*char dest[18] = "00:0E:9B:DA:7D:73";*/ /*JZHU26*/
>     /*char dest[18] = "00:17:00:2B:7A:6C";*/ /*V3*/
>     char dest[18] = "00:0A:94:02:71:04";
>     int i=0;
>     const char buf[] = "This is a very cool device for use for trial
> for test for examination";
> 
> 
>     // allocate a socket
>     s = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
> 
>     // set the connection parameters (who to connect to)
>     addr.rc_family = AF_BLUETOOTH;
>     addr.rc_channel = 25;
>     str2ba( dest, &addr.rc_bdaddr );
> 
>     // connect to server
>     status = connect(s, (struct sockaddr *)&addr, sizeof(addr));
> 
>     // send a message
>     if( 0 == status ) {
>         while(i<30) {
>             status = send(s, buf, sizeof(buf), 0);
>             if( status < 0 ) {perror("uh oh "); break;}
>             i++;
>         }
>         fprintf(stderr, "sent %d\n", i);
>     }
>     if (status < 0)
>         perror("AAAA");
> 
> 
>     close(s);
>     return 0;
> }
> 
> 
> 
> Thanks,
> Peter
> 
>
------------------------------------------------------------------------
-
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
