Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] No more bluez.o in 2.6?
References: <20040407172325.GC9593@magma.epfl.ch>
            <1081417632.2970.0.camel@pegasus>
            <20040408150029.GA5539@magma.epfl.ch>
In-Reply-To: <20040408150029.GA5539@magma.epfl.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Message-ID: <200404081802.05140.cijoml@volny.cz>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 8 Apr 2004 18:02:05 +0200

Hi,

this is not BT problem, so ask in pppd mailing list.

Bye

Michal

Dne =E8t 8. dubna 2004 17:00 Gregoire Favre napsal(a):
> On Thu, Apr 08, 2004 at 11:47:12AM +0200, Marcel Holtmann wrote:
> > Hi Gregoire,
>
> Hello Marcel and others :-)
>
> > > I compiled 2.6.5-mm2 again, with all blutooth in, and now I can see my
> > > bluetooth device ;-) I can also scan my Palm device.
> > > I try http://www-jcsu.jesus.cam.ac.uk/~ned21/tech/tungsten_linux.html
> > > and after dund --listen --persist --msdun call dun
> > > I got the following error when I try to connect:
> > > dund[3647]: RFCOMM TTY creation failed. Operation not supported(95)
> >
> > this error is because you didn't set CONFIG_BT_RFCOMM_TTY in your kernel
> > config.
>
> You're totally right!!!
>
> Now, some kernels recompilation later, I still have a problem which I
> don't know how to solve:
>
> dund[3539]: DUN daemon ver 1.1
> dund[3554]: New connection from 00:...
> pppd[3561]: pppd 2.4.1 started by root, uid 0
> pppd[3561]: Using interface ppp0
> pppd[3561]: Connect: ppp0 <--> /dev/rfcomm0
> pppd[3561]: Cannot determine ethernet address for proxy ARP
> pppd[3561]: local  IP address 192.168.1.2
> pppd[3561]: remote IP address 172.31.130.67
> pppd[3561]: IPCP terminated by peer
> pppd[3561]: Hangup (SIGHUP)
> pppd[3561]: Modem hangup
> pppd[3561]: Connection terminated.
> pppd[3561]: Connect time 0.8 minutes.
> pppd[3561]: Sent 571 bytes, received 322 bytes.
> pppd[3561]: Exit.
>
> And after that, I cannot try to connect anymore...
>
> What I am trying just now:
> pilot-xfer -p net:any -i AESLib.prc TuSSH0.69.prc
> always following
> http://www-jcsu.jesus.cam.ac.uk/~ned21/tech/tungsten_linux.html
>
> Thank you very much,
>
> 	Gr=E9goire
> __________________________________________________________________________
> http://algebra.epfl.ch/greg ICQ:16624071 mailto:Gregoire.Favre@freesurf.ch
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=3DClick
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
