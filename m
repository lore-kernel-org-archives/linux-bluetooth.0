Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Eric Vaandering <ewv@fnal.gov>
Subject: Re: [Bluez-users] Problem with dund and LG 325 phone.
In-reply-to: <1117177674.12036.93.camel@pegasus>
To: bluez-users@lists.sourceforge.net
Message-id: <429736EF.6000205@fnal.gov>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
References: <42962705.9010902@fnal.gov> <1117143784.12036.78.camel@pegasus>
 <42967B9B.2000203@fnal.gov> <1117177674.12036.93.camel@pegasus>
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
Date: Fri, 27 May 2005 10:04:15 -0500

Yes, that was it. I'm now happily connected with pppd on channel *5*. I 
thought those would be fixed in stone for the phone model.

John, as to how to pair the phone and the PC.

First, under "Setting -> Setup/Others" choose to update your software. 
I'm on v18. Apparently v17 and v18 have updates for BT.

Then on Settings -> Bluetooth turn visibility on and also change your BT 
name if you want.

Then under Bluetooth from the *Main* menu, enable BT and do "Add New." 
and also click "enable" for the computer, which will enable DUN. I think 
you can either choose to search and pair or just wait for pairing. Then 
some trial and error, I can't give you an exact formula, but you will 
have to type in the same pin on the phone and the PC (I use KDE's 
bluetooth pin helper and KDE's BT browsing). The phone will tell you if 
the pairing is sucessful.

Also, according to 
http://www.sprintusers.com/forum/archive/index.php/t-57061.html you may 
have to do several iterations of enabling and disabling a device to get 
the pairing to work.

The nice thing is once you have it paired, you can just leave it paired.

Good luck, e-mail me privately if you want more help.

Eric



Marcel Holtmann wrote:

>Hi Eric,
>
>  
>
>>thanks that helped and at one point I got the phone dialing, but not 
>>anymore. I'm still getting "Connection refused" errors. The computer and phone 
>>are definitely paired since I can use kbthandsfree.
>>
>>If I issue these commands:
>>
>>   748  echo 1 > /proc/sys/net/ipv4/ip_forward
>>   749  rfcomm bind 0 08:00:37:13:A1:C7 4
>>   750  pppd /dev/rfcomm0 debug nocrtscts novj novjccomp defaultroute connect 
>>'chat -v -f /root/sprint-chat'
>>
>>May 26 20:38:12 localhost pppd[4987]: pppd 2.4.3 started by root, uid 0
>>May 26 20:38:13 localhost hcid[3622]: link_key_request (sba=00:10:60:AA:5C:CE, 
>>dba=08:00:37:13:A1:C7)
>>May 26 20:38:13 localhost pppd[4987]: Failed to open /dev/rfcomm0: Connection 
>>refused
>>May 26 20:38:13 localhost pppd[4987]: Exit.
>>
>>This is what hcidump shows (sorry for the length, but I don't know what's 
>>important)
>>    
>>
>
>try to reset/reboot your phone and check the RFCOMM channel number again
>with sdptool. It looks like that this channel is no longer accepting new
>connections.
>
>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by Yahoo.
>Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
>Search APIs Find out how you can build Yahoo! directly into your own
>Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users
>  
>



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
