Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <5b9417770702072216m788bcf85i657e0c03c344f2f9@mail.gmail.com>
Date: Thu, 8 Feb 2007 00:16:17 -0600
From: "John H." <mistamaila@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <45CABF7E.8050908@gmail.com>
MIME-Version: 1.0
References: <45CA05A6.5000808@gmail.com> <45CA257C.9020904@gmail.com>
	<5b9417770702071127t4dcc7835h2e860b7992e2bb0c@mail.gmail.com>
	<45CA29F7.6070607@gmail.com>
	<5b9417770702071206t733f7c64s966c9249f7eadf28@mail.gmail.com>
	<45CA47A8.5000109@gmail.com>
	<5b9417770702071950g51f03979m21e636a53f4c0900@mail.gmail.com>
	<45CAA4A5.9070400@gmail.com>
	<5b9417770702072115n10392b6fo99f2eb60086e887b@mail.gmail.com>
	<45CABF7E.8050908@gmail.com>
Subject: Re: [Bluez-users] Is this list dead? Here is my problem...
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

Try unplugging the usb cable and turning off phone then back on... it
might also be worth your while to remove, in bluetooth settings, a
reference on your phone to your computer.

Then, just to be safe, put it in discovery mode and if there's a
setting for "allow other computers to connect," do that.

But really, before all of this, please let us know if konqueror
bluetooth:/// can access your phone.

On 2/8/07, Xamindar <junkxamindar@gmail.com> wrote:
> Yes it is on the phone, I use it all the time in Windows.  My phone will
> revert it's dial-up over to the serial port when I connect the phone to
> the computer with the cable but I always check that and switch the
> dial-up back to bluetooth.
>
>
> John H. wrote:
> > Yes, I have that error when bluetooth is not on on phone.  Are you sure it is?
> >
> > Does konqueror bluetooth:/// let you access the phone?
> >
> > On 2/7/07, Xamindar <junkxamindar@gmail.com> wrote:
> >
> >> John H. wrote:
> >>
> >>> Something like this
> >>>
> >>>
> >>> rfcomm connect 0 00:1A:77:ED:D1:97 4
> >>>
> >>> That makes rfcomm0 on channel 4.
> >>>
> >>>
> >> # rfcomm connect 00:12:56:5A:92:59 8
> >> Can't connect RFCOMM socket: Host is down
> >>
> >>
> >> Hmm, no luck :(
>
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier.
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
