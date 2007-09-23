Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: David Woodhouse <dwmw2@infradead.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1190564515.7150.304.camel@pmac.infradead.org>
References: <1190504329.7150.277.camel@pmac.infradead.org>
	<1190564515.7150.304.camel@pmac.infradead.org>
Date: Sun, 23 Sep 2007 22:27:51 +0100
Message-Id: <1190582871.22181.12.camel@shinybook.infradead.org>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Serial service support for bluez-gnome
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Sun, 2007-09-23 at 17:21 +0100, David Woodhouse wrote:
> This gives me the name. I'll look at doing the service ident later.

Bored of sending patches; just committing to git now instead. I can
point-and-drool and add a /dev/rfcommX device for my phone now, although
it's still hardcoded to DUN -- I need to fix that.

What do we need before we can enable the serial and audio services by
default?

http://git.infradead.org/?p=users/dwmw2/bluez-gnome.git

      Add 'Create Bonding' button to applet
      Handle connection errors when creating input device
      Add basic support for serial service
      Fix GetName() call in serial pane, after connecting new device
      Fall back to displaying address if name unavailable for audio/input device
      Display remote service name for serial devices

http://git.infradead.org/?p=users/dwmw2/bluez-utils.git

      Attempt to pair with keyboard when connecting to it
      Fix leak in ports_paths list in serial service
      Increase storage size for serial storage, to avoid truncating service idents
      Add GetName() and GetAdapter() methods for org.bluez.serial.Port
      Add GetServiceName() method for org.bluez.serial.Port

-- 
dwmw2


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
