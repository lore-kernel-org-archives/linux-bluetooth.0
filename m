Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Mon, 14 Aug 2006 08:42:46 +0100
Message-ID: <056BF200E9632F4285220E570FEED673DF4289@GBMDDMH202AMSX.gb001.siemens.net>
In-Reply-To: <1155404142.5059.18.camel@localhost>
From: "Waldram, Andrew (SBS UK)" <andrew.waldram@siemens.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] A2DP plugin success with HP bluetooth headphones
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

 =

Try Fr=E9d=E9ric's alternative deamon and see how you go.

Quote from Fr=E9d=E9ric's reply to an issue I had (which the deamon version=
 solved)
It's also got some way cool features (forward back play pause from the head=
set in xmms (check the mail thread with mine and Fr=E9d=E9ric's names on fo=
r patches as I'm not sure there in the main cvs yet)).




>I use xmms everyday. Have a look at a2dpd. It's an alternative a2dp =

>plugin and a daemon. You'll easily set it up and you can find =

>documentation here :
>    =

>http://sourceforge.net/mailarchive/forum.php?thread_id=3D20199009&forum_id=
=3D1881
---------------------------------------------------------------------------=
------- =



-----Original Message-----
From: bluez-devel-bounces@lists.sourceforge.net [mailto:bluez-devel-bounces=
@lists.sourceforge.net] On Behalf Of Scott Gilliland
Sent: 12 August 2006 18:36
To: BlueZ development
Subject: Re: [Bluez-devel] A2DP plugin success with HP bluetooth headphones

Matt,

By audio droupouts, do you mean like 1-2 seconds of silence, every 45
secs or so? I'm experiencing just that on my Anycom headset, also with
no clue where to start looking for answers, other than mulling in the c
code.


On Thu, 2006-07-13 at 01:42 +0100, Matthew Garrett wrote:
> Hi,
> =

> I've finally got around to retesting my HP bluetooth headphones with the =

> latest alsa-plugin code. They work almost perfectly, though with =

> occasional brief audio dropouts. There doesn't seem to be any good =

> pattern to these. Is there a good way of diagnosing what the problem =

> might be?



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
