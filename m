Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] SDP problems on embedded device
From: Marcel Holtmann <marcel@holtmann.org>
To: "Rolf E. Thorup" <rolft@daimi.au.dk>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40FE4BC9.3050509@daimi.au.dk>
References: <40FC2322.4060204@daimi.au.dk>
	 <1090270387.4400.100.camel@pegasus>  <40FCF471.4010501@daimi.au.dk>
	 <1090334863.4400.124.camel@pegasus>  <40FD5217.3060705@daimi.au.dk>
	 <1090345399.21683.2.camel@pegasus>  <40FE3ACF.4030608@daimi.au.dk>
	 <1090404291.21683.81.camel@pegasus>  <40FE4BC9.3050509@daimi.au.dk>
Content-Type: text/plain
Message-Id: <1090412310.21683.87.camel@pegasus>
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
Date: Wed, 21 Jul 2004 14:18:31 +0200

Hi Rolf,

> The other dongle I have available has HCI 16.4 firmware. If it is of any 
> help here's the output from "hcidump -x -t" from the laptop (browsing 
> the Cerfcube using the HCI 16.4 firmware dongle). I'm still using the 
> mh14 kernel patch.

and it is still the same problem. One side sends the config request, but
the other don't receives it. Try to browse from the Cerfcube a service
on your laptop's SDP database.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
