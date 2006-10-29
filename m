Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sun, 29 Oct 2006 08:23:29 +0100 (CET)
From: d@vide.bz
To: Brad Midgley <bmidgley@xmission.com>
Message-ID: <32681756.01162106609309@vide.bz>
References: <4543F342.2050506@xmission.com>
MIME-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bluetooth-alsa works with aplay but not with xmms
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


We are triing to use a bluetooth headset with skype
or xmms but unsucessfully. You can see the thread here:

http://www.slax.org/forum/viewtopic.php?p=68673#68673

I think we are triing to use the "OLD" method that is 
with the snd_bt_sco kernel module ...

Wich linux are using you? Can you send me the binary
files (make install can receive and option to install on a
custom root dir)

Thanks

Davide


-----Original Message-----
From: Brad Midgley <bmidgley@xmission.com>
Sent: Sun, Oct 29, 2006 02:18:10
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bluetooth-alsa works with aplay but not with xmms

Johannes

>     DEBUG: sco_pointer: returning bt_headset->hw_ptr=0

argh. I'm getting this too on a clean checkout. I'll dig through and
figure out what I missed.

Brad

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
