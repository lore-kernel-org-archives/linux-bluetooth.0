Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Peter K. Martin" <Peter.K.Martin@t-online.de>
To: <bluez-users@lists.sourceforge.net>
Subject: AW: [Bluez-users]  Again dund
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAANK6QCAXtF0GbwUwUahcSwAEAAAAA@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1099664868.6919.20.camel@pegasus>
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
Date: Fri, 5 Nov 2004 18:46:17 +0100

Hi Marcel,
refering to Linux I'm a very beginner and thatfore excuse my mistakes,
please

ps x gave me:

Linux-Notebook:~ # ps x
...........
 5173 ?        Ss     0:00 hcid: processing events
etc ...........

but the hcidump -x
Linux-Notebook:~ # hcidump -x
HCIDump - HCI packet analyzer ver 1.7
device: hci0 snap_len: 1028 filter: 0xffffffff
  <-- at this point the program stopped and I terminated with crtl-c

I need some aditional help for the manual of hcid.conf=20

nn:nn:nn:nn:nn:nn  <--- how can I give the address of the BT-modul? what
does this mean?

              Parameters  specified within this section will be applied =
to
the device with              =20
                          this device bluetooth address. All other
parameters are applied=20
                          from the default section.



       pin_helper "file"

              The  path  to  the PIN helper application. The default is
"/bin/bluepin".  The=20
              following
              output is expected from the PIN helper:

PIN:12345678  <-- I need another PIN, how zo do this?

              Or, when no PIN is available:

              ERR

Thanks and regards
Peter


##>-----Urspr=FCngliche Nachricht-----
##>Von: bluez-users-admin@lists.sourceforge.net=20
##>[mailto:bluez-users-admin@lists.sourceforge.net] Im Auftrag=20
##>von Marcel Holtmann
##>Gesendet: Freitag, 5. November 2004 15:28
##>An: BlueZ Mailing List
##>Betreff: Re: [Bluez-users] AW: Re: Again dund
##>
##>
##>Hi Peter,
##>
##>> during my efforts to bring up a bluetooth connection, I'm always=20
##>> logged in as root.
##>>=20
##>> I checked with ps, here the result:
##>>=20
##>> Linux-Notebook:~ # ps
##>>   PID TTY          TIME CMD
##>>  6340 pts/1    00:00:00 bash
##>>  6348 pts/1    00:00:00 ps
##>> Linux-Notebook:~ # hcid
##>> Linux-Notebook:~ # ps
##>>   PID TTY          TIME CMD
##>>  6340 pts/1    00:00:00 bash
##>>  6363 pts/1    00:00:00 ps
##>
##>reading the manual page of ps may help. Or try "ps x" ;)
##>
##>> Then I initializedb the BT-function of my Toshiba-laptop:
##>>=20
##>> Linux-Notebook:~ # dmabt
##>> Linux-Notebook:~ # ps
##>>   PID TTY          TIME CMD
##>>  6340 pts/1    00:00:00 bash
##>>  6462 pts/1    00:00:00 ps
##>> Linux-Notebook:~ # hcid
##>> Linux-Notebook:~ # ps
##>>   PID TTY          TIME CMD
##>>  6340 pts/1    00:00:00 bash
##>>  6552 pts/1    00:00:00 ps
##>>=20
##>> The next step was to use the hcitool:
##>>=20
##>> Linux-Notebook:~ # hcitool scan
##>> Scanning ...
##>>         00:0B:CE:00:01:8F       Bluetooth-Modul
##>>         00:02:EE:D0:49:44       PkM 6820
##>>=20
##>> the BT-Modul and my handy (Nokia 6820) were detected. With=20
##>sdptool I=20
##>> tried to get the available services, at first of the BT-Modul:
##>>=20
##>> Linux-Notebook:~ # sdptool browse 00:0B:CE:00:01:8F
##>> Failed to connect to SDP server on 00:0B:CE:00:01:8F: Connection=20
##>> refused
##>>=20
##>> and second my handy:
##>>=20
##>> Linux-Notebook:~ # sdptool browse 00:02:EE:D0:49:44
##>> Browsing 00:02:EE:D0:49:44 ...
##>> Service Name: OBEX Object Push
##>> Service RecHandle: 0x10000
##>> Service Class ID List:
##>>   "OBEX Object Push" (0x1105)
##>> Protocol Descriptor List:
##>>   "L2CAP" (0x0100)
##>>   "RFCOMM" (0x0003)
##>>     Channel: 9
##>>   "OBEX" (0x0008)
##>> Language Base Attr List:
##>>   code_ISO639: 0x656e
##>>   encoding:    0x6a
##>>   base_offset: 0x100
##>> Profile Descriptor List:
##>>   "OBEX Object Push" (0x1105)
##>>     Version: 0x0100
##>> etc........
##>>=20
##>> At the moment I don't know how to get the daemon hcid=20
##>running. I think=20
##>> if this daemon runs, many of the problems are solved, aren't they?
##>
##>You must run "hcidump -x" to see what is going on.
##>
##>Regards
##>
##>Marcel
##>
##>
##>
##>
##>-------------------------------------------------------
##>This SF.Net email is sponsored by:
##>Sybase ASE Linux Express Edition - download now for FREE=20
##>LinuxWorld Reader's Choice Award Winner for best database on=20
##>Linux. http://ads.osdn.com/?ad_id=3D5588&alloc_id=3D12065&op=3Dclick
##>_______________________________________________
##>Bluez-users mailing list
##>Bluez-users@lists.sourceforge.net=20
##>##>https://lists.sourceforge.net/lists/listinfo/bluez-users/list
##>info/bluez-users
##>




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
