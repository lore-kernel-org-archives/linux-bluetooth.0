Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] DiNovo Multimedia keys... again...
From: Marcel Holtmann <marcel@holtmann.org>
To: Rui Lopes <rlopes@ipb.pt>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <413C6DCD.3060606@ipb.pt>
References: <413C6DCD.3060606@ipb.pt>
Content-Type: text/plain
Message-Id: <1094627466.5384.2.camel@notepaq>
Mime-Version: 1.0
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
Date: Wed, 08 Sep 2004 09:11:06 +0200

Hi Rui,

> I'm successfully using the Logitech DiNovo keyboard and mouse in both 
> Desktop and Laptop in bluetooth. However, the multimedia keys are not 
> recognized.
> The procedure I followed to install the keyboard is the following:
> 
> $ modprobe hidp
> $ hidd --server
> $ hid2hci
> 
> done! it works.
> 
> I can see that the keyboard events with hcidump when pressing the 
> multimedia hotkeys (in this case, volume up, volume down and mute):
> HCIDump - HCI packet analyzer ver 1.10
> device: hci0 snap_len: 1028 filter: 0xffffffff
>  > ACL data: handle 0x0029 flags 0x02 dlen 14
>      L2CAP(d): cid 0x0041 len 10 [psm 0]
>  > ACL data: handle 0x0029 flags 0x02 dlen 10
>      L2CAP(d): cid 0x0041 len 6 [psm 0]
>  > ACL data: handle 0x0029 flags 0x02 dlen 10
>      L2CAP(d): cid 0x0041 len 6 [psm 0]
>  > ACL data: handle 0x0029 flags 0x02 dlen 10
>      L2CAP(d): cid 0x0041 len 6 [psm 0]
>  > ACL data: handle 0x0029 flags 0x02 dlen 10
>      L2CAP(d): cid 0x0041 len 6 [psm 0]
>  > ACL data: handle 0x0029 flags 0x02 dlen 10
>      L2CAP(d): cid 0x0041 len 6 [psm 0]
>  > ACL data: handle 0x0029 flags 0x02 dlen 10
>      L2CAP(d): cid 0x0041 len 6 [psm 0]
>  > ACL data: handle 0x0029 flags 0x02 dlen 14
>      L2CAP(d): cid 0x0041 len 10 [psm 0]
> 
> But they don't show up in xev (this is the Return key press and release 
> event. Multimedia keys doesn't cause any event to occurr):
> KeyPress event, serial 26, synthetic NO, window 0x3c00001,
>      root 0x5e, subw 0x0, time 103253160, (391,131), root:(1299,323),
>      state 0x0, keycode 36 (keysym 0xff0d, Return), same_screen YES,
> "   XLookupString gives 1 bytes:  "
> 
> KeyRelease event, serial 26, synthetic NO, window 0x3c00001,
>      root 0x5e, subw 0x0, time 103253248, (391,131), root:(1299,323),
>      state 0x0, keycode 36 (keysym 0xff0d, Return), same_screen YES,
> "   XLookupString gives 1 bytes:  "
> 
> Any clue?

try the 2.6.8-mh1 kernel patch and see if they are mapped now.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
