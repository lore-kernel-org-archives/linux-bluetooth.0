Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: "mailing_list@orange.nl" <mailing_list@orange.nl>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <d89ddf300710062041q59531981xe2a3c693960bff40@mail.gmail.com>
References: <1191696694.2049.7.camel@Gentoo-desktop.lan>
	<d89ddf300710062041q59531981xe2a3c693960bff40@mail.gmail.com>
Date: Sun, 07 Oct 2007 09:00:26 +0200
Message-Id: <1191740426.5622.4.camel@Gentoo-desktop.lan>
Mime-Version: 1.0
Subject: Re: [Bluez-users] How do I get a bluetooth headset working?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Thank you for answer. I have read the manual, unfortunately it lists
only commands without an explanation. Therefor I find it really
difficult to grasp. 

I tried entering the commands from the 'Headset profile' to no avail:


$ dbus-send --system --type=method_call --print-reply
--dest=":X.Y" /org/bluez/audio org.bluez.audio.Manager.CreateHeadset
string:00:11:22:33:44:55 
                                 Code:
 Error org.freedesktop.DBus.Error.ServiceUnknown: The name :X.Y was not
                    provided by any .service files 
                                    


$ dbus-send --system --type=method_call --print-reply
--dest=":HBH-PV702" /org/bluez/audio
org.bluez.audio.Manager.CreateHeadset string:00:11:22:33:44:55 
                                 Code:
                                    

On Sat, 2007-10-06 at 21:41 -0600, Brad Midgley wrote:
> Aniruddha
> 
> read up in http://wiki.bluez.org/wiki/HOWTO/AudioDevices
> 
> skype may not work yet (it is pretty brutal with the alsa api) but
> things have been improving a lot recently in the driver.
> 
> Brad
> 
> On 10/6/07, mailing_list@orange.nl <mailing_list@orange.nl> wrote:
> > I have successfully setup a bluetooth usb dongle. I can transfer files
> > to a sony ericsson phone. Now I want to take the configuration one step
> > further and use the bluetooth headset that comes with the mobile phone
> > for voip communication through skype.
> >
> > I really would like to get this working because then I can update the
> > Gentoo Linux Bluetooth Guide
> > ( http://www.gentoo.org/doc/en/bluetooth-guide.xml )
> > and that way help other people to get this working :)
> >
> >
> > My hardware
> > Anycom bluetooth USB-adapter with Broadcom chipset
> > Bus 004 Device 002: ID 0a5c:2122 Broadcom Corp.
> >
> > Headset
> > Sony Ericsson HBH-PV702
> >
> > OS
> > Gentoo Linux 2007
> >
> > Thanks in advance!
> >
> > Regards,
> >
> > Aniruddha
> >
> >
> >
> > -------------------------------------------------------------------------
> > This SF.net email is sponsored by: Splunk Inc.
> > Still grepping through log files to find problems?  Stop.
> > Now Search log events and configuration files using AJAX and a browser.
> > Download your FREE copy of Splunk now >> http://get.splunk.com/
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
> 
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >> http://get.splunk.com/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
