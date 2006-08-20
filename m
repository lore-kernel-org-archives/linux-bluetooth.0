Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <8712867d0608191723n1c5d2be5vdf5a280898ec1b5f@mail.gmail.com>
Date: Sat, 19 Aug 2006 19:23:22 -0500
From: "Jaime Alberto Silva" <jaimealbertosilva@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1156037732.3989.10.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
References: <8712867d0608190931o3f6042eyfdb6fdff805f91b@mail.gmail.com>
	<1156037732.3989.10.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-users] libbluetooth usage
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

Hi Marcel,

On 8/19/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Jaime,
>
> > Can someone please point me to some documentation about libbluetooth usage?
> >
> > How can I use this library to establish comunication with a BT device?
> >
> > I'm trying to write a program in J2ME for my Nokia 6670 that
> > communicates with my Linux PC via RFCOMM. If I use the rfcomm utility
> > like this:
> >
> > # rfcomm bind 0 00:02:5B:00:A5:A5
> >
> > All I have to do is write a program that opens the rfcomm0 serial port
> > and waits for data? How can I detect when the client connects?
>
> who is the client?

The client is the phone, the PC will have an application waiting for
connections from the phone.

>
> > How do I use the RFCOMM socket interface?
>
> The programs rctest.c and attest.c give a good example on how to use the
> RFCOMM socket interface.

Hmm, I guess those doesn't come in the Debian packages, Where can I find them?


-- 
Jaime Alberto Silva       L I N U X       .~.
                                   The Choice     /V\
                                    of a GNU      / ( ) \
                                   Generation    ^^-^^

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
