Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: =?iso-8859-1?Q?S=E9bastien?= Delneste <seb@goodidea.be>
To: Thomas Chiverton <thomas.chiverton@bluefinger.com>
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] problem with Dlink DBT-120b-ohci               16192   0  (unused)
Message-ID: <20040310112757.GA15883@pong.be>
Reply-To: =?iso-8859-1?Q?S=E9bastien?= Delneste <seb@goodidea.be>
References: <20040310103925.GA15342@pong.be> <200403101117.48316.thomas.chiverton@bluefinger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200403101117.48316.thomas.chiverton@bluefinger.com>
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
Date: Wed, 10 Mar 2004 12:27:57 +0100

On Wed, Mar 10, 2004 at 11:17:48AM +0000, Thomas Chiverton wrote:
> On Wednesday 10 Mar 2004 10:39 am, Sébastien Delneste wrote:
> > There is my problem :
> > hub.c: new USB device 00:03.2-2, assigned address 5
> > usb.c: USB device 5 (vend/prod 0xa5c/0x2033) is not claimed by any
> > active driver
> > But I have no idea how to make him understand which driver to use with
> > this device.
> 
> Does hciconfig show the device (I get your error message, but the device works 
> fine !) ?
Is your DBT120 a revision A1 ?
Which kernel do you run ?
No, hciconfig doesn't show any device...
> 
> You could also try insmod'ing each of the modules one by one.

I also have a mouse which uses hid and usb-ohci

Here is a list of the loaded drivers : 
Module                  Size  Used by 
hid                    13856   0  (unused)
usb-ohci               16192   0  (unused)
ehci-hcd               15072   0  (unused)
rfcomm                 27776   0 
l2cap                  14368   2  [rfcomm]
hci_usb                 6176   0  (unused)
sound                  53228   0  (unused)
bluez                  27392   2  [rfcomm l2cap hci_usb]
mousedev                3840   2 
input                   3296   0  [hid mousedev]
usbcore                55584   1  [hid usb-ohci ehci-hcd hci_usb]

Which modules are necessary to run this driver ?

Sébastien


> 
> -- 
> Tom Chiverton 
> Advanced ColdFusion Programmer
> 
> Tel: +44(0)1749 834997
> email: tom.chiverton@bluefinger.com
> BlueFinger Limited
> Underwood Business Park
> Wookey Hole Road, WELLS. BA5 1AF
> Tel: +44 (0)1749 834900
> Fax: +44 (0)1749 834901
> web: www.bluefinger.com
> Company Reg No: 4209395 Registered Office: 2 Temple Back East, Temple
> Quay, BRISTOL. BS1 6EG.
> *** This E-mail contains confidential information for the addressee
> only. If you are not the intended recipient, please notify us
> immediately. You should not use, disclose, distribute or copy this
> communication if received in error. No binding contract will result from
> this e-mail until such time as a written document is signed on behalf of
> the company. BlueFinger Limited cannot accept responsibility for the
> completeness or accuracy of this message as it has been transmitted over
> public networks.***
> 


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
