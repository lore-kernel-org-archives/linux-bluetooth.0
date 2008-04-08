Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: David Stockwell <dstockwell@frequency-one.com>
In-Reply-To: <012801c899cd$447eb880$6701a8c0@freqonedev>
References: <00bd01c89901$26af9f80$6701a8c0@freqonedev>
	<2B4A186F-49DD-4131-ABB7-46E79D1A9DE8@holtmann.org>
	<00f801c899a1$946db020$6701a8c0@freqonedev>
	<7698E157-DB74-482D-9442-2B9C035B5A62@holtmann.org>
	<012801c899cd$447eb880$6701a8c0@freqonedev>
Message-Id: <1D6A3083-03A3-4698-A040-DD010CC4EBAD@holtmann.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Wed, 9 Apr 2008 01:36:28 +0200
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

> That "flame" was uncalled for.  I have attached file bluez- 
> utils-3.30/hcid/dbus-api.txt

actually I mentioned before that you only will see DeviceFound on / 
hci0 and if you look into the doc/ directory you see the documentation  
for the new API. I mailed an update to the mailing list that mentioned  
that from now on forward I am going to put new documentation there.

> The section describing the org.bluez.Adapter interface contains the  
> following (emphasis added):
>
>  void DiscoverDevices()
>
>   This method starts the device discovery procedure. This
>   includes an inquiry procedure and remote device name
>   resolving.
>
>   On start up this process will generate a DiscoveryStarted
>   signal and then return ***RemoteDeviceFound*** and also
>   ***RemoteNameUpdated*** signals. If the procedure has been
>   finished an DiscoveryCompleted signal will be sent.
>
>   Possible errors: org.bluez.Error.NotReady
>      org.bluez.Error.Failed
>      org.bluez.Error.InProgress
>      org.bluez.Error.NoSuchAdapter
>
>  void DiscoverDevicesWithoutNameResolving()
>
>   This method starts the device discovery procedure. This
>   includes an inquiry and an optional remote device name
>   resolving. The remote names can be retrieved with
>   GetRemoteName and in the case a name doesn't exist it
>   will be queued for later resolving and GetRemoteName
>   will return an error.
>
>   While this procedure is running every found device
>   will be returned with ***RemoteDeviceFound***. While
>   DiscoverDevices() automatically resolves unknown
>   devices names and sends ***RemoteNameUpdated*** in this
>   case it will only happen if GetRemoteName has been
>   called and no previously stored name is available.
>
>   Possible errors: org.bluez.Error.NotReady
>      org.bluez.Error.Failed
>      org.bluez.Error.InProgress
>      org.bluez.Error.NoSuchAdapter
>
> Note well: not "DeviceFound", but "RemoteDeviceFound".

Check doc/adapter-api.txt and you will see. I might mix up stuff from  
time to time, but most times I mean exactly what I say. Also using  
introspection utility like d-feet would have shown you this.

> The file I attached is the only dbus-api-txt found in the entire  
> bluez-utils-3.30 tree.   So, it appears the documentation is out of
> date; after digging into the code at adapter.c, I found signals  
> DeviceCreated, DeviceRemoved, and DeviceFound in the adapter_signals
> table.  I will implement "catches" for them, now, and expect that  
> this problem will go away.

No. The documentation is all there. Depending on your entry point is  
either / or /org/bluez you have to follow a different API.

Regards

Marcel


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
