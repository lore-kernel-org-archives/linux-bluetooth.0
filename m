Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3FDFAC8D.7080500@ahsoftware.de>
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Patch for kernel oops while disconnecting	devices
 (hci_usb.c)
References: <10800000.1071618502@[192.168.207.2]> <1071622226.27570.35.camel@pegasus>
In-Reply-To: <1071622226.27570.35.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 17 Dec 2003 02:08:29 +0100

Marcel Holtmann wrote:
> Hi Alexander,
> 
>>I've a small patch for hci_usb.c (from 2.6-test11 and maybe below) which 
>>removes the kernel oops when disconnecting a csr-usb-devices (in my case 
>>with a button on my laptop).
> 
> what happens if you compile the HCI USB driver without SCO support?

The same as with this patch and SCO support, it works. Because that 
pointer on the lkml I've found the fix/workaround relativly fast.

Regards, Alexander




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
