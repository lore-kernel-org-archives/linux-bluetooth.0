Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: inactivity of my Bt
From: Marcel Holtmann <marcel@holtmann.org>
To: nicolas <n1c0l4s.l3@wanadoo.fr>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200406240050.30749.n1c0l4s.l3@wanadoo.fr>
References: <200406232055.06709.n1c0l4s.l3@wanadoo.fr>
	 <200406240028.07415.n1c0l4s.l3@wanadoo.fr>
	 <1088029418.4296.9.camel@pegasus>
	 <200406240050.30749.n1c0l4s.l3@wanadoo.fr>
Content-Type: text/plain
Message-Id: <1088030785.4296.17.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 24 Jun 2004 00:46:25 +0200

Hi Nicolas,

> > the bluez-utils-2.7 (and also the Debian package) contains an init
> > script that will do this for you.
> 
> i have all installed this rpm from my distrib
> 
> bluez-bluefw-1.0-1mdk
> bluez-utils-2.7-4mdk
> bluez-hciemu-1.0-2mdk
> libbluez1-2.7-1mdk
> bluez-hcidump-1.8-1mdk
> libbluez1-devel-2.7-1mdk
> 
> and there is no bluetooth service in my mcc but service bluetooth start   work
> 
> so  what have i to do?
> there is a packaging bug?  ( in this case i will mail the packager rapidly)

check /etc/default/* for a Bluetooth configuration file. In general you
must set a variable to start hidd at boot time.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
