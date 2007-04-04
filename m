Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4613B0D3.8010706@xmission.com>
Date: Wed, 04 Apr 2007 08:06:11 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <461360B4.1030509@free2move.net> <46138E9F.6030405@vasmac.com>
	<4613AC43.8090500@free2move.net>
In-Reply-To: <4613AC43.8090500@free2move.net>
Subject: Re: [Bluez-devel] Troubles with mulitple SCO connections (duplex)
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

Markus

> My spontaneous reaction would be; really?
> 
> My code is based on the socket-abstraction in BlueZ and it works fine
> for multiple ACL connections

Marcel says the usb layer needs a rewrite to accommodate this. It has
something to do with resource allocation on usb iirc.

It does work now on systems that use a serial hci connection (mostly
embedded) but that may not help you.

Brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
