Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4471D778.6030301@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] A few tests: a2play aborts when hanging up the
 call. That's not the way it should work.
References: <20060522154201.3cff8m3ju4w0ck4o@mail.blas.net>
In-Reply-To: <20060522154201.3cff8m3ju4w0ck4o@mail.blas.net>
Content-Type: text/plain; charset=ISO-8859-15
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
Date: Mon, 22 May 2006 09:23:36 -0600

db

> While listening to stereo music with a2play, taking a call works (that the part
> of the headset) and the a2play keeps on to stream during the call. Normal.
> But when I hang up in order to go on and listen to the music the a2play detects
> a connection reset by peer and aborts.

Are these sets doing avrcp? It's possible that your headset likes to
send a pause command via avrcp to the a2dp streamer before taking the
voice call. If so, we should listen for avrcp pause and act accordingly.

I should probably combine a2play and avsnd but for now, start up

 avsnd <headsetbtaddr>

just after you start up a2play and watch the avrcp stream.

Brad




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
