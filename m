Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Zaurus and PAN profile
From: Marcel Holtmann <marcel@holtmann.org>
To: "Mateo, Jose-Luis" <Jose-Luis.Mateo@t-systems.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <D971A27FCD3DE04689089E8A98D8AF710361C30D@G9JJ1.mgb01.telekom.de>
References: 
	 <D971A27FCD3DE04689089E8A98D8AF710361C30D@G9JJ1.mgb01.telekom.de>
Content-Type: text/plain
Message-Id: <1088078443.4296.53.camel@pegasus>
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
Date: Thu, 24 Jun 2004 14:00:44 +0200

Hi Jose,

> hcidump hangs when I try to connect from the PC. hciconfig runs ok:
> 
> Type : UART
> BD Adress: ... ACL MUT:192:8 SCO MTU: 64:8
> UP RUNNING PSCAN ISCAN
> .....
> 
> but with the option "-a" hangs just before the filed "Name". Can it be because of the different MTU values on the two devices?

No. This is must be because of H4 or BCSP troubles. What hciattach
command do you use? Try to install newer kernel modules.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
