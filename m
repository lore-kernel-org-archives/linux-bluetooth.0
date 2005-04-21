Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Mitja Pufic <raveer@section-one.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Support for stored link keys
In-Reply-To: <1114094787.32265.11.camel@pegasus>
Message-ID: <Pine.LNX.4.61.0504211721020.15599@cherokee.spacecom.si>
References: <1114094787.32265.11.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Thu, 21 Apr 2005 17:55:38 +0200 (CEST)

Hello Marcel,

I use at least 3 dongles and so I implemented profiles for each one, simmilar 
to alternatives, so each profile has a directory in /etc/bluetooth/profiles and
script softlinks files to /etc/bluetooth and this solved my issues, when 
connecting with different dongles, but it did not solve issues regarding 
linkkeys in windows. 

Your idea is great, would love to see it, and I would store all linkkeys 
which device ever created, if it is possible to add them later on chip.
But I think this would not solve my problem with multiple dongles, as I 
would still need to use profiles, as each dongle would still need it's own 
list, right? 

Do you have any other sollution to this, or what do you think of 
inclusion of profiles for each device? Do you know how widcomm stack store 
linkkeys, in registry? Would it be possible to use same linkkey in both 
OSes?

take care,
mitja


-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
