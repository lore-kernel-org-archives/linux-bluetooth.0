Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20040422171637.33680.qmail@web20405.mail.yahoo.com>
From: Marian Gasparovic <marosg@yahoo.com>
Subject: Re: [Bluez-users] bluetooth/gprs problem
To: Fredrik Hallgarde <bluez@tedde.nu>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <1082639361.4087c401a2ddb@webmail.natdesign.m.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 22 Apr 2004 10:16:37 -0700 (PDT)

Fredrik, I looked in .config and I don't know what to
change, can somebody here help ? I include both USB
and Bluetooth sections. It is 2.4.25-mh3
Thank you in advance
Marian
#
# USB support
#
CONFIG_USB=y
CONFIG_USB_DEBUG=y
# CONFIG_USB_DEVICEFS is not set
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_UHCI_ALT=y
# CONFIG_USB_OHCI is not set
# CONFIG_USB_SL811HS_ALT is not set
# CONFIG_USB_SL811HS is not set
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_MIDI is not set
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_HID is not set
# CONFIG_USB_HIDINPUT is not set
# CONFIG_USB_HIDDEV is not set
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set

#
# Support for USB gadgets
#
# CONFIG_USB_GADGET is not set

#
# Bluetooth support
#
CONFIG_BLUEZ=y
CONFIG_BLUEZ_L2CAP=y
CONFIG_BLUEZ_SCO=y
CONFIG_BLUEZ_RFCOMM=y
CONFIG_BLUEZ_RFCOMM_TTY=y
CONFIG_BLUEZ_BNEP=y
CONFIG_BLUEZ_BNEP_MC_FILTER=y
CONFIG_BLUEZ_BNEP_PROTO_FILTER=y

#
# Bluetooth device drivers
#
CONFIG_BLUEZ_HCIUSB=y
# CONFIG_BLUEZ_HCIUSB_SCO is not set
# CONFIG_BLUEZ_HCIUART is not set
# CONFIG_BLUEZ_HCIBFUSB is not set
# CONFIG_BLUEZ_HCIDTL1 is not set
# CONFIG_BLUEZ_HCIBT3C is not set
# CONFIG_BLUEZ_HCIBLUECARD is not set
# CONFIG_BLUEZ_HCIBTUART is not set
# CONFIG_BLUEZ_HCIVHCI is not set


--- Fredrik Hallgarde <bluez@tedde.nu> wrote:
> To return the discussion to the list I repost my
> reply to Marian here.
> /Fredrik
> 
> Quoting Marian Gasparovic <marosg@yahoo.com>:
> 
> > Fredrik, you are right, I am on 2.4.25. I will try
> to
> > switch.
> > 
> > Marian
> > 
> > --- Fredrik Hallgarde <bluez@tedde.nu> wrote:
> > > Hi Marian,
> > > 
> > > > > I have i-Tec USB Dongle with Broadcom chip
> > > connected
> > > > > to my notebook with Debian Woody. I am able
> to
> > > > > establish bluetooth connection to my Siemens
> S55
> > > > > mobile. After I start pppd for GPRS access
> to
> > > Internet
> > > > > I get connected. I can ping any server for
> as
> > > long as
> > > > > I want. But when I open any web page under
> > > Konqueror
> > > > > or try ping -f, after couple of seconds
> (10-20)
> > > I
> > > > > loose connection. First I see bluetooth
> going
> > > away on
> > > > > mobil display, then gprs disconnect and
> after a
> > > minute
> > > > > pppd finds it out too. Any suggestions where
> to
> > > look ?
> > > > > I tried it with several notebooks, usb
> bluetooth
> > > > > devices and mobiles and only this i-Tec USB
> > > Dongle
> > > > > makes troubles. Under Windows XP it works
> > > without a
> > > > > problem.
> > > > 
> > > > this can be a dongle problem, because the
> dongle
> > > contains a Broadcom
> > > > chip and we already know that under some weird
> > > circumstances this is
> > > > buggy. But actually I think that your PPP
> setting
> > > are not correct for a
> > > > GPRS dialin. Check the some GPRS+PPP HOWTO's.
> > > 
> > > Even though I won't dispute Marcel's knowledge
> about
> > > the chip I like to share my
> > > experience with Bluetooth/GPRS.
> > > 
> > > I ran into a similar problem using a
> Broadcom-based
> > > IOGear USB Dongle and a NEC
> > > e606 3G a couple of months ago. All went well
> for
> > > maybe 30sec, after that nothing.
> > > I eventually solved it by switching usb module
> used
> > > in the 2.4.21 kernel (i.e.
> > > not bluez but the overall usb-module). 
> > > You're not telling us which kernel you are
> running
> > > but assuming a 2.4.x you
> > > should have at least one other module to try.
> > > 
> > > After that I never had any trouble using
> > > Bluetooth/3G to stay connected.
> > > 
> > > /Fredrik
> > 
> > 
> > =====
> > ===================
> >  Marian Gasparovic
> > ===================
> > "The mere thought hadn't  even  begun  to
> speculate about the merest
> > possibility of crossing my mind."
> > 
> > 
> > 
> > 
> > 	
> > 		
> > __________________________________
> > Do you Yahoo!?
> > Yahoo! Photos: High-quality 4x6 digital prints for
> 25¢
> > http://photos.yahoo.com/ph/print_splash
> > 
> 
> 



	
		
__________________________________
Do you Yahoo!?
Yahoo! Photos: High-quality 4x6 digital prints for 25¢
http://photos.yahoo.com/ph/print_splash


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
