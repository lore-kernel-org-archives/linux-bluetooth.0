Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Peter K. Martin" <Peter.K.Martin@t-online.de>
To: <bluez-users@lists.sourceforge.net>
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAABJG805ofp06ZnA72MyIcZwEAAAAA@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1099578162.7022.21.camel@pegasus>
Subject: [Bluez-users] AW: Re: Again dund
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 5 Nov 2004 15:00:08 +0100

Hi Marcel,
during my efforts to bring up a bluetooth connection, I'm always logged in
as root.

I checked with ps, here the result:

Linux-Notebook:~ # ps
  PID TTY          TIME CMD
 6340 pts/1    00:00:00 bash
 6348 pts/1    00:00:00 ps
Linux-Notebook:~ # hcid
Linux-Notebook:~ # ps
  PID TTY          TIME CMD
 6340 pts/1    00:00:00 bash
 6363 pts/1    00:00:00 ps

Then I initializedb the BT-function of my Toshiba-laptop:

Linux-Notebook:~ # dmabt
Linux-Notebook:~ # ps
  PID TTY          TIME CMD
 6340 pts/1    00:00:00 bash
 6462 pts/1    00:00:00 ps
Linux-Notebook:~ # hcid
Linux-Notebook:~ # ps
  PID TTY          TIME CMD
 6340 pts/1    00:00:00 bash
 6552 pts/1    00:00:00 ps

The next step was to use the hcitool:

Linux-Notebook:~ # hcitool scan
Scanning ...
        00:0B:CE:00:01:8F       Bluetooth-Modul
        00:02:EE:D0:49:44       PkM 6820

the BT-Modul and my handy (Nokia 6820) were detected. With sdptool I tried
to get the available services, at first of the BT-Modul:

Linux-Notebook:~ # sdptool browse 00:0B:CE:00:01:8F
Failed to connect to SDP server on 00:0B:CE:00:01:8F: Connection refused

and second my handy:

Linux-Notebook:~ # sdptool browse 00:02:EE:D0:49:44
Browsing 00:02:EE:D0:49:44 ...
Service Name: OBEX Object Push
Service RecHandle: 0x10000
Service Class ID List:
  "OBEX Object Push" (0x1105)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 9
  "OBEX" (0x0008)
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "OBEX Object Push" (0x1105)
    Version: 0x0100
etc........

At the moment I don't know how to get the daemon hcid running. I think if
this daemon runs, many of the problems are solved, aren't they?

Regards
Peter


> Hi Peter,
>
> > I tried to start hcid by typing it at the command-line, but I don't 
> > know how to control if this daemon runs.
>
> check with ps. You must run it as root and only one hcid process at the
same time is > allowed.
>  
> > Hcidump -x gives nearly no response, only the version-no
> 
> Then there is something wrong. You must at least see something when you
run an inquiry or 
> create a connection. Do this as root.
> 
> Regards
>
> Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
