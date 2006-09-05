Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 5 Sep 2006 20:17:39 +0200
From: Stefan Seyfried <seife@suse.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20060905181739.GB17557@suse.de>
References: <20060905165333.GB16417@suse.de>
	<1157476514.5963.7.camel@localhost>
MIME-Version: 1.0
In-Reply-To: <1157476514.5963.7.camel@localhost>
Subject: Re: [Bluez-devel] more udev rules for pcmcia cards
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

Hi,

On Tue, Sep 05, 2006 at 07:15:14PM +0200, Marcel Holtmann wrote:
 =

> non of them are needed, because they are for PCMCIA cards that have
> their own drivers and don't need hciattach to attach the serial port to
> the Bluetooth core. You can strip all of them. No idea on how they ever
> worked actually.

They probably have never worked. It was already suspicious to me that nobody
could tell me where they came from :-)

Thanks
-- =

Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, N=FCrnberg \                    -- Leonard Cohen

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
