Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Simone Gotti <motaboy80@supereva.it>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] plugging problems with a lot of kernels
References: <200401031720.26273.motaboy80@supereva.it> <200401031827.51633.motaboy80@supereva.it> <1073151308.25261.124.camel@pegasus>
In-Reply-To: <1073151308.25261.124.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200401171106.28990.motaboy80@supereva.it>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 17 Jan 2004 11:06:28 +0100

On Saturday 03 January 2004 18:35, Marcel Holtmann wrote:
> Hi Simone,
>
> > > this is a known problem with some USB adapters. Unloading the USB host
> > > adapter driver and loading it again helps here. You can also try to
> > > compile the hci_usb driver without SCO audio support.
> >
> > Thanks, I'll try It (Now I've compiled it directly in the kernel but I'll
> > make it a module).
> > So this problem is not related with bluez but only with the usb_uhci
> > drivers?
>
> this can't be proven, but I think it is [usb-]uhci or uhci_hcd related.

Hi Marcel,
Listening your discussion on the usb-devel mailing list I've tried unmounting 
the usbfs file system, then I've plugged my Bluetooth Adapter and it worked 
well! I've tryed unpluggin and replugging it several times and it always 
worked.
So I think it's a real usbfs issues and the reason that the device worked when 
it was plugged before the kernel init-scripts start was that in that moment 
the usbfs wasn't already mounted.

Thanks for your help! 

Bye!
-- 
Simone Gotti
<motaboy80@supereva.it>


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
