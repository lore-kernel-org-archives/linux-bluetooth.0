Return-Path: <cyrus@holtmann.org>
Message-ID: <49DA5249.30008@web.de>
Date: Mon, 06 Apr 2009 21:04:41 +0200
From: Eiko Oltmanns <eiko.oltmanns@web.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: problem with reading from rfcomm socket
References: <49D511C2.5040304@web.de>
In-Reply-To: <49D511C2.5040304@web.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Eiko Oltmanns schrieb:
> Hi!
>
>
> I have a problem, with reading from rfcomm sockets. I wrote a little 
> client application, that connects to an other device and just prints 
> all received data. I want to receive data as soon as it is sent from 
> the remove device. The problem is, that the read function blocks, 
> until 4k of data are sent on the remote side, although the number of 
> requested bytes passed to read is much lower. Then read starts to read 
> out the received data. When all data has been read, the next call 
> again blocks until the next 4 kb are available.
>
> Distribution: Debian, "Lenny"
> Kernelversion: 2.6.26-13
> Bluez-libs: 3.36-1
> Bluez-utils: 3.36-3
>
>
> Here is the minimal code, which reproduces my problem:
>
>
> int main(int argc, char **argv)
> {
>     int sock = hci_open_dev( devId );
>
>     if ( sock < 0 ) return -1;
>
>     int rfcommSocket = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
>     if ( rfcommSocket < 0 ) return -1;
>
>     struct sockaddr_rc addr;
>     addr.rc_family = AF_BLUETOOTH;
>     addr.rc_channel = channel;
>     str2ba("00:09:DD:50:72:0F", &addr.rc_bdaddr );
>     
>     // connect to server
>     int status = connect(rfcommSocket, (struct sockaddr *)&addr, 
> sizeof(addr));
>
>     if (  status < 0 ) rerurn - 1;
>
>     int bytes = write(rfcommSocket,"Test",4);    /* works as expected. 
> Data is received immediately by the remote device */
>
>     if ( bytes != 4 ) return - 1; //tested only for 4 for simplicity
>
>     while (1)     {
>         unsigned char buf[10];        /* the buf size seems to have no 
> influence on my problem */
>         memset( buf, 0, sizeof(buf));
>         int bytes = read(rfcommSocket, buf, sizeof(buf)-1); /* blocks 
> until 4k of data are available */
>
>         if ( bytes > 0 )
>             cout << buf;
>         if ( bytes < 0 )
>         {
>             return -1;
>         }
>
>     }
>     return 0;
> }
>
> Greetings,
> Eiko

I think my code should be correct, isn't it? Is there maybe an option in 
the kernel config, that could cause such a behaviour of the socket? I am 
running a self configured kernel on an embedded hardware. Any other 
suggestions?

