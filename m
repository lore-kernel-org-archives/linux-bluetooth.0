Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4450C705.8060206@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Advanced Audio Distribution Profile for Bluez
References: <20060427121645.95821.qmail@web26905.mail.ukl.yahoo.com>
In-Reply-To: <20060427121645.95821.qmail@web26905.mail.ukl.yahoo.com>
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
Date: Thu, 27 Apr 2006 07:28:37 -0600

javier

>  I am preparing my final project based on the bluez stack. It have to implement 
>  the A2DP (Advanced Audio Distribution Profile). So, I would like to contribute to the 
>  bluez stack with an implementation of the profile, following the requeriments of the official 
>  profile and according to the actual structure of the stack.

We have implemented some a2dp already. See bluetooth-alsa.sf.net. There
is still plenty to do, if you want to help integrate it with gstreamer
for example.

I think it's not totally clear how the a2dp profile gets "integrated"
since it really looks more like a bluez client that belongs in one or
more multimedia frameworks.

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
