Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] MS Wireless keyboard scans remapping
From: Marcel Holtmann <marcel@holtmann.org>
To: Olivier Bornet <Olivier.Bornet@smartdata.ch>
Cc: Michal "Semler (volny.cz)" <cijoml@volny.cz>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20031028084018.GA1875@smartdata.ch>
References: <200310280847.39317.cijoml@volny.cz>
	<20031028084018.GA1875@smartdata.ch>
Content-Type: text/plain
Message-Id: <1067366086.24043.153.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 28 Oct 2003 19:34:40 +0100

Hi Olivier,

> > my keyboard works now fine, but I found keys which doesn't. Looks like MS 
> > changed scan codes for them.
> 
> I have had this kind of problem with a Logitech diNovo Media Desktop
> (http://www.logitech.com/bluetooth/). My main problems where that some
> keys are not mapped correctly in the bthid-0.6 of Peter, and the code
> for the mouse buttons is not OK. (at least with my Logitech Bluetooth
> mouse).
> 
> The problem with the keys is that my keyboard is a swiss french one, and
> the code of Peter has some keys missing. I have take the mapping from
> the USB driver, and it is now working great. :-)
> 
> I have send my patches to Peter, but I have receive no answer. So, I
> have attached my previous email to him. Try the patches to see if this
> correct also your problem.

this is another reason, why we should reuse the USB HID parser for the
Bluetooth keyboards and mice ;)

So you have the new diNovo. I am interested in the "hcitool info ..."
output from the devices and the "hciconfig -a" from the Bluetooth hub.
If you have some extra time, please compile the new libs2 from CVS and
run "sdptest records ..." and/or "sdptest browse ..." for me. Please
also include a "hcitool inq" for them, so I can see what class of device
they are using. What is the content of /proc/bus/usb/devices with the
Bluetooth hub attached. Do this one really support HID proxy from CSR?

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
