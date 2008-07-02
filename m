Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1214985447.12540.11.camel@pancake>
References: <1214985447.12540.11.camel@pancake>
Date: Wed, 02 Jul 2008 10:34:47 +0100
Message-Id: <1214991287.5014.48.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] MX900 Mouse, bluez-gnome and reconnect
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

On Wed, 2008-07-02 at 09:57 +0200, Florian Echtler wrote:
> Hi everyone,
> 
> I have a Logitech MX900 Bluetooth mouse which works fine after I open
> bluetooth-properties, select Services -> Input Service and add it to the
> list. However, I have to repeat that every morning after the mouse fell
> asleep overnight (even if I put it into the charger). Moreover, when I
> don't remove it from the input device list first, bluetooth-properties
> crashes.
> 
> Does anyone have a hint how to get around this?

You need this kernel patch:
http://git.kernel.org/?p=linux/kernel/git/holtmann/bluetooth-2.6.git;a=commitdiff_plain;h=c14bf10817f09ffc15e7f16e97d8119cd04c3ca8

It's already in Ubuntu, and it's also in kernel-2.6.25.9-76.fc9 for
Fedora.

Cheers


-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
