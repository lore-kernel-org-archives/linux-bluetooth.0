Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth on a MIPS-System
From: Marcel Holtmann <marcel@holtmann.org>
To: leidenfrost@corscience.de
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <41654D83.1090306@corscience.de>
References: <41651D72.7040806@corscience.de>
	 <1097147273.7325.26.camel@pegasus>  <41652A40.4080209@corscience.de>
	 <1097152912.7325.30.camel@pegasus>  <41654062.5050009@corscience.de>
	 <1097154841.7325.36.camel@pegasus>  <41654D83.1090306@corscience.de>
Content-Type: text/plain
Message-Id: <1097158664.7325.38.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 07 Oct 2004 16:17:44 +0200

Hi Thomas,

> Now after doing hciconfig hci0 up I am able to ping other devices,
> but I guess I'll need rfcomm, too. But there is something missing... but 
> what?
> 
> # modprobe rfcomm
> Using /lib/modules/2.4.21/rfcomm.o
> insmod: unresolved symbol putchar
> insmod: unresolved symbol obex_dump
> insmod: unresolved symbol parser
> insmod: unresolved symbol get_proto
> insmod: unresolved symbol raw_dump
> insmod: unresolved symbol _gp_disp
> insmod: unresolved symbol printf
> modprobe: failed to load module rfcomm
> 
> Trying to figure out whats missing with depmod -a won't help because:

this rfcomm.o is not a kernel module. It is a compiled object file from
the bluez-hcidump package.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
