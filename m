Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Michael Wever <mick@machina.no>
Message-ID: <pan.2004.03.30.07.32.53.106568@machina.no>
References: <pan.2004.03.29.08.17.54.697624@netbeans.org> <1080556737.2281.217.camel@pegasus> <pan.2004.03.29.10.58.33.731525@machina.no> <1080559561.2281.227.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: [Bluez-users] Re: Re: Bluetooth device missing after kernel	recompile
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
Date: Tue, 30 Mar 2004 09:32:53 +0200

On Mon, 29 Mar 2004 13:26:02 +0200, Marcel Holtmann wrote:
> I meant lsusb.

Bus 003 Device 001: ID 0000:0000
Bus 002 Device 002: ID 0a12:0001 Cambridge Silicon Radio, Ltd
Bus 002 Device 001: ID 0000:0000
Bus 001 Device 001: ID 0000:0000

> Check the dmesg output to see if any of the USB host controller drivers
> complain about anything.

Nothing interesting that I can find in /var/log/messages (I have no
dmesg). But during startup on the console I read: 

No modules for INPUT product 0011/0002/0005/0000 
No modules for INPUT product 0011/0001/0001/ab41

But.... I had to reboot to catch these and... it works now!?
(I have rebooted since the kernel recompile a number of times so I very
buffled but happy nonetheless). 
Sorry for wasting your time and thanks for
your help.

Mick.



-- 
-- <BR/>
"The reward of patience is patience." St. Augustine
<BR/> --- <a href=http://www.harryspractice.com.au>Harry's Practice</a> --- 




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
