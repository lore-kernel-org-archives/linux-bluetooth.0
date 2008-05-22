Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: David Stockwell <dstockwell@frequency-one.com>
In-Reply-To: <01d801c8bc5a$027798d0$6701a8c0@freqonedev>
References: <01d801c8bc5a$027798d0$6701a8c0@freqonedev>
Message-Id: <D0DBF0CD-7285-47DF-ACD9-9F1F23A58BD2@holtmann.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Fri, 23 May 2008 01:17:13 +0200
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Problems with returning Default Adapter in
	C-Glib-DBus code
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

> Since upgrading to 3.32 (and possibly before), I have been having a  
> problem with calling the new, experimental DefaultAdapter method  
> against the "/".  When I do so, it properly returns the Adapter path  
> "/hci0", but fails with the following error: Unregistered object at  
> path '/hci0'.
>
> Prior to this, I used to call what was effectively the old  
> DefaultAdapter using the "/org/bluez" path and returning the old  
> string version of the Adapter path, receiving "/org/bluez/hci0".
>
> Output of my failing program is as follows (also, in  
> DefaultAdapterOut.txt):
>
> after dbus_g_proxy_new_for_name (dMgrObj)
>  bus:       org.bluez
>  path:      /
>  interface: org.bluez.Manager
> Failed to get DefaultAdapter: Unregistered object at path '/hci0'
> At the same time, I called dbus-send to see if this was some more  
> fundamental failure, but calls against both paths are successful, as  
> shown in the following (DefaultAdapter.txt):
>
> [dstockwell@freqonec001 ~]$ dbus-send --system --type=method_call -- 
> print-reply --dest=org.bluez /org/bluez  
> org.bluez.Manager.DefaultAdapter
> method return sender=:1.12 -> dest=:1.22
>    string "/org/bluez/hci0"
> [dstockwell@freqonec001 ~]$ dbus-send --system --type=method_call -- 
> print-reply --dest=org.bluez / org.bluez.Manager.DefaultAdapter
> method return sender=:1.12 -> dest=:1.23
>    object path "/hci0"

you have to give an object path instead of a string when using "/ 
hci0". That is the big change :)

Regards

Marcel


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
