Return-Path: <cyrus@holtmann.org>
Message-ID: <01f601c8bc66$13fd69c0$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <01d801c8bc5a$027798d0$6701a8c0@freqonedev> <D0DBF0CD-7285-47DF-ACD9-9F1F23A58BD2@holtmann.org>
Subject: Re: Problems with returning Default Adapter in C-Glib-DBus code
Date: Thu, 22 May 2008 18:46:35 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-ID: <bluez-devel.lists.sourceforge.net>

Actually, I did that...I think.

Please review the following call:

 if (dbus_g_proxy_call(dMgrObj, "DefaultAdapter", &dError, G_TYPE_INVALID, G_TYPE_OBJECT, &servicePath, G_TYPE_INVALID)) {
  cout << "DefaultAdapter is " << servicePath << endl;
 } else {
  if (dError!=NULL) {
   cout << "Failed to get DefaultAdapter: " << dError->message << endl;
   g_error_free(dError);
   return EXIT_FAILURE;
  }
 }

The G_TYPE_OBJECT should mark the return value (stuffed into a char * servicePath) as an Object Path. Or am I mistaken?

DS

----- Original Message ----- 
From: "Marcel Holtmann" <marcel@holtmann.org>
To: "David Stockwell" <dstockwell@frequency-one.com>
Cc: "BlueZ development" <bluez-devel@lists.sourceforge.net>; "Johan Hedberg" <johan.hedberg@gmail.com>
Sent: Thursday, May 22, 2008 6:17 PM
Subject: Re: Problems with returning Default Adapter in C-Glib-DBus code


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
