Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: <darrylkuhn@cox.net>
To: <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth on d610
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <20060125165101.VOSE17690.fed1rmmtao04.cox.net@[172.18.180.8]>
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
Date: Wed, 25 Jan 2006 11:53:30 -0500

So I've done the following in a further attempt to get bluez corectly installed and working on my system:

downloaded
    * bluez-libs-2.25.tar.gz
    * bluez-utils-2.25.tar.gz
    * bluez-firmware-1.1.tar.gz
    * bluez-hcidump-1.29.tar.gz

untar, configure, make, make install...

No errors on any part of the process

Still when I  modprobe usb_hci I get "FATAL: Module usb_hci not found." and a "locate usb_hci" turns up nothing - I'm a bit at a loss here.


> 
> From: <darrylkuhn@cox.net>
> Date: 2006/01/24 Tue PM 07:06:22 EST
> To: <bluez-users@lists.sourceforge.net>
> Subject: Re: Re: [Bluez-users] Bluetooth on d610
> 
> Marcel and Michal
> 
> I've done an `apt-get install hotplug' and restarted bluetooth services. No change...
> 
> modprobe hci_usb gives me:
>   FATAL: Module hci_usb not found.
> 
> Should I perhaps just download the latest tarball and compile from scratch?
> 
> Linspire's alright, but it's got it's problems (obviously) like anything else. 
> 
> Thanks again for all your help!
> 
> -Darryl
> 
> > 
> > From: Marcel Holtmann <marcel@holtmann.org>
> > Date: 2006/01/24 Tue PM 03:29:56 EST
> > To: bluez-users@lists.sourceforge.net
> > Subject: Re: Re: [Bluez-users] Bluetooth on d610
> > 
> > Hi Darryl,
> > 
> > > `lsmod | egrep 'hci|usb'` gives me:
> > > usbhid                 31040  0
> > > ohci1394               33668  0
> > > ieee1394              106296  1 ohci1394
> > > usb_storage            64448  0
> > > ehci_hcd               32260  0
> > > uhci_hcd               32272  0
> > > usbcore               115064  5 usbhid,usb_storage,ehci_hcd,uhci_hcd
> > > 
> > > So it looks like I'm missing hci_usb (or at least it's not loaded)
> > 
> > then do a "modprobe hci_usb".
> > 
> > > I do see /usr/src/kernel-source-2.6.10/include/config/bt/hciusb.h, but I'm unsure where to proceed from there.
> > 
> > this is no standard file at all. Even the filename is wrong.
> > 
> > > As for my distribution I'm using Linspire 5.0.347 which is a debian based dist.
> > 
> > I never tried or used Linspire.
> > 
> > Regards
> > 
> > Marcel
> > 
> > 
> > 
> > 
> > -------------------------------------------------------
> > This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
> > for problems?  Stop!  Download the new AJAX search engine that makes
> > searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> > http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> > 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
