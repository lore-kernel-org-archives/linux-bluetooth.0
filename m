Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <003501c47389$21c2b9e0$60010f0a@matrix>
From: "Virat Gohil" <virat4lug@hotpop.com>
To: "Papadopoulos Giannis" <ipapadop@uth.gr>
Cc: <bluez-users@lists.sourceforge.net>
References: <1090829679.4104bd6fbc168@webmail.uth.gr>
Subject: Re: [Bluez-users] vhci and RFCOMM
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-7"
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 27 Jul 2004 08:53:36 +0530

Hi, 

> Hi!
> 
<snip>
> mordor:/home/dop # rfcomm -i 7F:00:00:01:00:0A listen /dev/rfcomm0
> Waiting for connection on channel 1
> Can't open RFCOMM device: No such file or directory
> mordor:/home/dop #
</snip>

you should create the rfcomm devices, you can creat them as follows.

#mknod /dev/rfcomm0 c 216 0
#mknod /dev/rfcomm1 c 216 0

(for further details read the man pages of mknod)

Regards,

Virat



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
