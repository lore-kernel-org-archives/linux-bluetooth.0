Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <cd3ff4f20705040646p34f61cb1l8d0cae7c665e0caa@mail.gmail.com>
Date: Fri, 4 May 2007 17:46:22 +0400
From: heecks <heecks@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1178260678.25425.22.camel@violet>
MIME-Version: 1.0
References: <cd3ff4f20705022352u3451a87eub2e03a33f7bcf535@mail.gmail.com>
	<1178260678.25425.22.camel@violet>
Subject: Re: [Bluez-users] Device not detected (HP nx9420 / Kubuntu Feisty)
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

On 5/4/07, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> looks like you have to find the rfkill switch to enable the Bluetooth
> USB dongle inside your computer.

Hi Marcel,

Thank you very much for answering.

Since i didn't know what rfkill was before your mail, i did some search.
Finally, it appears to me that rfkill is a kernel module (or is it
already part of the kernel ?) that control the special keyboard
button(s) related to wifi and/or bluetooth. It also handles the state
of the bluetooth / wifi device (enabled or disabled). Am i right ?

Unfortunately, i didn't find any clue about how to use rfkill (i guess
there should be a frontend program)... Could you please give me some
pointers or informations about that ?

I don't know if this may help : on my laptop (HP nx9420), there is a
single keyboard button for wifi and bluetooth. Wi-fi is working ok
(with ipw3945d).

Regards.
-- 
Xavier

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
