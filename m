Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <E2B64452-537E-4E9E-BF57-54F2A7073BF4@mac.com>
References: <E2B64452-537E-4E9E-BF57-54F2A7073BF4@mac.com>
Date: Sun, 10 Dec 2006 13:33:07 +0100
Message-Id: <1165753987.22251.6.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Using BlueZ
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

Hi Brian,

> I would like to know if its possible to use the BlueZ stack with  
> something that has a GPL incompatible license?  i.e. MPL?  I noticed  
> that its GPL licensed which limits its usage with such projects.  Any  
> alternatives?

if you have to link against the Bluetooth library, then the answer is
no. If you only use the D-Bus interface of BlueZ, then you link against
the D-Bus library and this one is LGPL, so that is no problem. However
you should always double check with "ldd" what libraries are actually
linked in or if you include header files from "bluetooth/*.h". Make sure
you don't link against the Bluetooth library and you are good.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
