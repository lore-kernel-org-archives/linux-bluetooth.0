Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Hans Bausewein <hans@comerwell.xs4all.nl>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Broadcom Corporation (Firmware 105.105.074) USB dongle
Message-ID: <20041030195917.GA10109@comerwell.xs4all.nl>
References: <20041030094327.GA8724@comerwell.xs4all.nl> <1099136877.6912.41.camel@pegasus> <20041030124433.GA9232@comerwell.xs4all.nl> <1099143692.10448.14.camel@pegasus> <20041030152320.GA9566@comerwell.xs4all.nl> <1099150958.16247.12.camel@pegasus> <20041030155712.GA9715@comerwell.xs4all.nl> <1099152611.16247.23.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1099152611.16247.23.camel@pegasus>
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
Date: Sat, 30 Oct 2004 21:59:17 +0200

On Sat, Oct 30, 2004 at 06:10:11PM +0200, Marcel Holtmann wrote:
> 
> actually there must be a secret within the init sequence of the commands
> and you should try a clean 2.6.9 vanilla kernel with the -mh3 patch.    
 
same results

p2:~# hciconfig dev hci0 up
Can't init device hci0. Device or resource busy(16)

And then I plugged in the other MSI (CSR) dongle: still works fine.

> I think I will get this dongle working, but I need it at home for further
> testing and I stopped buying Bluetooth dongles by myself. If you believe
> it or not, I have enough of them ;)

I think about returning it to the shop and buying the Cambridge-based
dongle. Let me know if I can try anything. I'll have it until tuesday, at
least.

Would it help to turn on CONFIG_BT_HCIUSB_DEBUG and examine log ?
 
Regards

Hans


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
