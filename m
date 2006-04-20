Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Michal Krenek <mikos@sg1.cz>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Bluetooth HID device doesn't work (HID create	error)
In-Reply-To: <1145543458.17818.6.camel@localhost>
References: <20060420141808.1D1892FB5@osiris.flexible.cz> <1145543458.17818.6.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20060420144908.42D792FB5@osiris.flexible.cz>
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
Date: Thu, 20 Apr 2006 16:49:08 +0200

On Thu, 20 Apr 2006 at 16:31:12, Marcel Holtmann wrote:

> use "hidd --search" to connect to your phone. You need to do this at
> least once to have the correct data in the hidd file.

Unfortunately this doesn't work. I have tried to kill running hidd --server=
=20
and then run hidd --search but without success=20
(file /usr/var/lib/bluetooth/00:13:85:00:0E:62/hidd is still missing). Then=
 I=20
tried to run hidd --search and while hidd --search was running, I have trie=
d=20
to activate "Remote control" function on my mobile phone, but also without=
=20
success (mobile phone doesn't freeze, but "connecting" phase is terminated=
=20
with "Can't connect to remote device" and hidd --search still didn't find=
=20
anything).

Also in the past (as I said in november or december) it has worked without=
=20
problems out of the box (I didn't have to run hidd --search). So I think th=
is=20
is some problem with newer versions of bluez-libs, bluez-utils or kernel.


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
