Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20060109104657.71194.qmail@web36102.mail.mud.yahoo.com>
From: Swathi Mathur80 <swathi_mathur80@yahoo.com>
Subject: Re: [Bluez-users] Can't connect RFCOMM channel: Resource temporarily unavailable
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1135772170.3819.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Date: Mon, 9 Jan 2006 02:46:57 -0800 (PST)

Hello Marcel,
Good news is that i am able to successfully transfer
the audio files from my pc onto my headset.
I would like to thank Mr. Marcel for helping me to fix
the problem. 
The solution to the error which i faced
-------------------------------------------
Because of the SELinux security policies, Bluetooth
demon's might not me able to access certain
configuration file. Hence, they might not start.
Completely disable the security in SELinux which is
done by editing/launching the SELinux menu by "running
system-config-securitylevel"
In this menu under the SELinux tab.
uncheck "Enabled (modfn requires reboot)" option
aswell as uncheck "enforcing current: disabled"
Under the Firewall Options
security level option set to Disable firewall.
---------------------------------------------

Reboot the system and you won't get the error

Thank you once again Mr. Marcel for replying to all my
queries.

Warm Regards,
Swathi






--- Marcel Holtmann <marcel@holtmann.org> wrote:

> HI Swathi,
> 
> > Yes, i am running btsco module on Fedora Core 4.
> What
> > do you mean by your statement "if nothing else
> works
> > try to switch it off".
> 
> I am talking about SELinux. Use Google for more
> information about it,
> because this is not the topic of this mailing list.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
>
-------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do
> you grep through log files
> for problems?  Stop!  Download the new AJAX search
> engine that makes
> searching your log files as easy as surfing the 
> web.  DOWNLOAD SPLUNK!
>
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
> 



		
__________________________________________ 
Yahoo! DSL – Something to write home about. 
Just $16.99/mo. or less. 
dsl.yahoo.com 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
