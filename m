Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <5b9417770702071127t4dcc7835h2e860b7992e2bb0c@mail.gmail.com>
Date: Wed, 7 Feb 2007 13:27:19 -0600
From: "John H." <mistamaila@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <45CA257C.9020904@gmail.com>
MIME-Version: 1.0
References: <45CA05A6.5000808@gmail.com>
	<20070207102742.gs40wgg8coc4048w@www.webmail4.com>
	<45CA1BE6.5040907@pracucci.com> <45CA257C.9020904@gmail.com>
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

First off, are you sure that's the DUN channel?


On 2/7/07, Xamindar <junkxamindar@gmail.com> wrote:
> Thanks for the replies.  I guess I'll go ahead and ask my question here
> and then go try the irc channel as well.  On Freenode right?
>
> I am trying to get dail up working between my phone and gentoo linux via
> bluetooth.  I have so far been unsuccessful.
> I can scan and see my phone but my phone is not able at this time to see
> my laptop on a scan.
>
> [code]
> white-rabbit xamindar # hciconfig
> hci0:   Type: USB
>         BD Address: 00:16:CF:D7:AE:62 ACL MTU: 1017:8 SCO MTU: 64:0
>         UP RUNNING PSCAN
>         RX bytes:405 acl:0 sco:0 events:18 errors:0
>         TX bytes:320 acl:0 sco:0 commands:18 errors:0
>
> white-rabbit xamindar # hcitool scan
> Scanning ...
>         00:17:5C:00:68:5F       Sidekick
>         00:12:56:5A:92:59       Jared`s LG CU500
> white-rabbit xamindar #
> [/code]
>
>
> I have rfcomm.conf set up to bind to my phone's MAC on channel 8.  I
> found out that channel 8 is the "QC Dial-up Networking" service on my
> phone by running "sdptool browse 00:12:56:5a:92:59".
>
> [code]
> white-rabbit xamindar # cat /etc/bluetooth/rfcomm.conf
> rfcomm0 {
>         bind yes;
>         device 00:12:56:5a:92:59;
>         channel 8;
>         comment "Jared`s LG CU500";
> }
> white-rabbit xamindar # rfcomm
> rfcomm0: 00:12:56:5A:92:59 channel 8 clean
> [/code]
>
> At this point everything looks good but for some reason I am unable to
> get any actual communication to work.  I get the following error when
> testing the rfcomm connection:
>
> white-rabbit xamindar # rfcomm connect 0
> Can't create RFCOMM TTY: Address already in use
>
> I seem to not be able to send files to my phone either so it seems that
> bluetooth on my laptop is completely broken.  I have set up this same
> thing on a friend's ubuntu installation and got it working in about 15
> minutes.  I don't get it.
>
> Thanks for any help and pointers on this guys.
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
