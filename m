Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hcid config
From: Marcel Holtmann <marcel@holtmann.org>
To: Chris Searle <usenet@chrissearle.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <lgk6wvgqax.fsf@montgomery.empolis.no>
References: <lgk6wvgqax.fsf@montgomery.empolis.no>
Content-Type: text/plain
Message-Id: <1090572097.21828.53.camel@pegasus>
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
Date: Fri, 23 Jul 2004 10:41:38 +0200

Hi Chris,

> Been having some problems with a comOne dongle both before and after
> upgrading to kernel 2.6.7 (debian unstable).
> 
> So - I've just plugged in a belken dongle from another machine too
> (with ideas of using one to test what services the other is showing).
> 
> Both appear in /var/log/messages and also in /proc/bus/usb/devices
> 
> So - some simple tests:
> 
> chris@chris:~$ hcitool dev
> Devices:
>         hci0    00:30:C2:08:0A:A1
>         hci1    00:0A:3A:54:5B:49
> chris@chris:~$ hcitool -i hci0 scan
> Scanning ...
>         00:0A:D9:94:BF:68       Chris Mobile
>         00:0A:3A:54:5B:49       WINDOWS-2000
> chris@chris:~$ hcitool -i hci1 scan
> Scanning ...
>         00:30:C2:08:0A:A1       Chris
>         00:0A:D9:94:BF:68       Chris Mobile
> 
> 
> Now - this is odd - in hcid.conf I have 
> 
> device {
>         # Local device name
>         #   %d - device id
>         #   %h - host name
>         name "%h-%d";
> 
> I was expecting two names - chris-0 (where now it's Chris) and chris-1
> (where now of all things its WINDOWS-2000).

check if you have hcid running as root.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
