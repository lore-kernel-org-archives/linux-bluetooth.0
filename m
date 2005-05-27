Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problem with dund and LG 325 phone.
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <42967B9B.2000203@fnal.gov>
References: <42962705.9010902@fnal.gov> <1117143784.12036.78.camel@pegasus>
	 <42967B9B.2000203@fnal.gov>
Content-Type: text/plain
Message-Id: <1117177674.12036.93.camel@pegasus>
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
Date: Fri, 27 May 2005 09:07:54 +0200

Hi Eric,

> thanks that helped and at one point I got the phone dialing, but not 
> anymore. I'm still getting "Connection refused" errors. The computer and phone 
> are definitely paired since I can use kbthandsfree.
> 
> If I issue these commands:
> 
>    748  echo 1 > /proc/sys/net/ipv4/ip_forward
>    749  rfcomm bind 0 08:00:37:13:A1:C7 4
>    750  pppd /dev/rfcomm0 debug nocrtscts novj novjccomp defaultroute connect 
> 'chat -v -f /root/sprint-chat'
> 
> May 26 20:38:12 localhost pppd[4987]: pppd 2.4.3 started by root, uid 0
> May 26 20:38:13 localhost hcid[3622]: link_key_request (sba=00:10:60:AA:5C:CE, 
> dba=08:00:37:13:A1:C7)
> May 26 20:38:13 localhost pppd[4987]: Failed to open /dev/rfcomm0: Connection 
> refused
> May 26 20:38:13 localhost pppd[4987]: Exit.
> 
> This is what hcidump shows (sorry for the length, but I don't know what's 
> important)

try to reset/reboot your phone and check the RFCOMM channel number again
with sdptool. It looks like that this channel is no longer accepting new
connections.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
