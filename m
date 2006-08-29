Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <8712867d0608281814v3dc61491u1251bc54ee6cb660@mail.gmail.com>
Date: Mon, 28 Aug 2006 20:14:36 -0500
From: "Jaime Alberto Silva" <jaimealbertosilva@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <20060829001859.79329.qmail@web25713.mail.ukl.yahoo.com>
MIME-Version: 1.0
References: <20060829001859.79329.qmail@web25713.mail.ukl.yahoo.com>
Subject: Re: [Bluez-users] hci0 only comes up with PSCAN (no ISCAN)
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Ray, I had the same problem, checkout:

http://thread.gmane.org/gmane.linux.bluez.user/10386/focus=3D10386

It has been treated in this list before under the topic:

Fwd: bluez-utils: The inquiry scan (ISCAN) gets turned off

On 8/28/06, Ray <whatdoineed2do@yahoo.co.uk> wrote:
> hi,
>
> i have a problem in that my hci0 device only ever
> comes up with pscan (without iscan) and this is
> causing me problems.
>
> i have started the manually started the daemons but no
> luck
>
>     $ hcid; sdpd; hciconfig hci0 up piscan noauth
>
> still shows up as (just pscan!!!)
>
>     $ hciconfig -a
>     hci0:   Type: USB
>         BD Address: 00:0E:9B:68:B8:37 ACL MTU: 192:8
> SCO MTU: 64:8
>         UP RUNNING PSCAN
>         RX bytes:12448 acl:176 sco:0 events:322
> errors:0
>         TX bytes:4767 acl:157 sco:0 commands:104
> errors:0
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00
> 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2
> HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'BlueZ@marty (0)'
>         Class: 0x3e0100
>         Service Classes: Networking, Rendering,
> Capturing, Object Transfer,
> Audio
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1
> (0x1) LMP Subver: 0x20d
>         Manufacturer: Cambridge Silicon Radio (10)
>
> i googled this and found another person with the same
> problem but no ans.  using linux 2.6.15 with bluez 3.4
> utils/libs
>
> can anyone suggest what i'm doing wrong
> thanks
> -r
>
> # /etc/bluetooth/hcid.conf
> options {
>         autoinit yes;
>         security auto;
>         pairing multi;
>         passkey "1234";
> }
>
> device {
>         name "BlueZ@%h (%d)";
>
>         class 0x3e0100;
>
>         # Inquiry and Page scan
>         iscan enable;
>         pscan enable;
>
>         lm accept;
>         lp rswitch,hold,sniff,park;
> }
>
>
>
> ___________________________________________________________
> Try the all-new Yahoo! Mail. "The New Version is radically easier to use"=
 =96 The Wall Street Journal
> http://uk.docs.yahoo.com/nowyoucan.html
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job ea=
sier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-- =

Jaime Alberto Silva
   L I N U X      .~.
The Choice     /V\
 of a GNU      / ( ) \
Generation    ^^-^^

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
