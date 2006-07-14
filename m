Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Fri, 14 Jul 2006 17:38:03 +0200
From: Stefan Seyfried <seife@suse.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20060714153803.GC22273@suse.de>
References: <20060707094252.GA26792@suse.de>
	<1152617098.15028.16.camel@localhost>
	<20060711133956.GD13809@suse.de>
	<1152625591.15028.35.camel@localhost>
	<20060711154501.GE13809@suse.de>
	<1152885278.25660.27.camel@localhost>
Mime-Version: 1.0
In-Reply-To: <1152885278.25660.27.camel@localhost>
Subject: Re: [Bluez-devel] kernel: hci_scodata_packet: hci1
	SCO	packet	for	unknown connection handle 0
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

On Fri, Jul 14, 2006 at 03:54:38PM +0200, Marcel Holtmann wrote:
 =

> the preferred way would be "hcidump -i hci1 -X -V" to have full decoding
> support, but for SCO this doesn't really matter.

Ok, i'll note this on my cheat sheet :-)

> It would be interesting if this will work with isoc=3D1 and a 16-bit PCM
> stream. You should really try some stuff from the btsco package.

Audio and sco is on my todo list for next week, i'll report back after
trying it.
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
