Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4341EB2C.1040804@ozob.net>
From: Gene Imes <ebi7@ozob.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] BlueZ on Sony Vaio notebook with builtin Bluetooth
References: <20050930205939.3e5081ff.c3t0@yahoo.de>
In-Reply-To: <20050930205939.3e5081ff.c3t0@yahoo.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed
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
Date: Mon, 03 Oct 2005 21:38:36 -0500

c3t0@yahoo.de wrote:
> Hi,
> I'm new to this mailinglist and to be honest I'm also new to mailinglists at all.
> 
> I recently bought a second-hand notebook (Sony Vaio PCG-Z1M) and I'm trying to get everything
> to work atm. Almost everything works quite fine except the bluetooth-device, which is
> built-in.
> 
> I don't have problems turning the bluetooth-device on and off using sonypi and spicctrl
> as the blue led on the laptop, which indicates the bluetooth-device-status, reacts on my
> spicctrl commands. Unfortunatly the BlueZ-utils doesn't detect any bluetooth-device even 
> though I activated it via "spicctrl -l1" and loaded the hci-usb-modul (bluetooth itself 
> is compiled in the kernel).
> 

Try to compile bluetooth as modules.

-- 
Gene Imes                               www.ozob.net


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
