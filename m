Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1175087236.2996.8.camel@dhcp-1-148.fab.redhat.com>
References: <007801c77120$bb936640$9d0cc70a@dlh.st.com>
	<1175077084.5815.123.camel@violet>
	<1175085249.2996.1.camel@dhcp-1-148.fab.redhat.com>
	<1175086057.5815.132.camel@violet>
	<1175087236.2996.8.camel@dhcp-1-148.fab.redhat.com>
Date: Wed, 28 Mar 2007 15:20:59 +0200
Message-Id: <1175088059.5815.139.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] hcid returning "Device or resource busy"?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Bastien,

> > the problem is that the baseband is busy with the remote name request.
> > It has to page the remote device for getting the name and in that case
> > you simply can't run an inquiry. All currently available Bluetooth chips
> > have this limitation.
> > 
> > Main question is why we have the remote name request just before you
> > wanna start the inquiry. What D-Bus methods are you actually calling in
> > what order? I think you constructed a use case that we never tested.
> 
> The code is fairly straight forward. See:
> http://svn.gnome.org/viewcvs/nautilus-sendto/trunk/src/plugins/bluetooth.c?view=markup
> 
> The code first does a ListRemoteDevices (to list all the known, visible,
> etc.) devices in add_known_devices_to_list(), and then runs an discovery
> using DiscoverDevices in start_device_scanning().
> 
> Nothing mind blowing. I want to show all the known devices first (ie.
> the ones in the databases), and then add the devices
> visible/discoverable when the application is launched.
> 
> Is ListRemoteDevices actually doing anything on the HCI? I was under the
> impression that it should only pull items from the disk...

I almost guessed it. The ListRemoteDevices is not the problem the
GetRemoteName is the tricky part here. If the name is not in the cache
it tries to resolve it and this causes the baseband page which will
block the inquiry call.

You can wait for the completed RemoteNameUpdated or RemoteNameFailed
signals before actually starting the DiscoverDevices procedure. However
in case of devices out of range this might not be a good idea.

Let me discuss this through with the others. Feel free to hop onto
#bluez at Freenode.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
