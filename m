Return-Path: <dyonutz@yahoo.com>
Message-ID: <20040616111157.53863.qmail@web50904.mail.yahoo.com>
Date: Wed, 16 Jun 2004 04:11:57 -0700 (PDT)
From: ionut dediu <dyonutz@yahoo.com>
Subject: Re: [Bluez-devel] Problem with read on RFCOMM Sockets
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <1087339769.13792.106.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

Hi

Here is the source code. For testing the receiving of
data I tried commenting the select loop, and do just
receiveData, and I get the same results: read returns
the correct number of bytes, but in the buffer is
copied just one byte of data. Please tell me if I'm
doing smth wrong. Thanks a lot.

#include <unistd.h>
#include <syslog.h>
#include <errno.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#include <sys/types.h>
#include <sys/socket.h>
#include <sys/select.h>

#include <bluetooth/bluetooth.h>
#include <bluetooth/rfcomm.h>

#define BT_LOCAL_ADDR "00:0C:76:D3:4C:D3"
#define BT_REM_NOKIA_ADDR "00:60:57:D2:27:66"

#define DIM 256
#define STDIN 0
#define STDOUT 1

char userBuf[DIM];
char remoteBuf[DIM];

int clientSocket = 0;

int do_connect(char * remAddr)
{
	struct sockaddr_rc rem_addr, loc_addr;
	int s;

	if ((s = socket(PF_BLUETOOTH, SOCK_STREAM,
BTPROTO_RFCOMM)) < 0) {
		syslog(LOG_ERR, "Can't create socket. %s(%d)",
strerror(errno), errno);
		return -1;
	}

	memset(&loc_addr, 0, sizeof(loc_addr));
	loc_addr.rc_family = AF_BLUETOOTH;
	str2ba(BT_LOCAL_ADDR, &loc_addr.rc_bdaddr);
	if (bind(s, (struct sockaddr *) &loc_addr,
sizeof(loc_addr)) < 0) {
		printf("Can't bind socket. %s(%d)", strerror(errno),
errno);
		exit(1);
	}

	memset(&rem_addr, 0, sizeof(rem_addr));
	rem_addr.rc_family = AF_BLUETOOTH;
	baswap(&rem_addr.rc_bdaddr, strtoba(remAddr));
	rem_addr.rc_channel = 4;
	if (connect(s, (struct sockaddr *)&rem_addr,
sizeof(rem_addr)) < 0 ) {
		printf("Can't connect. %s(%d)\n", strerror(errno),
errno);
		close(s);
		return -1;
	}

	printf("Connected\n");

	return s;

}

int receiveData()
{
	int noBytesRead = 0;
	memset(remoteBuf, 0, DIM);
	noBytesRead = read(clientSocket, remoteBuf, DIM);
	if(noBytesRead == -1)
	{
		printf("Can't read. %s(%d)\n", strerror(errno),
errno);
		exit(-1);
	}
	if(noBytesRead == 0)
	{
		printf("Disconnected\n");
		exit(0);
	}
	printf("REMOTE[%d](strlen = %d) : %s\n", noBytesRead,
strlen(remoteBuf), remoteBuf);
	return noBytesRead;
//	write(STDOUT, buf, strlen(buf));
}

int sendData()
{
	memset(userBuf, 0, DIM);
	read(STDIN, userBuf, DIM);
	if(write(clientSocket, userBuf, strlen(userBuf)) !=
strlen(userBuf))
	{
		printf("Can't write. %s(%d)\n", strerror(errno),
errno);
		return -1;
	}
	return 0;
}

int main(int argc, char** argv)
{
	fd_set read_fds;	//fd_set used in select()
	fd_set tmp_fds;		//fd_set temporary fds
	int fdmax;		//maximum no of file descriptors
	int i = 0;

	clientSocket = do_connect(BT_REM_NOKIA_ADDR);
	FD_SET(clientSocket, &read_fds);
	FD_SET(STDIN, &read_fds);
	fdmax = clientSocket;
/*	while(1)
	{
		receiveData();
	}*/
	// main loop
	while(1)
	{
		tmp_fds = read_fds;
		if(select(fdmax + 1, &tmp_fds, NULL, NULL, NULL) ==
-1)
		{
			printf("ERROR in select. %s(%d)\n",
strerror(errno), errno);
			exit(errno);
		}
		else
		{
			for(i = 0; i <= fdmax; i++)
			{
				if(FD_ISSET(i, &tmp_fds))
				{
					// received data from the bluetooth end point
		    			if(i == clientSocket)
					{
						receiveData();
					}
					// received input data from the user
					if(i == STDIN)
					{
						sendData();
					}
				}
			}
		}
	}

	close (clientSocket);
	return 0;
}




	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 
