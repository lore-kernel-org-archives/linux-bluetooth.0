Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Pierre-Yves Paulus <py@idlum.be>
To: bluez-devel@lists.sourceforge.net
Date: Fri, 23 Jun 2006 08:58:27 +0200
Message-Id: <1151045907.1450.73.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-devel] BlueZ and licensing issues
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

Hello,

>>From the informations I was able to gather, up to today, everything
released by the BlueZ project has been released under the GPL, and
they're discussion about a LGPL release of bluez-libs in the future, if
Qualcomm does agree with that as one of the copyright holders.

My question: has BlueZ ever released to a person or a company a copy of
bluez-libs under another license than the GPL? It seems that they're
companies around (at least one I know of) that are distributing/selling
products linked against the libs (according to ldd), under a very
proprietary license - nothing looking like the GPL, and not accompanied
by the required notices and source code offerings. I'm wondering if some
have been granted an "exception" allowing them to do so legally.

Is it right that to date, the only way to use BlueZ in a non-GPL
licensed project is to communicate with it through some kind of IPC
(like TomTom did with their TTMP lib, or now with the dbus API exposed
by hcid)?

I'm trying to clearly understand the situation from the licensing point
of view, for possible use of BlueZ in a non-GPL project, thus those
questions. Any useful comment on that matter would be much appreciated.

Best Regards,
Pierre-Yves Paulus







Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
