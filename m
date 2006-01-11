Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Strange things with SE K750i and remote control
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <19c2b3920601110619x37c6e4ck@mail.gmail.com>
References: <19c2b3920601110619x37c6e4ck@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1136989658.3825.26.camel@localhost.localdomain>
Mime-Version: 1.0
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
Date: Wed, 11 Jan 2006 15:27:37 +0100

Hi,

> i can upload/download files without any problem using bluetooth.
> 
> But when i use the remote control fonction, i need to delete the
> device i want to use before use it if i used it before :/
> 
> For example :
> i have no device declared on the phone
> i choose remote control desktop
> the phone find my USB key device
> i choose yes yes yes yes in the menu and i can control my mouse, etc.
> everything fine
> i go out in the menu, send a sms, make a call or even nothing
> i go back to the remote control menu and choose the device found just
> before
> the phone write "impossible to connect" and /var/log/daemon add
> a hcid[pid]: link_key_request sba USB dba MyPhone
> i go in the device known by the phone, delete the connexion
> i retry and it works again :/
> 
> Exactly the same things if i make the connection from the PC
> only difference is
> #hidd --connect 00:phonebt:00
> Can't create HID control channel: Connection refused
> 
> The phone is configured with "Always accept" from this device
> 
> I have a Ubuntu 5.10 with

what bluez-utils version is installed on Ubuntu 5.10. I had to include
some workarounds for the SonyEricsson phones. Maybe you try it with
--nosdp if this switch is available.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
