Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <5b9417770702071950g51f03979m21e636a53f4c0900@mail.gmail.com>
Date: Wed, 7 Feb 2007 21:50:27 -0600
From: "John H." <mistamaila@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <45CA47A8.5000109@gmail.com>
MIME-Version: 1.0
References: <45CA05A6.5000808@gmail.com>
	<20070207102742.gs40wgg8coc4048w@www.webmail4.com>
	<45CA1BE6.5040907@pracucci.com> <45CA257C.9020904@gmail.com>
	<5b9417770702071127t4dcc7835h2e860b7992e2bb0c@mail.gmail.com>
	<45CA29F7.6070607@gmail.com>
	<5b9417770702071206t733f7c64s966c9249f7eadf28@mail.gmail.com>
	<45CA47A8.5000109@gmail.com>
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

Something like this


rfcomm connect 0 00:1A:77:ED:D1:97 4

That makes rfcomm0 on channel 4.


On 2/7/07, Xamindar <junkxamindar@gmail.com> wrote:
> John H. wrote:
> > Yes, it looks as though you do.  Can you do a regular rfcomm connect?
> > What if you use rfcomm1?
> >
> What is a regular rfcomm connect?  On the console it just gives me errors.
>
> white-rabbit xamindar # rfcomm
> rfcomm1: 00:12:56:5A:92:59 channel 8 clean
> white-rabbit xamindar # rfcomm connect 1
> Can't create RFCOMM TTY: Address already in use
> white-rabbit xamindar #
>
>
> One interesting thing is if I change the rfcomm to my phone to channel 3
> then when I try a connect my phone will beep like it is receiving a file
> but nothing else happens.  I will also still get the same "Address
> already in use" as I do with channel 8.
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
