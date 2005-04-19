Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42649E3C.1080608@metalan.net>
From: Andre Baron <andre@metalan.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Apple BT Keyboard and Ubuntu Linux
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
Date: Mon, 18 Apr 2005 22:59:24 -0700

Ok, this is probably something this list deals with on a regular basis; 
I tried searching online, even on Marcel's site but I can't seem to find 
the solution to my problem.

First off, some specs:

Ubuntu Linux
2.6.11 Kernel w/mh2 patch
Latest BlueZ Utiles (that available from the ubuntu sources)
Generic USB Bluetooth Adapter
Apple Bluetooth Keyboard

This setup works just fine to syncronize my T68 through Multisync but 
when I try to connect to my keyboard here's what happens:

  lampshade:/home/andre# hidd --conn 00:0A:95:3E:CC:74
  Can't create HID control channel: Function not implemented
  lampshade:/home/andre# hidd --conn 00:0A:95:3E:CC:74
  Can't create HID control channel: Connection timed out
  lampshade:/home/andre# hidd --conn 00:0A:95:3E:CC:74
  Can't create HID control channel: Device or resource busy

and if I try to search for my keyboard:

  lampshade:/home/andre# hidd --search
  Searching ...
        Connecting to device 00:0A:95:3E:CC:74
  Can't create HID control channel: Function not implemented

Now, I'm sure there is something that I forgot to do or don't know to do.

I'd appreciate any help, even one pointing me to a how to (I have a 
feeling this keyboard may be a little special, so I'd love a specific 
howto) If you need any more information I'll be glad to provide it.

TIA

Andre



-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
