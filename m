Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 14 Aug 2006 23:20:48 -0700
From: Steven Yap <syap@shaw.ca>
In-reply-to: <20060815020521.GE15576@refinery.twat.com.ar>
To: bluez-users@lists.sourceforge.net
Message-id: <1155622848.11881.4.camel@localhost.localdomain>
MIME-version: 1.0
References: <20060803043158.GA13259@refinery.twat.com.ar>
	<20060815020521.GE15576@refinery.twat.com.ar>
Subject: Re: [Bluez-users] Cannot transfer files via OBEX
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Mon, 2006-14-08 at 23:05 -0300, redondos wrote:
>                                                             
> Summary: Can *always* download, can *never* upload. 
> 
> redondos@injector redondos $ obexftp -b 00:16:20:F1:47:68 -B 6 -c Sounds -p Overdub2.mp3

For some reason, with Sony Ericsson phones, you need to use -C instead
of -c to upload, even if the directory already exist.



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
