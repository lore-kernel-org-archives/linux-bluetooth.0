Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluefw problem
From: Joonas =?ISO-8859-1?Q?H=E4m=E4l=E4inen?= <kerberos@mbnet.fi>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1064732699.5012.26.camel@pegasus>
References: <1064703452.10689.38.camel@Aielien>
	 <1064732699.5012.26.camel@pegasus>
Content-Type: text/plain
Message-Id: <1064739488.4196.14.camel@Aielien>
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
Date: 28 Sep 2003 11:58:08 +0300

Hip Marcel,
thing is, I don't seem to have any bluetooth.o on my mandrake. I spent
quite a while now searching for it, after I tried to get some usefull
information from archive :)
This is output from my lsmod, and thre it is also bluez not bluetooth at
all. 

Module                  Size  Used by    Tainted: P
tun                     5504   3  (autoclean)
l2cap                  18028   3  (autoclean)
rfcomm                 34816   2  (autoclean)
autofs4                11540   2  (autoclean)
lp                      8096   0
hci_usb                 8632   1
bluez                  38020   3  [l2cap rfcomm hci_usb]
scanner                10904   0
usb-uhci               24652   0  (unused)
usbcore                72992   1  [hci_usb scanner usb-uhci]
rtc                     8060   0  (autoclean)
ext3                   59916   1
jbd                    38972   1  [ext3]

As I told, it works if I first boot into windows, and then reboot to
mandrake, then I get it working just fine. But if I do hard boot, or
start right to mandrake, my lsmod looks just same, only difference is
that my dongel isn't found.

Also, if I unplug dongel when it has been working, and plug it back, it
isn't found by hciconfig anymore. Same if I do hciconfig hci0 down and
then try bring it up again.

If there is something about this in archives, I failed to see it... I
don't have idea which keyword I should use... I could read of course
everything, but with mobile gprs connection it is really slow thing, as
those archives are so slow moving...

I wish you have still patience with me :)
Yours,
Joonas

On su, 2003-09-28 at 10:04, Marcel Holtmann wrote:
> Hi Joonas,
> 
> > Sep 27 17:59:06 Armada kernel: bluetooth.c: USB Bluetooth support
> > registered
> > Sep 27 17:59:06 Armada kernel: usb.c: registered new driver bluetty
> > Sep 27 17:59:06 Armada kernel: bluetooth.c: USB Bluetooth converter
> > detected
> > Sep 27 17:59:06 Armada kernel: bluetooth.c: Bluetooth converter now
> > attached to ttyUB0 (or usb/ttub/0 for devfs)
> 
> what do the mailing list archive say about using bluetooth.o on a Linux
> 2.4.x kernel ;)
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
