Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Oguzhan Eris <eris3@ekls.com>
Subject: Re: [Bluez-users] Problem "coldplugging"
In-reply-to: <1073243976.25261.160.camel@pegasus>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Message-id: <1073252537.4255.6.camel@localhost>
MIME-version: 1.0
Content-type: text/plain
References: <1073239248.2928.18.camel@localhost>
 <1073243976.25261.160.camel@pegasus>
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
Date: Sun, 04 Jan 2004 16:42:17 -0500

I meant 2.6.1-rc1  (and by cleanly, I meant trivial :) )

I tried mh2 with the bcm203x driver and installed the firmware.agent and
put the firmwares from the bluefw package into /usr/lib/hotplug/firmware
(removed the usb bluefw mappings)  And things worked for a second,  but
now they don't again (after a reboot)
Here's the setup   2.6.1-rc1-mm1-mh2
Hotplug 2003_08_05-1  (with firmware.agent)

I had to modify the SYSFS variable in firmware.agent as the command to
get it results in  /initrd/sys  and /sys   (not sure why its still
mounted on my system, but i guess it's possible to have more than one
sysfs on a machine)

all bluetooth core drivers are in-kernel. hci_usb is a module and so is 
bcm203x (which I guess can never be in kernel as it needs way too many
userland stuff)

I have tried lots and lots of different ways of going about it all.  I'm
guessing hci_usb needs to be loaded before bcm203x, please correct me if
I'm wrong.  But regardless,  SOMETIMES it works perfectly,  most of the
time it just doesn't work.  By doesn't work, i mean I can see the hci0
device but bringing it up sometimes results in ...
Can't init device hci0. Connection timed out(110)
and in the logs I see 
hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb dd071214 err -90

Other times I see the device and can bring it up all fine. BUT hcitool
scan comes  back instantly   (when it works, the actual does scan takes
like 5-10 seconds and finds my t68i)

Any advice would be appreciated.  If there's any debugging I can turn
on, please let me know.  And also please let me know in your opinion
what should be modules, and what should be in-kernel  and what should I
load before bcm203x if any (or after)  

Also,  any reason why you think I'm seeing different productID's  (sorry
I had said vendorID before)   As someone else also has seen this, could
it be a usb quirkness that we should bring up to the usb maintainers?

Thanks again.





On Sun, 2004-01-04 at 14:19, Marcel Holtmann wrote: 
> Hi,
> 
> > Hi, I was wondering if someone could help me out with a problem using
> > the IOGEAR GBU301 device which requires bluefw.
> > 
> > Everything works fine if I hotplug the device with the device matching
> > bluefw.usermap and running the appropriate bluefw command.  
> > 
> > I have kernel 2.6.0   (now upto  rc1-mm1)  with the bluetooth matches
> > from patch-2.6.0-mh1   (it applied cleanly to 2.6.0-rc1)  I have tried
> > ALL combinations.
> 
> the patch-2.6.0-mh1 don't apply cleanly to 2.6.0-rc1 :(
> 
> Try to use 2.6.0-mh2 and don't install bluefw. The new bcm203x provides
> the same functionalty and uses the firmware.agent hotplug script for
> firmware loading.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> --
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
> Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
> Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
