Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] how to recognize whether the connected deviceisa
	headset
From: Marcel Holtmann <marcel@holtmann.org>
To: binch@mobilesoft.com.cn
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20041023160842.2C06A13E20@mail.mobilesoft.com.cn>
References: <20041023160842.2C06A13E20@mail.mobilesoft.com.cn>
Content-Type: text/plain
Message-Id: <1098550768.4866.5.camel@pegasus>
Mime-Version: 1.0
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
Date: Sat, 23 Oct 2004 18:59:28 +0200

Hi Chen,

> >> I have tried hcitool inq command and find that at the last column there is a 
> >> 'class: 0x200404', I refer to the BT spec then find that this can be used for
> >> my purpose, am I right? But what do you mean that this task must be done in
> >> the kernel?
> >
> >when you run you get a copy of the inquiry cache inside the kernel. The
> >cache is per host device. If some creates a connection the COD value
> >from the inquiry should be copied over to the hci_conn structure. For an
> >incoming connection it must be copied from the connection request event,
> >but there is still a connection creation without a previous inquiry that
> >may don't have valid COD value. If this is changed then you have the COD
> >along with the other information of your specific connection. You can
> >workaround in userspace, but this is more complex then doing a patch for
> >the kernel HCI layer.
> >
> Ok, I got your opioion.You mean that if I connect to a given bdaddr but without 
> previous inquiry, I can't got the COD of the remote device, because the connection
> complete event have not a COD parameter.but
> 
> >If this is changed then you have the COD along with the other information of your specific connection.
> 
> what does this mean? What is changed?How to workaround it in userspace?

the hci_conn structure that is used for keeping track of every HCI
connection (ACL or SCO) does not store any COD value at the moment and
so can't retrieve this information easily from userspace.

Do keep track of this from userspace you must hock a program on the raw
HCI socket and look at inquiry result, connection requests and complete
events. This is possible, but not easy and the kernel HCI core already
does most of this for you. However so far nobody asked for the COD value
and so we haven't cared about it.

> Maybe after my project I can do sth. for BlueZ if I get the right answer.

Every help is welcome. Bluetooth programming under Linux is os easy :)

> >> Thanks. Actually, I am a driver engineer, my manager send me to do the driver for
> >> our Bluetooth chip, after some investigate I find the driver is not needed if we 
> >> don't use vendor-specific command, the BlueZ is really a very good stuff.
> >
> >and even specific vendor commands are possible. Take a look at the
> >hciattach source code or the cmd_revision() part of hciconfig. Oh and
> >btw what kind of Bluetooth chip are you using?
> 
> I use TI's BRF6100 chip, this can be done with 'hciattach ttyS0 texas'.Yes, bluez has
> supported some specific command.But for mobile device,the commands about power management
> is very important. I don't sure whether this kind of commands is supported in BlueZ.If so,
> I think I will go to be unemployment,the BlueZ have done all the work:)

Don't forget to send any patches back to the BlueZ mailing list, so I
can include them and make your life easier.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
