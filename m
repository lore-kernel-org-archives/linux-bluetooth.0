Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Sebastian Roth <sebastian.roth@esk.fhg.de>
Message-ID: <cpkf63$8up$1@sea.gmane.org>
References: <cpk3v3$4bb$1@sea.gmane.org> <1102948606.8750.159.camel@pegasus> <cpkc1i$tpn$1@sea.gmane.org> <cpkdsa$3qu$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <cpkdsa$3qu$1@sea.gmane.org>
Subject: [Bluez-users] Re: [bluetooth-alsa] and [libao-devel]
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 13 Dec 2004 17:14:59 +0100

Hi soraberri,

 > I actually con load sco (modprobe sco) but not snd_bt_sco as indicated
 > in http://bluetooth-alsa.sourceforge.net/
modprobe just searches the regular directory (/lib/modules/`uname -r`)
for the module. Try insmod /full/path/to/snd-bt-sco.ko instead.

Best regards,
Sebastian



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
