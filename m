Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1173227233.10237.44.camel@cookie.hadess.net>
References: <1173227233.10237.44.camel@cookie.hadess.net>
Date: Wed, 07 Mar 2007 12:34:15 +0100
Message-Id: <1173267255.28512.3.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] non-ASCII chars in device names
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

Hi Bastien,

> I got this report for gnome-bluetooth some time ago:
> http://bugzilla.gnome.org/show_bug.cgi?id=380408
> 
> I fixed the problem altogether by replacing this code by D-Bus code
> calling hcid. The problem is that the name of the device only shows up
> the very first time the device is discovered, and it seems to me that
> the cache is busted:
> 
> In hcid/storage.c:
>         for (i = 0; i < 248 && name[i]; i++)
>                 if ((unsigned char) name[i] < 32 || name[i] == 127)
>                         str[i] = '.';
>                 else
>                         str[i] = name[i];
> 
> Why? If the data is correct UTF-8, it could be saved as-is in the file,
> minus any tabs, unbreakable spaces, or line feeds.

I don't see any problem with this code. It only replaces all ASCII
control characters (including delete). So this must be an issue with
still having the old name in the cache.

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
