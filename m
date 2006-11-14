Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <ef9938ec0611132254j1982e79chf42264511b3aa0ac@mail.gmail.com>
Date: Tue, 14 Nov 2006 01:54:15 -0500
From: "Albert Huang" <albert@csail.mit.edu>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <20061113200431.22314.qmail@web32907.mail.mud.yahoo.com>
MIME-Version: 1.0
References: <20061113200431.22314.qmail@web32907.mail.mud.yahoo.com>
Subject: Re: [Bluez-users] Multiple Bluetooth adapters question
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

>     I know 100 may be too much to ask, but what do you think would be a
> resonable number if all are transmitting ?

There are 79 channels.  All devices in the same piconet should always
be on the same channel.  Thus, N independent piconets will (ignoring
AFH) be uniformly distributed on N channels across the 79 available.
Assuming they are truly independent, the chances that any of these
piconets choose the same channel is 1 - N! / ( (79^N) * (79-N)! )  For
1-15, this translates to:

1  0.0
2  0.012658227848101222
3  0.037654222079794852
4  0.074198998456511456
5  0.12107499853466286
6  0.17670316318436774
7  0.23923203686656758
8  0.30664185638471986
9  0.37685533928246973
10  0.44784650316168206
11  0.51773935086273504
12  0.58488956783121493
13  0.64794431702141009
14  0.70587753067611481
15  0.75800049992338558

These numbers reflect the probability that _any_ channel collision
occurs at a given point in time.  For > 80 active piconets, there will
_always_ be a channel collision.  It doesn't tell you expected packet
loss or anything useful like that.  You could calculate an expected
packet loss based on the expected number of channel collisions at any
given point in time.  That's a messy formula like expected(collisions)
= \sum_i probability(collisions=i) * i, where
probability(collisions=i) is another messy formula.

Of course, all of this is hand-wavy theory.  It would be nice if you
could try it out and report some results.

Regards,
Albert

> A related question is : what would be the behavior when too many devices are
> around ?
>
> Somewhere I read  that BT RF spectrum (2.4 to 2.485 GHz) is devivded in to
> 79 frequency hops.
> Correct me if I am wrong here : What I understand from this is that only 79
> BT devices can be active in an area ?
> Which approximately gives 10 adapters and 69 client devices .. does it make
> sense ??
>
> -B
>
>
>
>
> ----- Original Message ----
> From: Albert Huang <albert@csail.mit.edu>
> To: BlueZ users <bluez-users@lists.sourceforge.net>
> Sent: Monday, November 13, 2006 11:33:52 AM
> Subject: Re: [Bluez-users] Multiple Bluetooth adapters question
>
>
> You should experience "graceful" degradation of performance, as you
> increase the number of colocated transmitting devices.  100 is pushing
> it, but if not all are transmitting, then it should be okay.
>
> -albert
>
> On 11/13/06, Brown Dwarf <brown_drf@yahoo.com> wrote:
> >
> > Hi all,
> >      This may be a FAQ, but I could not locate an definit answer.
> >
> > I want to what are all the implications of having multiple bluetooth
> > adapters on a machine.
> > As you might have guessed, I would like to host more than 7 (say 100 ) BT
> > connections (SPP) at a time. I noticed BlueZ supports upto 16 adapters -
> > which means it can support upto 112 connections at a time ??
> >
> > Anybody ever tried it ?
> >
> > In other words, if I have 16 adapters installed on a box and have 100
> client
> > BT devices around, can they all communicate to one of those 16 adapters at
> > any time ? I don't know much about the RF side of the problem, but I am
> > little concerned about the fact that BT band-width is small. So can all
> > those devices resonabily share the narrow frequency space ?
> >
> > Any comments or pointers to any tech infomation / articles / resources
> will
> > be greatly appreciated.
> >
> > thanks in advance.
> > -B
> >
> >
> -------------------------------------------------------------------------
> > Using Tomcat but need to do more? Need to support web services, security?
> > Get stuff done quickly with pre-integrated technology to make your job
> > easier
> > Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> >
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> >
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
> >
> >
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job
> easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job
> easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
>
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>
>

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
