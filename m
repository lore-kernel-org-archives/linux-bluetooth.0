Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <423589B1.6000403@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: Fredrik Tolf <fredrik@dolda2000.com>
Cc: bluez-devel@lists.sourceforge.net
References: <1110683934.5056.43.camel@pc7.dolda2000.com>	 <4233C663.80109@xmission.com> <1110762698.5056.73.camel@pc7.dolda2000.com>
In-Reply-To: <1110762698.5056.73.camel@pc7.dolda2000.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] Re: [Patch] Some btsco modifications
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
Date: Mon, 14 Mar 2005 05:55:13 -0700

Fredrik

>>> * Instead of (dis)connecting with the headset button, the driver
>>>notifies userspace when it is in use, and the userspace program connects
>>>accordingly.
>>> * Send SIGUSR1 to the userspace program to make the headset ring.
>>> * The userspace program now reads a config file, ~/.btscorc, which
>>>contains alternating lines of regexes and shell commands. Everything
>>>that the headset sends is matched against these regexes, and if a match
>>>if found, the shell command is run (with any back references replaced).
>>>This, of course, is primarily intended to "do stuff" with the headset
>>>button(s). Send SIGHUP to re-read the config file.

Can you comment on what the implications are for supporting multiple 
headsets simultaneously with a single btsco daemon? Would the kernel 
interaction need to be changed again or could it be limited to the daemon?

Brad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
