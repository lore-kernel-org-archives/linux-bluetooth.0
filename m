Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ Hackers <bluez-devel@lists.sourceforge.net>
Date: Wed, 28 Mar 2007 10:16:48 +0100
Message-Id: <1175073408.15698.97.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] hcid returning "Device or resource busy"?
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

Heya,

I've been wondering why my devices weren't showing up in
nautilus-sendto, and it looks like DiscoverDevices doesn't work. Here's
the snippet of code:

        dbus_g_proxy_call (object, "DiscoverDevices", &e,
                           G_TYPE_INVALID, G_TYPE_INVALID);
        if (e != NULL) {
                g_warning ("Couldn't start discovery: %s: %s",
                           dbus_g_error_get_name (e), e->message);
                g_error_free (e);
        }

I do a list ListBondings before that on the same object, so I know that
it works. But I still get that error:
Couldn't start discovery: org.bluez.Error.Failed: Device or resource busy

I'm using bluez-utils 3.9

Cheers

-- 
Bastien Nocera <hadess@hadess.net> 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
