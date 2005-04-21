Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Mitja Pufic <raveer@section-one.org>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Support for stored link keys
In-Reply-To: <1114099644.32265.31.camel@pegasus>
Message-ID: <Pine.LNX.4.61.0504211823390.16740@cherokee.spacecom.si>
References: <1114094787.32265.11.camel@pegasus>
 <Pine.LNX.4.61.0504211721020.15599@cherokee.spacecom.si>
 <1114099644.32265.31.camel@pegasus>
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
Date: Thu, 21 Apr 2005 18:34:29 +0200 (CEST)

Hello Marcel,

> 	device 00:02:xx:xx:xx:xx {
> 	        name "Casira BC4";
> 	}
> 
> 	device 00:0B:xx:xx:xx:xx {
> 	        name "3Com USB dongle";
> 	}

Did not know that. Now I can ditch profiles and use hcid way :) Well only 
problem I can see now is: for example with first dongle I create 
connection to access point and store linkkey, and then I do the same with 
second dongle, wouldn't that overwrite the first linkkey, as target would 
have the same bdaddr? 

> The Widcomm stack stores it somewhere in the Registry and actually I
> like to see a program that can read these keys from the Registry if the
> Windows root partition is mounted. Anyone?

This would be cool :)

take care and have a nice day,
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
