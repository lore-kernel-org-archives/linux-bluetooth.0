Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Nicholas A. Preyss" <nalp@gmx.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Problem with Logitech MX 900 and Apple keyboard
Message-ID: <20040430120109.GA30493@gmx.net>
References: <200404282247.31825.matiasbrutti@ciudad.com.ar> <200404291209.16830.matiasbrutti@ciudad.com.ar> <20040429205222.GA8324@gmx.net> <200404300024.51331.matiasbrutti@ciudad.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200404300024.51331.matiasbrutti@ciudad.com.ar>
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
Date: Fri, 30 Apr 2004 14:01:09 +0200

On  0, Matias Pablo Brutti <matiasbrutti@ciudad.com.ar> wrote:
> On Thursday 29 April 2004 17:52, Nicholas A. Preyss wrote:
> > On  0, Matias Pablo Brutti <matiasbrutti@ciudad.com.ar> wrote:
> > > Thanks for.. the info is very helpful Now I understand a little more on
> > > the HID implementation . that should be step 2  I think .. .. the
> > > problems .. is that ... I haven been able to figure out .. step one .
> > > load some module . so when I do hcitool scan .... or  use some tool for
> > > scanning .  It will actually appear something . rigth now .. nothing
> > > appears not even the mouse that is working ...
> > > Thanks a lot . Nicholas . the info was extremelly helpful .. now I get a
> > > lot more than before .. :)
> >
> > I have no clue which of your problems are solved, but at least you seem
> > more happy :). Maybe you can give me a some more consistent and ordered
> > summary of what problems you still face. And we will be glad to help you.
> 
> Here goes a list of the thing I have been trying to do lately 
> 
> 1) I install my MX900 on the PC and it staterd working perfectly .. with no 
> need of seetup or anything .

This is because the Host Controller implements the necessary subset of the upper
bluetooth layers and translates the HID bluetooth profile to a USB HID
profile. In HID mode there is no need for bluetooth related software on
the computer because, it doesn't even know anything of the bluetooth host 
controller. The computer sees just USB HID devices.

> 2) I installed all the Bluez-liz and Bluez-utlis ....

I have no hid bt devices, but i think you need libs2 and utils2 from
CVS. Then you need to switch the host controller from HID to HCI mode.
How this is done depends on the Host Controller, I think your Logitech
is CSR based so you need the hid2hci tool. 
After switching the mode you have a full featured bluetooth host
controller. Now you should load the matching hci module: hci_usb. The
mechanism of loading unfortunately varies, but if hci_usb isn't
autoloaded, then you can "modprobe hci_usb". Now there should be a hci0
device ("hciconfig hci0"). 

> 3) I try to do some of the hepful how-to in the bluez website but won't work 

> 4) I realice that I have no modules configure to make it work with the bthid 
> that says that I need uimput .. becuase in the syslogs says that I cannot 
> find uimput module or device .. 

So you might need create the device node for this device. Just search
the mailing list for command with the matching major/minor numbers. What
bthid you are using? You might take this as guide for getting it run:
http://www.bueche.ch/comp/mx900/mx900.html
Correct me if i am wrong.

nicholas


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
