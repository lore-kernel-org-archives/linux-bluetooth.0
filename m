Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Support for stored link keys
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.61.0504211823390.16740@cherokee.spacecom.si>
References: <1114094787.32265.11.camel@pegasus>
	 <Pine.LNX.4.61.0504211721020.15599@cherokee.spacecom.si>
	 <1114099644.32265.31.camel@pegasus>
	 <Pine.LNX.4.61.0504211823390.16740@cherokee.spacecom.si>
Content-Type: text/plain
Message-Id: <1114101950.32265.40.camel@pegasus>
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
Date: Thu, 21 Apr 2005 18:45:50 +0200

Hi Mitja,

> > 	device 00:02:xx:xx:xx:xx {
> > 	        name "Casira BC4";
> > 	}
> > 
> > 	device 00:0B:xx:xx:xx:xx {
> > 	        name "3Com USB dongle";
> > 	}
> 
> Did not know that. Now I can ditch profiles and use hcid way :) Well only 
> problem I can see now is: for example with first dongle I create 
> connection to access point and store linkkey, and then I do the same with 
> second dongle, wouldn't that overwrite the first linkkey, as target would 
> have the same bdaddr? 

starting with 2.16 we use sub-directories, but the previous versions
stored the link keys with source and destination BD_ADDR.

> > The Widcomm stack stores it somewhere in the Registry and actually I
> > like to see a program that can read these keys from the Registry if the
> > Windows root partition is mounted. Anyone?
> 
> This would be cool :)

Exists any tool or library that allows to read the Windows registry
directly from Linux if the filesystem is mounted?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
