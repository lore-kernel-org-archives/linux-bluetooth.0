Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41DE0E1B.6000007@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco under FC3
References: <v04020a1dbe030e257568@192.168.49.19>	 <1105032390.4299.92.camel@pegasus> <5256d0b0501061930711f3884@mail.gmail.com>
In-Reply-To: <5256d0b0501061930711f3884@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 06 Jan 2005 21:20:43 -0700

Peter,

My understanding is frequency hopping is in the firmware but eSCO is 
(going to be) in the bluez stack.

Brad

Peter Robinson wrote:
>>and again, the development files from the AO library are missing. Check
>>your Fedora Core 3 distribution.
> 
> 
> as soon as I read this I knew what the problem was.
> 
> a up2date -i libao-devel followed by removing the install and
> downloading the CVS version again and it built straight up :-)
> 
> Time to do some testing...
> 
> Not exactly related but what is the current supported Bluetooth
> version in the Linux stack. Does the stack change at all to support BT
> 1.0, 1.1 or 1.2 or is it all Firmware/Hardware Changes. If support is
> required in the stack what is the current bt version implemented as of
> 2.6.10? In particular wondering about the freq hopping and the voice
> improvements in v1.2
> 
> I'll let you know how I go with the Headset.
> 
> Regards
> Peter
> 
> 
> -------------------------------------------------------
> The SF.Net email is sponsored by: Beat the post-holiday blues
> Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
> It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
