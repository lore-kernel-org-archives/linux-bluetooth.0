Return-Path: <vonzoltan@yahoo.it>
Message-ID: <20041022080322.69524.qmail@web40603.mail.yahoo.com>
Date: Fri, 22 Oct 2004 10:03:22 +0200 (CEST)
From: Paolino paperino <vonzoltan@yahoo.it>
Subject: Re: [Bluez-users] [ECONNRESET]Problem with last buffer readed with a read or recv
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1098288811.13853.30.camel@pegasus>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-760872450-1098432202=:67706"
List-ID: <bluez-users.lists.sourceforge.net>

--0-760872450-1098432202=:67706
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

> 
> are you sure that your client/server code is
> correct, because until you
> don't close the socket on the server side, the
> client can't receive any
> additional information. It simply blocks. Show us
> the full code for both
> sides.
> 
> Regards

Thanks Marcel i attach the server and client source
code.
brief man:
clientTestRC <btadddr>
serverTestRC

The code is structured to use also TCP socket, it is
only necessary to decomment an undef and recompile.
In tcp all work correctly...last read retrn a 0.

Out snapshot server:
[andrea@ZANDEGIA andrea]$ ./serverTestRC
Binding...
Bounded on channel 10
Listenning...
accept ok
loop 0
loop 1
loop 2
loop 3
loop 4
[andrea@ZANDEGIA andrea]$

Out snapshot client:
[andrea@tsunami Bluetoooth]$ ./clientTestRC
00:10:C6:4D:38:AC
bluetooth_initclient_socket called
connecting...
Connection opened
Receiving ...
nread value 1019
nread value 1029
nread value 1019
nread value 1029
nread value 1019
nread value 1029
nread value 2038
nread value 10
nread value 2048
nread value -1
[andrea@tsunami Bluetoooth]$

Best regards
 Andrea S.


		
___________________________________ 
Nuovo Yahoo! Messenger: E' molto più divertente: Audibles, Avatar, Webcam, Giochi, Rubrica… Scaricalo ora! 
http://it.messenger.yahoo.it
--0-760872450-1098432202=:67706
Content-Type: text/x-csrc; name="clientTestRC.c"
Content-Description: clientTestRC.c
Content-Disposition: inline; filename="clientTestRC.c"

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <syslog.h>
#include <string.h>
#include <errno.h>
#include <ctype.h>
#include <signal.h>
#include <sys/time.h>
#include <sys/select.h>

#include <netinet/in.h>
#include <arpa/inet.h>
#include <resolv.h>
#include <netdb.h>
#include <sys/socket.h>

#include <bluetooth/bluetooth.h>
#include <bluetooth/rfcomm.h>
//#include <bluetooth/l2cap.h>

#define MAXDIM 2048
#define BLUE
//#undef BLUE

int bluetooth_initclient_socket(char *str_addr)
{
	struct sockaddr_rc addr;
	//bdaddr_t bdaddr;
	int s;
	
	printf("bluetooth_initclient_socket called\n");
	/* Default options */
	if ((s = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) < 0) {
		perror("Can't create socket.");
		exit(1);
	}

	memset(&addr, 0, sizeof(addr));
	addr.rc_family = AF_BLUETOOTH;
	//addr.rc_bdaddr = bdaddr;
	str2ba(str_addr, &addr.rc_bdaddr);
	//str2ba("00:10:C6:4D:38:AC", &addr.rc_bdaddr);
 
	addr.rc_channel = htobs(10); //channel
	printf("connecting...\n");
	if (connect(s, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
		perror("Can't connect.");
		exit(1);
	}
	printf("Connection opened\n");
	return s;	
}

int tcp_initclient_socket(char *str_addr, int port)
{
	struct sockaddr_in 	addr;
	struct in_addr      inet_address;
	struct hostent      *host_info;
	int s;

	printf("tcp_initclient_socket called\n");
	if ((s = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
		perror("Can't create socket.");
		exit(1);
	}
	printf("Socket created, resolving address...\n");	
	if ((host_info = gethostbyname(str_addr)) == NULL )
		printf ("Error in resolving");

	memset(&addr, 0, sizeof(addr));
	addr.sin_family = host_info->h_addrtype;
	addr.sin_port = htons(port);
	memcpy(&addr.sin_addr, host_info->h_addr, host_info->h_length);	

	printf("Connecting...\n");
	if (connect(s, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
		perror("Can't connect.");
		exit(1);
	}
	printf("Connection opened\n");
	return s;		
}
	
int main(int argc, char *argv[])
{
	
	int s;
	char *buffer, *tmpPtr;
	int nread;

#ifdef BLUE
	s = bluetooth_initclient_socket(argv[1]);
#else
	s = tcp_initclient_socket(argv[1], 2004);
#endif
  
	if (!(buffer = malloc(MAXDIM))) {
		printf("Can't allocate data buffer\n");
		exit(1);
	}

	printf("Receiving ...\n");
	//Read buffers until EOF is reached
	int length = MAXDIM;
	tmpPtr = buffer;
    do {
    	//tmpPtr += nread;		
		nread = recv(s, tmpPtr, length, 0);
		//length -= nread;
		printf("nread value %d\n", nread);
    } while (nread > 0);
	close(s);	
}

--0-760872450-1098432202=:67706
Content-Type: text/x-csrc; name="serverTestRC.c"
Content-Description: serverTestRC.c
Content-Disposition: inline; filename="serverTestRC.c"

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <syslog.h>
#include <string.h>
#include <errno.h>
#include <ctype.h>
#include <signal.h>
#include <sys/time.h>
#include <sys/select.h>

#include <netinet/in.h>
#include <arpa/inet.h>
#include <resolv.h>
#include <netdb.h>
#include <sys/socket.h>

#include <bluetooth/bluetooth.h>
#include <bluetooth/rfcomm.h>
//#include <bluetooth/l2cap.h>

#include <sys/types.h>
#include <sys/ioctl.h>

#define MAXDIM 2048
#define BLUE
//#undef BLUE

int bluetooth_initserver_socket(int channel)
{
	struct sockaddr_rc server;
	bdaddr_t bdaddr;
	int s;

	/* Default options */	
	if ((s = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) < 0) {
		printf("Can't create socket. %s(%d)\n", strerror(errno), errno);
		exit(1);
	}

	memset(&server, 0, sizeof(server));
	server.rc_family = AF_BLUETOOTH;
	bacpy(&bdaddr, BDADDR_ANY);
	server.rc_bdaddr = bdaddr;
	server.rc_channel = htobs(channel);//channel;
	printf("Binding...\n");
	if (bind(s, (struct sockaddr *) &server, sizeof(server)) < 0) {
		printf("Can't bind socket. %s(%d)\n", strerror(errno), errno);
		exit(1);
	}
	printf("Bounded on channel %d\n", server.rc_channel);
	return s;
}

int tcp_initserver_socket(int port)
{
	struct sockaddr_in server;
	int s;

	if ((s = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
		printf("Can't create socket. %s(%d)\n", strerror (errno), errno);
		exit(1);
	}
	
	memset(&server, 0, sizeof(server));
	server.sin_family = AF_INET;
	server.sin_addr.s_addr = INADDR_ANY;
	server.sin_port = htons(port);
	
	printf("Binding...\n");
	if (bind(s, (struct sockaddr *) &server, sizeof(server)) < 0) {
		printf("Can't bind socket.%s(%d)\n", strerror (errno), errno);
		exit(1);
	}
	printf("Bounded  on port %d\n", port);
	return s;
}
	
int main(int argc, char *argv[])
{	
	//struct sockaddr_in clientAddr;
    int clientDescr, s, i;
	socklen_t clientAddrLen;

#ifdef BLUE
	struct sockaddr_rc clientAddr;
#else
    struct sockaddr_in clientAddr;
#endif
	

#ifdef BLUE	
	s = bluetooth_initserver_socket(10);
#else		
	s = tcp_initserver_socket(2004);
#endif	
	if (listen(s, 5) < 0)
  	{
    	//Error
		printf("Error in listen (%d)\n", strerror(errno), errno);
    	exit(1);
  	}
	printf("Listenning...\n");
	
  	//Accept a connection
  	memset(&clientAddr, 0, sizeof(clientAddr));
  	if ((clientDescr = accept(s, (struct sockaddr *) &clientAddr, &clientAddrLen)) < 0){
	  	printf("accept failed %s (%d)\n", strerror(errno), errno);
	  	exit(1);
	}
  	printf("accept ok\n");
  
  	char *buffer;
  	buffer = malloc(MAXDIM);

	for (i = 0; i < MAXDIM; i++)
		buffer[i] = MAXDIM - i;
	//Sends 5 packets of MAXDIM bytes
	for (i = 0; i < 5; i++){
		printf("loop %d\n", i);
		if (write(clientDescr, buffer, MAXDIM) < 0){
	 		printf("Error during write\n");
	 		return;
	 	}	
	}

  	close (clientDescr);
}

--0-760872450-1098432202=:67706--
