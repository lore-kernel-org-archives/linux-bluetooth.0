Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Fri, 6 Jul 2007 11:10:29 +0200
From: Stefan Seyfried <seife@suse.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20070706091029.GA934@suse.de>
References: <20070704141123.GA10807@suse.de>
	<1183622728.6351.75.camel@aeonflux.holtmann.net>
	<20070705155549.GF3175@suse.de>
	<1183701453.6351.107.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
In-Reply-To: <1183701453.6351.107.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] Mouse reconnect problems since version 3.12
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

On Fri, Jul 06, 2007 at 07:57:33AM +0200, Marcel Holtmann wrote:
> Hi Stefan,

> > > I need to see the hcidump output. Otherwise I can't tell anything.
> > =

> > HCI sniffer - Bluetooth packet analyzer ver 1.35
> > device: hci0 snap_len: 1028 filter: 0xffffffff
> > > ACL data: handle 6 flags 0x02 dlen 13
> >     L2CAP(d): cid 0x0041 len 9 [psm 0]
> >       0000: a1 02 01 00 00 00 00 00  00                       .........
> > > HCI Event: Mode Change (0x14) plen 6
> >     status 0x00 handle 6 mode 0x00 interval 126
> >     Mode: Active
> > > HCI Event: Mode Change (0x14) plen 6
> >     status 0x00 handle 6 mode 0x02 interval 20
> >     Mode: Sniff
> > =

> > up to here this was a left button press, from here on i was moving the
> > mouse around.
> =

> are you sure that the authorization agent is working. Maybe you wanna
> use adapter.SetTrusted() to make it fully trusted.

I think i already have done this (via kbluetooth). If i have no auth-agent
running, unplug and replug the dongle, then the mouse works again
immediately (after the short reconnection delay).

This is what is in my /var/lib/bluetooth:
root@strolchi:/var/lib/bluetooth# ls 00\:00\:00\:00\:00\:00/
trusts
root@strolchi:/var/lib/bluetooth# cat 00\:00\:00\:00\:00\:00/trusts
00:07:61:3F:1B:6D input
root@strolchi:/var/lib/bluetooth# ls -l 00\:50\:F2\:EA\:6B\:EF/
total 92
-rw-r--r-- 1 root root  3564 26. Jun 14:06 classes
-rw-r--r-- 1 root root    68 28. Jun 10:35 config
-rw-r--r-- 1 root root   525  4. Jul 14:08 features
-rw-r--r-- 1 root root   652  2. Jul 22:42 hidd
-rw-r--r-- 1 root root   865  2. Jul 22:42 input
-rw-r--r-- 1 root root  5502  4. Jul 18:57 lastseen
-rw-r--r-- 1 root root   798  6. Jul 10:58 lastused
-rw------- 1 root root   110 13. Feb 11:26 linkkeys
-rw-r--r-- 1 root root   388  4. Jul 14:08 manufacturers
-rw-r--r-- 1 root root   959  5. Jul 18:40 names
-rw-r--r-- 1 root root 13162  4. Jul 14:28 sdp


Thanks,

    Stefan

-- =

Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out." =


This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG N=FCrnberg)

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
