Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Time Between Rfcomm Connections
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <45bf5ff80601151440w47f2f38bs80a68fafc8e8fdf1@mail.gmail.com>
References: <45bf5ff80601151440w47f2f38bs80a68fafc8e8fdf1@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1137451317.24817.7.camel@localhost>
Mime-Version: 1.0
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
Date: Mon, 16 Jan 2006 23:41:57 +0100

Hi Artur,

>  Im testing a few dongles that i bought but none of them is able to
> achieve 7 simultaneous rfcomm connections in a piconet. Im a master in
> all comunications and i initiate the connections with the mobile
> phones, depending on the ship provider the max number of
> communications i managed to establish was 5, in a 1.2  broadcom
> bluetooth dongle, tipcally i can only establish 4 in a silicon wave or
> Csr dongle (All 1.2). Also, the delay that i have to force between
> rfcomm connections varies from 2 to 3 sec depending on the ship
> provider, otherwise i get resource busy messages. Can someone point me
> a bluetooth usb dongle that is able to establish 7 rfcomm connections?
> I thought this was a mandatory request from the bluetooth spec  but i
> tested more then 15 diferent dongles and the best i got was 5.
> Concerning the delay between rfcomm connections , is this something
> controled by bluez or some limitation in the ship provider? 

I am unsure about the other manufacturer, but I thought that CSR chips
with at least HCI 18.x are capable of it. And actually I pretty sure I
already had such weird setups with a bunch of mouse and keyboard
devices. However nothing in the specification mandates that you have to
support this number of devices in a piconet. It is the maximal possible
number of device,s because they use only 3 bits to identify an active
device in a piconet.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
