Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42876512.5040205@marubeca.net>
From: Mark Watson <mark@marubeca.net>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Building btsco for Fedora 3
References: <42869C29.3040001@volantis.com> <4286E60F.1020505@xmission.com>
In-Reply-To: <4286E60F.1020505@xmission.com>
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
Date: Sun, 15 May 2005 16:04:50 +0100

Brad Midgley wrote:

> Mark
> ...
>
>>> make: *** /lib/modules/2.6.11-1.14_FC3/source: No such file or 
>>> directory. Stop.
>>
> source is a softlink to the source dir on my machine. it may be good 
> enough to install the kernel-header package for your kern version. 
> look for a kernel-source package too.
>
Thanks Brad. Turns out the link was the thing I missed. Made link, made 
config in kernel source dir and the driver built. Now (and firstly, I'm 
probably continuing to be dense, and probably secondly, in the wrong 
list at this stage) after depmod the mod loads OK but when I try:

btsco <device address> 1

.. when in pairing mode on the device (a jabra 250) I get

Can't connect RFCOMM channel: Resource temporarily unavailable

I've set the default pin via bluez-pin, was previously seeing auth 
requests in log.

Mark




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
