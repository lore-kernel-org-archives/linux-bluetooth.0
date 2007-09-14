Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Fri, 14 Sep 2007 11:06:48 +0200
From: Stefan Seyfried <seife@suse.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <20070914090648.GA1085@suse.de>
References: <iafkr4-c36.ln1@tisnix.motzarella.org>
	<20070912091328.GA6594@suse.de>
	<699or4-p0q.ln1@tisnix.motzarella.org>
MIME-Version: 1.0
In-Reply-To: <699or4-p0q.ln1@tisnix.motzarella.org>
Subject: Re: [Bluez-users] Bluetooth mouse not connecting using Lenny
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Thu, Sep 13, 2007 at 07:40:22PM +0200, wimpunk wrote:
> Stefan Seyfried wrote:

> > No. I see similar looking problems sometimes, that is having to unplug
> > the dongle before my mouse will reconnect again, but this surely has
> > a different reason.
> =

> I'm using hidd - Bluetooth HID daemon version 3.7
> Which version doesn't need HIDD?

You can disable the build of hidd since quite some time. In the openSUSE
package we stopped using it wiht release 3.10. Anyway, for proper debugging,
you should use the latest BlueZ-version. If you need to use the old version,
get support from your distribution ;-)

Have fun,

	Stefan

-- =

Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out." =


This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG N=FCrnberg)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
