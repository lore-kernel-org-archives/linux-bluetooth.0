Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20060917140952.GA3349@elf.ucw.cz>
References: <20060917140952.GA3349@elf.ucw.cz>
Date: Sun, 17 Sep 2006 18:52:59 +0200
Message-Id: <1158511979.24941.1.camel@localhost>
Mime-Version: 1.0
Cc: bluez-devel@lists.sf.net, kernel list <linux-kernel@vger.kernel.org>,
        maxk@qualcomm.com
Subject: Re: [Bluez-devel] bluetooth oops during resume from ram
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

Hi Pavel,

> If I suspend-to-RAM with usb active on thinkpad x60, I get an
> oops. Machine works okay after that, but...
> 
> it seems bluetooth is scribbling over more memory than was allocated
> (?)

not that I am aware of. Is this a plain 2.6.18-rc6 or did you apply
additional patches that might have caused this behavior?

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
