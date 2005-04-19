Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] cannot build up piconet by using hciemu,
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <BAY20-F2876483DF0D5348217036BC82A0@phx.gbl>
References: <BAY20-F2876483DF0D5348217036BC82A0@phx.gbl>
Content-Type: text/plain
Message-Id: <1113907142.16233.161.camel@pegasus>
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
Date: Tue, 19 Apr 2005 12:39:02 +0200

Hi Parm,

stop sending the same message again and again. Otherwise I am going to
block your posts to the BlueZ mailing lists. Read this first:

	http://www.catb.org/~esr/faqs/smart-questions.html

>     I am doing a coure project on piconet formation and routing. I am using 
> hciemu. After I create some nodes, I cannot build a multipoint connection. 
> For example, I have three nodes, A,B and C.  After I create the connection 
> between A(master) and B,  and when I want to create the connection between A 
> and C, it  always fails. The error in file 'message ' is : File already 
> exists.

The hciemu was never written to support scatternet or multipoint
scenarios. It may simply don't work. However you have the source code
and if you really wanna use hciemu then try to fix it, because I never
used it. Actually it was only for testing purpose when the Bluetooth
dongles were expensive.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
