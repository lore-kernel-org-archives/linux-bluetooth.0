Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez@frederic-blain.com,
        BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <47477234.9010007@free.fr>
References: <47477234.9010007@free.fr>
Date: Mon, 26 Nov 2007 06:55:18 +0100
Message-Id: <1196056518.4217.60.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Sony PS3 sixaxis & bluez
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

Hi Frederic,

> With the current bluez-utils version (3.22 or CVS), the PS3 bluetooth 
> controller (Sixaxis) is
> not recognized. As a workaround, you need to use the former HID daemon 
> (hidd), rename
> the file /var/lib/bluetooth/xx:xx:xx:xx:xx:xx/hidd to 
> /var/lib/bluetooth/xx:xx:xx:xx:xx:xx/input
> and restart bluez with bluetoothd-service-input. It will now recognize 
> the controller.

no, no and no. The file formats a different. And you don't have to do anything if you have the hidd file. The input service will import it.

> Could someone explains me what should be the process to establish a HID 
> connection
> from a remote device to the host using bluetoothd-service-input ? What 
> are the
> interactions between hcid and bluetoothd-service-input ? Do you have a 
> doc / diagram
> explaining this ?

The wiki.bluez.org contains a lot of diagrams and there are slides
available from my talks that explains it.

> I think bluetoothd-service-input should listen signals from 
> /org/bluez/hci0 and create a
> device structure when a  RemoteDeviceConnected signal is intercepted, 
> but it doesn't
> seem to work like this.

The short answer is no. The long one is that we have two L2CAP PSM that
handle the remote connections.

> In bluetoothd-service-input, in which step of this process should the 
> create_device()
> function be called ?  I've noticed interrupt_connect_cb() & 
> control_connect_cb() but
> I can't figure out when they will be called.

You don't do this. It is a security risk. Period. Think about what you
are proposing. Creating a device entry for a remote input device needs
user interaction.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
