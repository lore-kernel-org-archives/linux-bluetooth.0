Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <016d01c4df70$a8e297d0$6401000a@zool>
From: "Steffen Larsen" <zool@zool.dk>
To: <bluez-devel@lists.sourceforge.net>
References: <00c901c4df6a$f8c11f70$6401000a@zool> <1102764489.19086.15.camel@pegasus>
Subject: Re: [Bluez-devel] piconet..
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
Date: Sat, 11 Dec 2004 12:00:43 +0100

Hi Marcel,

> Hi Steffen,
> 
> > I am trying to form a piconet, consisting of one server and two
> > clients. I have snaped the most of the code from l2test.c and also
> > made an advertising service and all. My problem is just that one one
> > client can connect and the other one fails (host is down, i belive) .
> > I have implemented the server using fork(), so that the parent process
> > is still listening for new connections and closing my sockets correct
> > (as what I can see..).
> > I have browsed this newsgroup for answers, and can see something about
> > setting the master/slave switch should help. I have also tried this,
> > but it dosn't help. Anyone that have a clue about, what could be
> > wrong?? 
> 
> show us the output of "hciconfig -a" for your devices.

ok.. I will do this later today. :-)
  
> > PS. I belive that the PSM in the L2CAP layer can serve more than one
> > client or am I totally wrong? otherwise I should update the PSM
> > everytime a new client connect..
> 
> It can also serve multiple PSM on the same ACL link.

Ok.. how do I do that?

Currently I am setting the PSM on my socket like this:

<code snip>
loc_addr.l2_family = AF_BLUETOOTH;

bacpy(&loc_addr.l2_bdaddr, local_bdaddr);

loc_addr.l2_psm = htobs(psm);


if (bind(sk, (struct sockaddr *) &loc_addr, sizeof(loc_addr)) < 0) {

printf("could not bind socket: %i\n", sk);

syslog(LOG_ERR, "Can't bind socket. %s(%d)", strerror(errno), errno);

exit(1);

}

</code snip>


/Steffen Larsen


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
