Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <444F10EB.90908@xmission.com>
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
Date: Wed, 26 Apr 2006 00:19:23 -0600

Sergey

> i have made the pcm_a2dp plugin to work. mainly it was
> cut and past from a2play program. now i can select
> headphone as my alsa output device. XMMS and mplayer
> both work. 

I made some changes to what you gave us. I made it use the system's
libsbc since the sbc inside the project is not built properly as a
shared lib (install libsbc from cvs in the
http://sourceforge.net/projects/sbc project)

I had to recode to retry some connections since alsa was interrupting
system calls.

However, I'm still finding that

aplay -B 1000000 -D pcm.headphone ~/sound.wav

will segfault. It's when the memmove at line 706 is being called with a
0 for the length to copy.

fwiw, my sound.wav is available at bluetooth-alsa.sf.net/sound.wav

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
