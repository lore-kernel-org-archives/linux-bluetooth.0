Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <404FB5D1.5030104@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: Russell Neches <russell@ccs.neu.edu>, bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] crash on remove
References: <20040310182158.GA9279@naginata.ccs.neu.edu> <404F84BC.4020406@xmission.com> <20040310223504.GA3398@omocha.vort.org>
In-Reply-To: <20040310223504.GA3398@omocha.vort.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Wed, 10 Mar 2004 17:41:53 -0700

Russell

>>safely remove a usb adapter is to stop the bluetooth daemons, force
>>remove hci_usb (there always seems to be one reference pinning it down
>>that I can't find), then unplug the adapter.
> 
> 
> Do you have to do a force remove, or will it unload cleanly?
> 
> What do you mean by a "reference"? Does it claim to be in use when you
> you rmmod it?

yes, i enabled force remove because the module shows up as in use. i 
think it's unsafe, but how much worse can it be than crashing the kernel?

i am compiling the modules without SCO support right now to see if that 
helps.

brad


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
