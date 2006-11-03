Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <454BB404.2070606@xmission.com>
Date: Fri, 03 Nov 2006 14:26:28 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: Olivier Le Pogam <olepogam@free.fr>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
References: <001001c6ff87$c1d41f50$0100a8c0@kayleigh>
In-Reply-To: <001001c6ff87$c1d41f50$0100a8c0@kayleigh>
Subject: Re: [Bluez-devel] To blueZ developers : can't do two
 "connect"	concurrently, help required !
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Olivier

This thing tends to happen if you have the wrong end of the connection
being master. Make sure your linux box has master in the lm line in
hcid.conf and that your clients do not.

Brad

> For the ones who have read my messages a few days ago ...
> I am still performing concurrency tests !
>  
> I run a server on 2 remote devices (one on channel 24, the
> other on channel 25), and I try to connect to them concurrently
> from the same Linux box / BT key (the remote servers are simple "echo"
> ones, the linux client is sending numbers from 1 to 10 with a sleep(1) at
> each step).
>  
> I have a simple batch :
>  
> client.sh :
> ./client 00:16:4E:83:2D:19  25 &
> ./client 00:0D:88:9B:FF:D7  24 &
>  
> where client is called with BDADDR and channel
>  
> Here is what I get in my logs :
>  
> Connection to remote 00:16:4E:83:2D:19 channel 25
> Connection to remote 00:0D:88:9B:FF:D7 channel 24
> [00:16:4E:83:2D:19] Can't connect(111)    ====> 111 is connection refused
> [00:0D:88:9B:FF:D7] Connected to remote 00:0D:88:9B:FF:D7 channel 24,
> from local 00:11:67:0D:2E:2C channel 24
> [00:0D:88:9B:FF:D7] Sent 0 received 0
> ...
>  
> If I swap the order of calling "client" i.e :
>  
> client.sh :
> ./client 00:0D:88:9B:FF:D7  24 &
> ./client 00:16:4E:83:2D:19  25 &
>  
> Then it's still the first which can't connect (now it will be
> 00:0D:88:9B:FF:D7)
>  
> So basically, it seems that there can't be two "connect"
> concurrently on the same adaptor.
>  
> Can please BlueZ developers confirm ?
>  
> Thanks a lot
> Oli
>  
> For who is interested, here is the interesting part of client.c :
>  
> int main(int argc, char **argv)
> {
>     struct sockaddr_rc laddr, raddr;
>     int sk, i;
>  
>     memset(&laddr, 0, sizeof(laddr));
>     memset(&raddr, 0, sizeof(raddr));
>  
>     laddr.rc_family = AF_BLUETOOTH;
>     bacpy(&laddr.rc_bdaddr, BDADDR_ANY);
>     laddr.rc_channel = 0;
>  
>     raddr.rc_family = AF_BLUETOOTH;
>     str2ba(argv[1], &raddr.rc_bdaddr);
>     raddr.rc_channel = atoi(argv[2]);
>  
>    if (argc != 3) {
>      fprintf(stderr,"Usage: client address channel\n");
>      exit(EXIT_FAILURE);
>    }
>  
>  debugOutput("Connection to remote %s channel %s", argv[1], argv[2]);
>  
>     sk = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
>     if (sk < 0) {      
>         debugOutput("[%s] Can't create RFCOMM socket", argv[1]);
>         return -1;
>     }
>  
>     if (bind(sk, (struct sockaddr *)&laddr, sizeof(laddr)) < 0) {
>         debugOutput("[%s] Can't bind RFCOMM socket", argv[1]);
>         close(sk);
>         return -1;
>     }
>  
>     if (connect(sk, (struct sockaddr *)&raddr, sizeof(raddr)) < 0) {
>         debugOutput("[%s] Can't connect(%d)", argv[1], errno);
>         close(sk);
>         return -1;
>     }
>  
>  char loc_addr[30];
>  strcpy(loc_addr, "");
>  
>     int len = sizeof(laddr);
>     if (getsockname (sk, &laddr, &len ) > 0)
>        debugOutput("[%s] Can't getsockname", argv[1]);
>  else ba2str(&laddr.rc_bdaddr, loc_addr);
>   
>  debugOutput("[%s] Connected to remote %s channel %s, from local %s
> channel %d", argv[1], argv[1], argv[2], loc_addr, laddr.rc_channel);
>  
>  for (i = 0; i<10; i++)
>  {
>   char buf[1024];
>   sprintf(buf, "%d%c", i, 10);
>   write(sk, buf, strlen(buf));
>   strcpy(buf, "");
>   
>   readString(sk, buf);
>   if( strlen(buf) > 0 ) {
>    debugOutput("[%s] Sent %d received %s", argv[1], i, buf);
>     } else {
>    debugOutput("[%s] Sent %d received no answer", argv[1], i);
>    break;
>   }
>   sleep(1);
>  }
>  
>     close(sk);
>  debugOutput("[%s] Disconnected", argv[1]);
>  
>     return 0;
> }
> 
> 
> ------------------------------------------------------------------------
> 
> No virus found in this outgoing message.
> Checked by AVG Free Edition.
> Version: 7.1.409 / Virus Database: 268.13.25/515 - Release Date: 03/11/2006
> 
> 
> 
> ------------------------------------------------------------------------
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
