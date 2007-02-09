Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Fri, 9 Feb 2007 12:43:08 +0100
From: Stefan Seyfried <seife@suse.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20070209114308.GA16231@suse.de>
References: <45CC5281.9090209@voelkers.org>
MIME-Version: 1.0
In-Reply-To: <45CC5281.9090209@voelkers.org>
Subject: Re: [Bluez-devel] Two sticks for a developer
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Fri, Feb 09, 2007 at 11:52:49AM +0100, jan wrote:
> Hi,
> =

> after buying three different bluetooth sticks i have one running.
> One of the others is not recognized as a bt stick, the other generates =


Send this one to Marcel

> many annoying messages about unknown sco packages in the syslog (>1000/mi=
n)

This one can probably be fixed by using
modprobe hci_usb isoc=3D1
and if that works, Marcel will ask you some details so he can blacklist
the device :-)

> To whom should i send them for development purposes? It will be a gift :-)

If everything else fails, send them to me ;-) No, just kidding.
-- =

Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out." =


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
