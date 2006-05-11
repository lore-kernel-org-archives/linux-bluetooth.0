Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bluez-devel] A2DP and Alsa Plugin
Message-ID: <7A6DA545D7FDCC4B93DB651FDBC1EDDE46C2E7@eumonex01.palmsource.com>
From: "Frederic Dalleau" <Frederic.Dalleau@palmsource.com>
To: <bluez-devel@lists.sourceforge.net>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 11 May 2006 11:15:57 +0200

Brad,

> I've read about ALP. It looks exciting. I was glad to see ALP=20
> will include gstreamer as part of the foundation. You should=20
> help me write proper gstreamer plugins.

	I did not worry about gstreamer as I tried the gstreamer
alsasink yesterday. This allow you to create a graph with either
bluetooth output or alsa output without modifying your .asoundrc. Just
modify the device field. One address only as set in filename.

> alsa plugins use an api that is too simple for complete=20
> headset support... also there have been complaints about=20
> libalsa not scaling down for embedded systems.

	I'm new to alsa and gstreamer and I don't understand you yet.
Can you point me to document you use? I just saw that volume control
wasn't available with alsa-plugin if this is what you mean.

	However, I mainly worry about the following points :
	* I do not get 2 apps with a2dp output on the same address. As
devices seems to manage only one socket, the second app will generally
crash. Could we implement some sort of mixing or application selection
(the foreground app or the first app started on an address, but with
proper error handling for the others)?
	* How to select whether the application will output on a2dp or
speaker? Should this be application related or system related?
	* What you told me with gxine may vary depending the
application. I believe one way to handle this is to maintain
asynchronous connection to target sink. The api would just enqueue the
audio packets into a common shared queue (per target). The connection
simply close when there are no more audio packets.

	Did you change something since 0.42?

Frederic


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
