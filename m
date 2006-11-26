Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sun, 26 Nov 2006 15:02:56 +0100 (CET)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <456937F3.7090107@xmission.com>
Message-ID: <Pine.LNX.4.63.0611261450220.22808@redbean.intranet.gw-instruments.de>
References: <456937F3.7090107@xmission.com>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] bccmd and usb/uart switching
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


Hi Brad, 


On Sat, 25 Nov 2006, Brad Midgley wrote:

> Hey
> 
> I am about to switch a bluegiga bluecore4 module from usb to uart/h4 so
> I can use it to work on audio stuff using a gumstix. I really can't
> afford to brick this thing and documentation is hard to come by... does
> it look like
> 
> bccmd psset 0x1f9 3
> bccmd psset 0x3cd 4
> 
> (to change HOST_INTERFACE & INITIAL_BOOTMODE respectively) is what I
> need so the module will respond on the uart at 115k with hw flow control?

Be carefull with this module when you want to change configuration !!! 

They use different "bootmodes" (boot configurations) to switch between 
different operation modes. If you change anything this will only be 
changed for the mode you are currently in. 

According to what I can see from your PS dump the default bootmode (3) 
configures the module for UART/H4. However, when the module is currently 
in USB mode either the default bootmode isn't 3 or it must have been 
rebootet from the VM (wich again is strange because bootmode 3 disables 
the VM). 

If you realy want to play with this module only change the bootmode 
(0x3CD) to 3. This will set up anything to boot for UARt / H4. And to make 
the change permanent you need to use the default store (see source for 
bccmd, I never can remember the command options). 

Good luck, 

Peter 



|       Peter Wippich                   Voice: +49 30 46776411          |
|       G&W Instruments GmbH            fax:   +49 30 46776419          |
|       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
|       D-13355 Berlin  / Germany                                       |


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
