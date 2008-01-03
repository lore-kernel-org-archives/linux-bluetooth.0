Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <477C6D10.2040003@cs.wisc.edu>
References: <477C6D10.2040003@cs.wisc.edu>
Date: Thu, 03 Jan 2008 06:21:18 +0100
Message-Id: <1199337678.26099.35.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-users] enabling/disabling in response to ThinkPad hotkey
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

Hi Ben,

> My ThinkPad X61 laptop has a special wireless networking hotkey, Fn+F5. 
>   Traditionally this has been used to enable/disable bluetooth.  That's 
> how it worked with previous ThinkPads I've owned, but on this X61, when 
> I press Fn+F5, nothing happens.
> 
> The HAL daemon running on correctly detects the key press and broadcasts 
> this on the system D-BUS:
> 
>      signal sender=:1.5 -> dest=(null destination)
>        path=/org/freedesktop/Hal/devices/computer;
>        interface=org.freedesktop.Hal.Device;
>        member=Condition
>          string "ButtonPressed"
>          string "wifi-power"
> 
> If I want Fn+F5 to toggle bluetooth, how should I hook that up?  I 
> already know how to write a small Python script that reacts to HAL 
> ButtonPressed signals.  But this script would need to run as root, since 
> normal uses cannot write to /proc/acpi/ibm/bluetooth.  (One 
> enables/disables bluetooth by echoing "enable" or "disable" into 
> /proc/acpi/ibm/bluetooth.)
> 
> I'm loath to create new scripts running as root.  Is that really the 
> right approach here?  Or is there some other system component that 
> already ought to be listening for this signal but is either buggy or not 
> running?
> 
> I asked about this on the HAL mailing list, and Rui Tiago Matos replied:
> > Shouldn't bluez-utils' hcid daemon handle this?  Actually, I think
> > these kind of daemons should be autostarted by D-Bus when HAL
> > broadcasts their signal and exit gracefully when the user turns the
> > killswitch off.
> 
> Do the bluez-utils developers agree?  Is this something hcid should 
> already be listening for and handling?  Should I file a bluez-utils bug 
> report requesting that it do this?  Or do you consider this to be 
> outside of hcid's domain of responsibility?
> 
> Please note that my concern here is not actually the radio kill switch 
> that Rui Tiago Matos mentions.  That seems to work fine.  (The daemons 
> keep running and do not "exit gracefully", but at least the desktop 
> reacts appropriately when the radio kill switch takes bluetooth away.) 
> So the question here is the Fn+F5 wifi button, not the radio kill switch.

we discussed this some time ago at one of the BlueZ developer meetings.
The overall agreement was that this should be handled via rfkill and/or
HAL.

The reason for this is that the Bluetooth on/off switches are all
different and HAL and rfkill is the way to abstract it into a common
interface. It is not the job of hcid to abstract this.

Also when it comes to handle these events from HAL/rfkill, then we can
discuss handling this inside bluez-gnome. Putting that code into hcid
would be wrong.

The discussion about starting hcid from within HAL has been discussed
and yes, eventually it will happen.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
