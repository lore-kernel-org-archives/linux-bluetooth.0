Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: Toshiba and BT (SuSE 9.2)
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAOihBpRJ97k2gwO2yUG25+wEAAAAA@t-online.de>
References: 
	 <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAOihBpRJ97k2gwO2yUG25+wEAAAAA@t-online.de>
Content-Type: text/plain
Message-Id: <1103118284.2143.237.camel@pegasus>
Mime-Version: 1.0
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
Date: Wed, 15 Dec 2004 14:44:44 +0100

Hi Peter,

> ##>what the f* is this. Use "sdptool browse ..." and "sdptool 
> ##>search ..." to find out what services/profiles this device 
> ##>really supports, because it seems that their support don't 
> ##>even know it.
> 
> the results make not really happy, isn't it so?
> 
> Linux-Notebook:~ # sdptool browse 00:0B:CE:00:01:8F
> Browsing 00:0B:CE:00:01:8F ...
> 
> Linux-Notebook:~ # sdptool search 00:0B:CE:00:01:8F LAP
> Unknown service 00:0B:CE:00:01:8F
> Linux-Notebook:~ # sdptool search 00:0B:CE:00:01:8F DUN
> Unknown service 00:0B:CE:00:01:8F
> 
> Linux-Notebook:~ # sdptool search LAP
> Unknown service LAP
> Linux-Notebook:~ # sdptool search DUN
> Inquiring ...
> Searching for DUN on 00:0B:CE:00:01:8F ...
> Linux-Notebook:~ #       

maybe you should read the manpage of sdptool first.

	sdptool search --bdaddr 00:0B:CE:00:01:8F --tree dun
	sdptool search --bdaddr 00:0B:CE:00:01:8F --tree lan

If you see problems don't forget to run "hcidump -X".

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
