Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <463003F7.3090302@evdebs.org>
References: <463003F7.3090302@evdebs.org>
Date: Thu, 26 Apr 2007 19:25:35 +0200
Message-Id: <1177608335.14980.100.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] basic printing profile server?
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

Hi Adam,

> I was wondering if anyone has worked on a basic printing profile server 
> for Linux? By server, I mean a way that phones or other small devices 
> can send jobs to a Linux desktop host which would then print through 
> CUPS (or lpd, etc.).

there have been ideas about it, but I can't recall an actual
implementation. However it might happen that INdT starts working on
something like this in the future.

> It seems like a missing piece, since CUPS can already print to bluetooth 
> printers.

The CUPS plugin can only print via HCRP and Serial Port Profile.

> My new phone supports printing of SMS messages and photos, so before I 
> try writing a server for it, I wanted to check to see if someone has 
> done it.

There are many printing profiles around. You should check which one the
phone actually uses. Run "hcidump -X -V" and look for the profile UUID
it requests.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
