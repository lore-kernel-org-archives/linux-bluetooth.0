Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Zhikui Chen <zhikui.chen@po.uni-stuttgart.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40E4206F.6060101@po.uni-stuttgart.de>
References: <40E40440.8070109@po.uni-stuttgart.de>
	 <1088685238.4540.190.camel@pegasus>  <40E40A44.60008@po.uni-stuttgart.de>
	 <1088687188.4540.202.camel@pegasus> <40E412AA.4070908@po.uni-stuttgart.de>
	 <1088689181.4540.216.camel@pegasus> <40E416AB.2040904@po.uni-stuttgart.de>
	 <1088690093.4540.218.camel@pegasus> <40E41A18.8050201@po.uni-stuttgart.de>
	 <1088691084.4540.232.camel@pegasus> <40E4206F.6060101@po.uni-stuttgart.de>
Content-Type: text/plain
Message-Id: <1088692837.4540.235.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-users] Re: Help for bluez-bluefw-1.0.
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
Date: Thu, 01 Jul 2004 16:40:37 +0200

Hi Zhikui,

> So now hciconfig can display the drivers' addresses.
> My PC BD address is 00:04:61:81:AD:36
> My notebopok BD is 00:04:61:81:AC:5B
> I use hcitool scan, but no output report.
> l2ping 00:04:61:81:AC:5B from 00:04:61:81:AD:36, report is  "Can't 
> connect .; host is down",
> 
> BUT my notebook scanned an other computer's bluetooth driver and can 
> l2ping to it. What's wrong of my PC? My PC has four USB ports, two of 
> them are from PCIcard. I have tried all ports, My PC can not scan other 
> bluetooth drivers or l2ping to an other. Using hcitool inq also can not 
> found my PC bluetooth drivers.

start hcid. This is easier and don't have to guide you through all the
steps.

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
