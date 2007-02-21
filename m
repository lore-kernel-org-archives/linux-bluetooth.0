Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <45DB19E9.5080709@access-company.com>
References: <45DB19E9.5080709@access-company.com>
Date: Wed, 21 Feb 2007 13:06:55 +0100
Message-Id: <1172059615.7403.7.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] pan profile sdp record
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

Hi Frederic,

> I've been looking at pan profile and saw some mandatory fields in the 
> sdp records were missing.
> The problem is that these fields are user dependent. How to set them?
> 
> Security Description, NetAccessType and MaxNetAccessRate.
> 
> There are several issues to the problem :
> - patching pand is easy but some more options are needed to customize 
> fields (unless good defaults exists)

we need good default values and some extra parameters to change them. I
am all for this way.

> - using 'sdptool add' then 'sdptool set attr' is a bit unreadable
> - patching sdptool with more arguments?

No. These sdptool commands are only for debugging purpose.

> - using the dbus xml api still requires to patch pand or sdptool.

Won't really help. It only moves the problem to another tool.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
