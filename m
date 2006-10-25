Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d23110170610251558l6820a1c3jc9eb871b60cdfb1f@mail.gmail.com>
Date: Wed, 25 Oct 2006 19:58:19 -0300
From: "Ulisses Furquim" <ulissesf@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <77ADC7D0C96B1F44A924DC4E952A5E0E01120781@AZ25EXM01.gddsi.com>
MIME-Version: 1.0
References: <1161318583.27585.24.camel@localhost>
	<77ADC7D0C96B1F44A924DC4E952A5E0E01120781@AZ25EXM01.gddsi.com>
Subject: Re: [Bluez-users] Bluez/bluetooth newbie
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

On 10/25/06, Turley, Scott-P27856 <Scott.Turley@gdc4s.com> wrote:
> When I try to run the server side library on the Linux machine, and
> attempt to make a connection over the hyperterminal, I get an error
> message:  "Connection attempt failed because the remote device does not
> support the Serial Port Profile".

I guess your server side code hasn't added a service on the local sdpd
so the remote doesn't know you do support SPP. You can add a service
on the local sdpd inside your code or you can use sdptool to do it.
All you need is:

  # sdptool add --channel=<channel number> SP

Regards,

-- Ulisses

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
