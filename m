Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41AB8B10.2070303@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] snd-bt-sco problems (Brad, Marcel)
References: <200411291935.12702.carlosarazevedo@netcabo.pt>
In-Reply-To: <200411291935.12702.carlosarazevedo@netcabo.pt>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Mon, 29 Nov 2004 13:48:16 -0700

Carlos

> Brad : I don't have any other dongle or headset, but I've tested both on
> Windows and they work together; aplay exists after a 9-10 second timeout; I'm
> not running any kind of X because this is a telephony server machine (or will
> be); I've tried with the following modules.conf but to no avail :
...
> since I'm running LFS, a do-it-yourself distro, I don't have a specific
> startup script, I just load the modules (snd-via82xx and snd-bt-sco)

I'm not suggesting you try different hardware because they can't talk to 
one another... it's because we have a software problem somewhere and I 
want to isolate it.

Your setup looks fine. I haven't dug into the kernel module any more 
than I've had to so I don't know where to look there. I haven't wanted 
to because it may need to be moved to userspace anyway.

Do we have tools for testing sco audio to and from the headset entirely 
in userspace?

Brad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
