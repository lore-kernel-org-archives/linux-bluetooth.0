Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <!&!AAAAAAAAAAAYAAAAAAAAAA28jtZUXBJFr+ktBeMYxbfCgAAAEAAAABpn6hByp39MlPtVk/LJX4UBAAAAAA==@lainfo.com.mx>
References: <!&!AAAAAAAAAAAYAAAAAAAAAA28jtZUXBJFr+ktBeMYxbfCgAAAEAAAABpn6hByp39MlPtVk/LJX4UBAAAAAA==@lainfo.com.mx>
Date: Mon, 03 Dec 2007 17:29:21 +0100
Message-Id: <1196699361.12292.120.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] GetRemoteCompany(string address)
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

Hi Cristian,

> In the doc for the GetRemoteCompany(string address) says:
>  
> string GetRemoteCompany(string address)
>  
>                        Get the company name from the OUI database of the
>                        Bluetooth device address. This function will need a
>                        valid and up-to-date oui.txt from the IEEE. This value
>                        will be different from the manufacturer string in the
>                        most cases.
>  
> Where I need to put the oui.txt ??  (in what directory o how?)

multiple places will work. Try /var/lib/misc/ for example.

Regards

Marcel



-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
