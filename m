Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problem with dund and LG 325 phone.
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <42962705.9010902@fnal.gov>
References: <42962705.9010902@fnal.gov>
Content-Type: text/plain
Message-Id: <1117143784.12036.78.camel@pegasus>
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
Date: Thu, 26 May 2005 23:43:04 +0200

Hi Eric,

> I have an LG PM-325 which I am trying to get DUN working with. It works under
> Windows, but I want to use linux.
> 
> I think the two devices are paired since I can do l2ping and get responses,
> but I still seem to be a few steps away from being able to do DUN.
> 
> When I type this, I expect to get a success message back, right? Instead I get 
> nothing:
> 
> [root@a122077 root]# dund -c 08:00:37:13:A1:C7 -n
> dund[5586]: Bluetooth DUN daemon
> dund[5586]: Searching for LAP on 08:00:37:13:A1:C7
> [root@a122077 root]#
> 
> I don't have to do anything with rfcomm before this, right? I also don't need 
> to run pand, right, since my device only supports DUN.
> 
> When I try to do a pppd call command, I get this in syslog:
> May 26 14:43:02 a122077 kernel: PPP generic driver version 2.4.2
> May 26 14:43:02 a122077 pppd[5708]: pppd 2.4.3 started by root, uid 0
> May 26 14:43:03 a122077 hcid[3602]: link_key_request (sba=00:10:60:AA:5C:CE, 
> dba=08:00:37:13:A1:C7)
> May 26 14:43:03 a122077 pppd[5708]: Failed to open /dev/rfcomm0: Connection 
> refused
> May 26 14:43:03 a122077 pppd[5708]: Exit.
> 
> which isn't surprising.

using dund for Dialup-Networking is the wrong way. The dund is for LAN
access using PPP. And yes, I know that the name is confusing.

What you need is to find the RFCOMM channel number for Dialup-Networking
with the help of

	sdptool search --bdaddr <bdaddr> dun

and then you bind a RFCOMM TTY port to that channel with

	rfcomm bind 0 <bdaddr> <channel>

After that you can use any dialer (for example wvdial) to setup your
dialup connection through /dev/rfcomm0.

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
