Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Scott Gilliland <scott.gilliland@gatech.edu>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1155277491.5059.4.camel@localhost>
References: <1155277491.5059.4.camel@localhost>
Date: Fri, 11 Aug 2006 12:04:55 -0400
Message-Id: <1155312296.5059.10.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-devel] tiny, tiny fix for btsco
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

Hi all, 

I was just looking at the source for the a2dp alsa plugin, and in the
build instructions, it says:

cvs -z3 -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/sbc co -P sbc

...which would be great, except it now (apparently) needs to be
"sbc.cvs.sourceforge.net" (try it without the sbc for an example).

If anyone has write access, can you toss that change in cvs for the
greater good of all? 

Thanks,
Scott Gilliland



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
