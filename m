Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1d49725d0704112005q6b90105dtc9e2e6affc647f63@mail.gmail.com>
References: <1d49725d0704112005q6b90105dtc9e2e6affc647f63@mail.gmail.com>
Date: Thu, 12 Apr 2007 09:46:16 +0200
Message-Id: <1176363976.7049.10.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Error connecting after inquiry
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

Hi Donnie,

> I am developing an application that connects to the Nintendo Wii
> remote, which is a bluetooth device, using BlueZ.  The API allows a
> bdaddr to be supplied, or not.  If it is not supplied, the API invokes
> a search function that does an hci_inquiry to get all available
> devices, hci_open_dev to get a device connection, then traverses the
> array, calling hci_remote_name and checking the class for each item
> returned from hci_inquiry until a Wiimote is found, closes the hci
> device, and returns the bdaddr of the Wiimote.  The calling function
> then opens a couple of L2CAP sockets and proceeds to communicate with
> the device. 
> 
> Here's my problem: many users receive errors on the L2CAP socket open
> only when a bdaddr is not supplied, but it works fine when the bdaddr
> is provided (thus skipping the search procedure described above).
> I've verified that the bdaddr returned by the search function is, in
> fact, identical to that supplied, so the parameters to the socket open
> call are identical.  It happens every time on some machines, and never
> on others - to my knowledge, there are no intermittently failing
> machines.  Any ideas? 

run "hcidump -X -V" as root to see what actually happens. You are using
threads and this might be a simply race condition.

However you also resolve the names for devices that don't have the
Wiimote device class. That is not needed at all. And a failing name is
not a reason to abort the whole search procedure. It can happen.

And you might wanna thing about doing this with our D-Bus API since it
is doing everything for you. Including telling you the RSSI values so
you can pick the one really next to you.

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
