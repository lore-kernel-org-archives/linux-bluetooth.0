Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1196677470.3227.192.camel@cookie.hadess.net>
References: <1196677470.3227.192.camel@cookie.hadess.net>
Date: Mon, 03 Dec 2007 17:26:52 +0100
Message-Id: <1196699212.12292.115.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [patch] Use buttons in notification popups
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

Hi Bastien,

> As reported here:
> https://bugzilla.redhat.com/show_bug.cgi?id=407551
> 
> notification-daemon kind of sucks and doesn't allow for long messages
> (it will clip the messages, see those screenshots:
> https://bugzilla.redhat.com/attachment.cgi?id=274901
> https://bugzilla.redhat.com/attachment.cgi?id=274911
> )
> 
> Attached patch removes the extra lines, and adds a button to the popup
> instead. It looks better, and still pops up the dialogues as expected.

look good to me. Any special requirements on the version of libnotify to
make this work?

Regards

Marcel



-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
