Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: David Stockwell <dstockwell@frequency-one.com>
In-Reply-To: <00f801c899a1$946db020$6701a8c0@freqonedev>
References: <00bd01c89901$26af9f80$6701a8c0@freqonedev>
	<2B4A186F-49DD-4131-ABB7-46E79D1A9DE8@holtmann.org>
	<00f801c899a1$946db020$6701a8c0@freqonedev>
Message-Id: <7698E157-DB74-482D-9442-2B9C035B5A62@holtmann.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Tue, 8 Apr 2008 20:56:47 +0200
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] UPDATE: org.bluez.Adapter Methods/Signals
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi David,

> To be clear, I have registered the RemoteDeviceFound and  
> RemoteNameUpdated signals against both "/org/bluez/hci0" AND "/ 
> hci0" (both
> with "org.bluez.Adapter" interface).  Signals for these signals  
> always come back against "/org/bluez/hci0", and NOT against "/hci0"
> (path retrieved with dbus_g_proxy_get_path).

why don't you actually read the API documentation. Nobody said that  
you can expect RemoteDeviceFound and RemoteNameUpdated on /hci0 and  
you really can't. They are not sent. You get a DeviceFound signal.

Regards

Marcel


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
