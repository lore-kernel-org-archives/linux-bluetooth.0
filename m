Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <444D00BC.4040606@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] pcm_a2dp_works
References: <20060418162647.2732.qmail@web31011.mail.mud.yahoo.com>
In-Reply-To: <20060418162647.2732.qmail@web31011.mail.mud.yahoo.com>
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
Date: Mon, 24 Apr 2006 10:45:48 -0600

Sergey

> i have made the pcm_a2dp plugin to work. mainly it was
> cut and past from a2play program. now i can select
> headphone as my alsa output device. XMMS and mplayer
> both work. 

I am very excited to see you have run with this and got it working. I
have been out of town and unable to try it but I applied it anyway (what
we had before didn't work at all... :)

> however, when XMMS finishes a song it does not start
> to play the next one.

There may be some more things we need to fix up in the plugin like
capabilities negotiation. Also, Marcel had worked on connection caching
so the connection wouldn't drop and have to be reestablished between
songs on xmms. I'm not sure if the code we have now does that right.

I'll be back tonight and be able to try things. Thanks tons.

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
