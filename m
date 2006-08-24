Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: "Bearcat M. Sandor" <Linux@feline-soul.com>
To: bluez-users@lists.sourceforge.net
Date: Wed, 23 Aug 2006 23:00:57 -0600
References: <1597.216.47.59.131.1156371924.squirrel@webmail.feline-soul.net>
	<200608232205.01719.Linux@feline-soul.com>
	<44ED2C3B.9020400@xmission.com>
In-Reply-To: <44ED2C3B.9020400@xmission.com>
MIME-Version: 1.0
Message-Id: <200608232300.58022.Linux@feline-soul.com>
Cc: Brad Midgley <bmidgley@xmission.com>
Subject: Re: [Bluez-users]
	=?iso-8859-1?q?Logitech_Traveler_Headset=2E_pin_nev?=
	=?iso-8859-1?q?er_seen_and_i_am=09never_asked=2E?=
Reply-To: Linux@feline-soul.com,
        BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Brad,
I've done so. That was the page i was following.
The page specifies the following fixes:
  If you can't pair or connect with the headset, did you pair it with another 
device?  *There is no other device*
Did it help to reset the pairing by removing /etc/bluetooth/link_key 
or /var/lib/bluetooth/[dongleaddr]/linkkeys or by putting the headset in pair 
mode?  *These files have never existed and it has never been paired. How do i 
put it in paired mode?*

You may have to redo this often if you try to dual-boot windows or if you use 
the same dongle on another computer. *Never been done*
Be sure to set "auth disable" and "encrypt disable" 
in /etc/bluetooth/hcid.conf. *Done*

This is a headset that i ordered from Ebay. A white box.  Do i *know* that the 
pin is still the default? No. However i should still be asked for the pin at 
some point.

Again, when i issue a btsco 00:0D:44:4F:37:72 i get:
Error: Failed to connect to SDP server: Permission denied
Assuming channel 2

Can't connect RFCOMM channel: Permission denied


Thank you for the help. Any other suggestions? I have to get this working.

Bearcat
  
On Wednesday 23 August 2006 22:34 in an email titled "Re: [Bluez-users] 
Logitech Traveler Headset. pin never seen and i am	never asked." Brad Midgley 
wrote:
>Bearcat
>
>> It seems like this is the same old problem that has been plaguing me for a
>> month now. I need to feed this headset a pin of 0000 and i am NEVER asked
>> for a pin no matter what i put into the config file.
>
>we've had this problem from time to time... the only thing that
>sometimes works is to reset the pairing. some suggestions are listed at
>the end of bluetooth-alsa.sf.net.
>
>brad
>
>
>
>
>-------------------------------------------------------------------------
>Using Tomcat but need to do more? Need to support web services, security?
>Get stuff done quickly with pre-integrated technology to make your job
> easier Download IBM WebSphere Application Server v.1.0.1 based on Apache
> Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users

-- 
Bearcat M. Sandor
Bearcat@feline-soul.com
Jabber: bearcat@jabber.feline-soul.net
ICQ: 6628727
MSN: bearcatsandor@hotmail.com
Yahoo: bearcatsandor
AIM: bearcatmsandor



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
