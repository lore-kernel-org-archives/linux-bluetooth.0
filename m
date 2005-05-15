Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4286E60F.1020505@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
References: <42869C29.3040001@volantis.com>
In-Reply-To: <42869C29.3040001@volantis.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Re: [Bluez-devel] Building btsco for Fedora 3
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
Date: Sun, 15 May 2005 00:02:55 -0600

Mark

> Hi. Hopefully this is the right list for this question.

yes, great.

>> a2recv.c:281: error: incompatible type for argument 2 of 
>> `hci_switch_role'

go ahead and comment it out. i had no idea this api had changed though.

>> make: *** /lib/modules/2.6.11-1.14_FC3/source: No such file or 
>> directory.  Stop.

source is a softlink to the source dir on my machine. it may be good 
enough to install the kernel-header package for your kern version. look 
for a kernel-source package too.

brad


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
