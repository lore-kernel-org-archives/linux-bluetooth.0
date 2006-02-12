Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <495ce9180602121500i5cb97395o@mail.gmail.com>
From: Mario <mario.temporary@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: Developing Broadcom driver support
In-Reply-To: <43EED2E4.1000308@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e44ae5e0602111105n6bacb4e8i@mail.gmail.com>
	 <43EED2E4.1000308@xmission.com>
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
Date: Mon, 13 Feb 2006 00:00:41 +0100

2006/2/12, Brad Midgley <bmidgley@xmission.com>:
> We should find out exactly what that second poster "whoopie" was doing
> to set the mtu. Apparently he was only asking if the modified patch
> would work but he had gotten it working by using the original patch and
> tweaking the mtu at runtime.

It's incredible! Without any patch to the kernel.

hciconfig hci0 scomtu 64:8

IT WORKS!! A nasty Broadcom BT Chipset works! :\

root@legolas:~# hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:10:C6:59:7A:FC ACL MTU: 377:10 SCO MTU: 16:0
        Firmware 2.105 / 97

root@legolas:~# hciconfig hci0 scomtu 64:8

root@legolas:~# hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:10:C6:59:7A:FC ACL MTU: 377:10 SCO MTU: 64:8
        Firmware 2.105 / 97

Now my Plantronics Voyager 510 BT headset works (I have to test it
better with applications now...).

Mario :D


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
