Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <444F2EE1.3030300@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] pcm_a2dp_works
References: <20060418162647.2732.qmail@web31011.mail.mud.yahoo.com> <444F10EB.90908@xmission.com>
In-Reply-To: <444F10EB.90908@xmission.com>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Wed, 26 Apr 2006 02:27:13 -0600

guys

woooooo... after more tweaks the alsa plugin is finally working (mostly)
for me. I've only played through xmms and aplay. The strangeness now is
the xmms display looks like it's jittering around and it gets "stuck" at
the end of a song, sometimes crashing with "alsa mixer timed out."

If it doesn't crash, I can click the next-track button or drag the
slider to the end of the song to have it start the next one.

i've elaborated in the alsa-plugins/BUILD document. i'm requiring the
external libsbc build now since the version in the project isn't
properly built for use by shared objects and the codec is going to be
maintained externally anyway.

brad


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
