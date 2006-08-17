Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44E422A6.3000204@palmsource.com>
Date: Thu, 17 Aug 2006 10:02:46 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <056BF200E9632F4285220E570FEED673E7F222@GBMDDMH202AMSX.gb001.siemens.net>
In-Reply-To: <056BF200E9632F4285220E570FEED673E7F222@GBMDDMH202AMSX.gb001.siemens.net>
Subject: Re: [Bluez-devel]
 a2pdbtsco	won'tcompile	(FIX)	plus	xmmserror(trials andtribulations)	howcool
 is	this!!!	new patch
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

Try to use the latest patch http://fdalleau.free.fr/patch_to_try
Minor changes has been done. It worked all night long!

Fr=E9d=E9ric


Waldram, Andrew (SBS UK) a =E9crit :
> Thanks for the reply no worries where not saving the planet ;-)
>
> Think it's probably
>
>  >>Make sure you have a cmdnew=3D line in .a2dprc.
>
> As I didn't know that was an option now ;-)
>
> I'll do it this evening
>
> On my headset play/pause is a pretty mute point as it's the same button.
>
> My headset also times out but you can tell if its on yer ead as it give a=
 downward arpegio? =

>
> I'll try advertising the services too
>
>
> -------------------------------------------------------------------------=
--------- =

>
>
> -----Original Message-----
> From: bluez-devel-bounces@lists.sourceforge.net [mailto:bluez-devel-bounc=
es@lists.sourceforge.net] On Behalf Of Fr=E9d=E9ric DALLEAU
> Sent: 16 August 2006 15:56
> To: BlueZ development
> Subject: Re: [Bluez-devel] a2pdbtsco won'tcompile (FIX) plus xmmserror(tr=
ials andtribulations) howcool is this!!! new patch
>
> Hi Andrew,
>
> Sorry to have waited so long, thank you for the tests! I really appreciat=
e!
>
> When I asked you the hcidump, I thought that the headset would not =

> connect to the daemon.
> But the first test shows us that the heaset sends Discover cmd and the =

> Discover rej answer is sent. I really doubt it is something else than =

> a2dpd (avrecv?) who answer. So I assume we got the message. Thus, there =

> is no reason why xmms is not started. Make sure you have a cmdnew=3D line =

> in .a2dprc. Try giving full path to xmms in config file.
> The command line parser is really weak only the first param is used : =

> things like 'xmms --play' will work, but 'xmms xyz --play ' won't. even =

> using a space between =3D and xmms will fail. Also using more than one =

> space between xmms and --play will fail! To see if it has been parsed =

> correctly, there are some 'forked...' messages in a2dpd output. TAB =

> instead of space will fail too. In fact, the line must be exactly: =

> cmdnew=3Dxmms[space]--play
>
> Apart from that, here are a few keys in order to have more informations =

> : It seems that the headset will feel better if the sdp record is =

> advertised first : sdptool add A2SRC; sdptool add AVRTG
>
> Make sure only one instance of a2dpd is started by issuing 'killall =

> a2dpd' or 'killall -9 a2dpd' before testing.
>
> The daemon is slow to react if you are not connected so make sure you =

> wait a few seconds before pressing play multiple times.
>
> When the headset is disconnected, the only accepted command is play. In =

> other words, pause, next and prev only works when sound is sent. There =

> are two distinct plays : one when sound has been sent during the last =

> previous 15 seconds. The other one is when there has been no sound : =

> headset initiated connexion. Do you see some "avdtp:" prefixed messages =

> in a2dpd output?
>
> Last, my HP headphone must be switched on first (long press on play =3D> =

> blue led blinking slowly), then only play can be pressed (short press) =

> to make connection. And it will automatically switch off on timeout. So =

> sometimes, you believe it is on, and it is not, so pressing anything =

> will fail.
>
> Thanks,
> Fr=E9d=E9ric.
>
>
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job ea=
sier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job ea=
sier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>   =



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
