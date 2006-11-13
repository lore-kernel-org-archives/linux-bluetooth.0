Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <ef9938ec0611131133o640612e4q870839f2cc7de67b@mail.gmail.com>
Date: Mon, 13 Nov 2006 14:33:52 -0500
From: "Albert Huang" <albert@csail.mit.edu>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <20061113095553.11179.qmail@web32912.mail.mud.yahoo.com>
MIME-Version: 1.0
References: <20061113095553.11179.qmail@web32912.mail.mud.yahoo.com>
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

You should experience "graceful" degradation of performance, as you
increase the number of colocated transmitting devices.  100 is pushing
it, but if not all are transmitting, then it should be okay.

-albert

On 11/13/06, Brown Dwarf <brown_drf@yahoo.com> wrote:
>
> Hi all,
>      This may be a FAQ, but I could not locate an definit answer.
>
> I want to what are all the implications of having multiple bluetooth
> adapters on a machine.
> As you might have guessed, I would like to host more than 7 (say 100 ) BT
> connections (SPP) at a time. I noticed BlueZ supports upto 16 adapters -
> which means it can support upto 112 connections at a time ??
>
> Anybody ever tried it ?
>
> In other words, if I have 16 adapters installed on a box and have 100 client
> BT devices around, can they all communicate to one of those 16 adapters at
> any time ? I don't know much about the RF side of the problem, but I am
> little concerned about the fact that BT band-width is small. So can all
> those devices resonabily share the narrow frequency space ?
>
> Any comments or pointers to any tech infomation / articles / resources will
> be greatly appreciated.
>
> thanks in advance.
> -B
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
