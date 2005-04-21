Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Support for stored link keys
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.61.0504211721020.15599@cherokee.spacecom.si>
References: <1114094787.32265.11.camel@pegasus>
	 <Pine.LNX.4.61.0504211721020.15599@cherokee.spacecom.si>
Content-Type: text/plain
Message-Id: <1114099644.32265.31.camel@pegasus>
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
Date: Thu, 21 Apr 2005 18:07:24 +0200

Hi Mitja,

> I use at least 3 dongles and so I implemented profiles for each one, simmilar 
> to alternatives, so each profile has a directory in /etc/bluetooth/profiles and
> script softlinks files to /etc/bluetooth and this solved my issues, when 
> connecting with different dongles, but it did not solve issues regarding 
> linkkeys in windows. 

I don't know for what this is needed. The current hcid stores the link
keys now under /var/lib/bluetooth and it uses a subdirectory with the
text representation of the BD_ADDR to differ between adapters.

However even the previous hcid was able to store link keys for different
dongles and you can also use profiling inside the hcid.conf. For example
I use something like this to name all my development dongles.

	device 00:02:xx:xx:xx:xx {
	        name "Casira BC4";
	}

	device 00:0B:xx:xx:xx:xx {
	        name "3Com USB dongle";
	}

> Your idea is great, would love to see it, and I would store all linkkeys 
> which device ever created, if it is possible to add them later on chip.
> But I think this would not solve my problem with multiple dongles, as I 
> would still need to use profiles, as each dongle would still need it's own 
> list, right? 

There is no problem or I don't understand what you mean. However the
space for stored link keys on the chip is limited. I think that max for
CSR based chips is 20.

> Do you have any other sollution to this, or what do you think of 
> inclusion of profiles for each device? Do you know how widcomm stack store 
> linkkeys, in registry? Would it be possible to use same linkkey in both 
> OSes?

The Widcomm stack stores it somewhere in the Registry and actually I
like to see a program that can read these keys from the Registry if the
Windows root partition is mounted. Anyone?

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
