Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Crosscompiling HCIEMU
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <IA5UYB$8CDBA1E15CF3997E0FCABCA3192E8041@uol.com.br>
References: <IA5UYB$8CDBA1E15CF3997E0FCABCA3192E8041@uol.com.br>
Content-Type: text/plain
Message-Id: <1105465925.7961.1.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 11 Jan 2005 18:52:05 +0100

Hi,

> Well, I have to deploy bluetooth into
> this platform and we dont have any
> bluetooth device to test it. So, I
> thought i coult use hciemu to make tests.

the hciemu is still limited in its functionality. Getting a real device
is maybe a better idea.

> I am using a crosscompiling evironment
> called SCRATCHBOX. The problem is that
> the compiler can not find the glib.h.
> I verified and the file is there but
> for some reason it can not be found.

You need a cross-compiled version of Glib and this is not an easy job. I
actually never did this.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
