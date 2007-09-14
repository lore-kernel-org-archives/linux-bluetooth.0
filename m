Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY123-F26AFEA092F402F4E2C4044C0BC0@phx.gbl>
In-Reply-To: <BAY123-F29B9F211658DBCAE83E7F7C0C30@phx.gbl>
From: "Another Name" <anothersillyname@hotmail.com>
To: bluez-users@lists.sourceforge.net
Date: Fri, 14 Sep 2007 02:29:42 +0100
Mime-Version: 1.0
Subject: Re: [Bluez-users] Plugz fails ./configure glib-2.0
	gthread-2.0gobject-2.0 not fo
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Ignore this question folks....looks like my pkg-config stuff is borked....

rpm -qa | grep glib shows the packages installed whereas
pkg-config --list-all | grep glib doesn't show them and I can't locate 
glib-2.0.pc

does anyone know a quick way of force re-installing glib (and is glib-2.0 
glib or glib2 ) without having to uninstall it as the dependencies are 
horrendous

TIA


>From: "Another Name" <anothersillyname@hotmail.com>
>Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
>To: bluez-users@lists.sourceforge.net
>Subject: [Bluez-users] Plugz fails ./configure glib-2.0 
>gthread-2.0gobject-2.0 not found on Fedora 7..
>Date: Fri, 14 Sep 2007 00:28:25 +0100
>MIME-Version: 1.0
>X-Originating-IP: [79.67.171.18]
>X-Originating-Email: [anothersillyname@hotmail.com]
>X-Sender: anothersillyname@hotmail.com
>Received: from lists-outbound.sourceforge.net ([66.35.250.225]) by 
>bay0-mc4-f11.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668); Thu, 
>13 Sep 2007 16:28:40 -0700
>Received: from sc8-sf-list2-new.sourceforge.net 
>(sc8-sf-list2-new-b.sourceforge.net [10.3.1.94])by 
>sc8-sf-spam2.sourceforge.net (Postfix) with ESMTPid 7797B1338D; Thu, 13 Sep 
>2007 16:28:39 -0700 (PDT)
>Received: from sc8-sf-mx2-b.sourceforge.net 
>([10.3.1.92]helo=mail.sourceforge.net)by sc8-sf-list2-new.sourceforge.net 
>with esmtp (Exim 4.43)id 1IVy6p-0003mK-Bnfor 
>bluez-users@lists.sourceforge.net; Thu, 13 Sep 2007 16:28:31 -0700
>Received: from bay0-omc3-s13.bay0.hotmail.com ([65.54.246.213])by 
>mail.sourceforge.net with esmtp (Exim 4.44) id 1IVy6r-0003NL-Ozfor 
>bluez-users@lists.sourceforge.net; Thu, 13 Sep 2007 16:28:35 -0700
>Received: from hotmail.com ([207.46.11.109]) by 
>bay0-omc3-s13.bay0.hotmail.comwith Microsoft SMTPSVC(6.0.3790.3959); Thu, 
>13 Sep 2007 16:28:28 -0700
>Received: from mail pickup service by hotmail.com with Microsoft 
>SMTPSVC;Thu, 13 Sep 2007 16:28:28 -0700
>Received: from 207.46.11.123 by by123fd.bay123.hotmail.msn.com with 
>HTTP;Thu, 13 Sep 2007 23:28:25 GMT
>X-Message-Delivery: Vj0zLjQuMDt1cz0wO2k9MDtsPTA7YT0w
>X-Message-Info: 
>C1eXHNFKu4mLtso+nEOkT0H9/myJXqP4LnaSPhZr+7BVWsqOy/8kJx6wo2m+k+mLuIjtLep6T3Hx9qUZklfsyB27T9wmD8aH
>X-OriginalArrivalTime: 13 Sep 2007 23:28:28.0225 
>(UTC)FILETIME=[C9DA0B10:01C7F65D]
>X-Spam-Score: 0.0 (/)
>X-Spam-Report: Spam Filtering performed by sourceforge.net.See 
>http://spamassassin.org/tag/ for more details.Report problems 
>tohttp://sf.net/tracker/?func=add&group_id=1&atid=2000010.0 
>MSGID_FROM_MTA_HEADER  Message-Id was added by a relay
>X-BeenThere: bluez-users@lists.sourceforge.net
>X-Mailman-Version: 2.1.8
>Precedence: list
>List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
>List-Unsubscribe: 
><https://lists.sourceforge.net/lists/listinfo/bluez-users>, 
><mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
>List-Archive: 
><http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
>List-Post: <mailto:bluez-users@lists.sourceforge.net>
>List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
>List-Subscribe: 
><https://lists.sourceforge.net/lists/listinfo/bluez-users>,<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
>Errors-To: bluez-users-bounces@lists.sourceforge.net
>Return-Path: bluez-users-bounces@lists.sourceforge.net
>
>says it can't find the packages when they're there and installed in the
>standard paths.
>
>glib2 2.12.13-1.fc7 (both i386 and x86_64 are installed + the devel library
>and the static libs as well -devel only i386 obviously!!).
>
>Any ideas anyone?
>
>TIA
>
>_________________________________________________________________
>Can you see your house from the sky? Try Live Search Maps
>http://maps.live.com
>
>
>-------------------------------------------------------------------------
>This SF.net email is sponsored by: Microsoft
>Defy all challenges. Microsoft(R) Visual Studio 2005.
>http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users

_________________________________________________________________
The next generation of Hotmail is here!  http://www.newhotmail.co.uk


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
