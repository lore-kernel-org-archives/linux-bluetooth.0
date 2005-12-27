Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Can't connect RFCOMM channel: Resource
	temporarily unavailable
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20051222092803.72923.qmail@web36112.mail.mud.yahoo.com>
References: <20051222092803.72923.qmail@web36112.mail.mud.yahoo.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <1135672776.25315.7.camel@localhost>
Mime-Version: 1.0
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
Date: Tue, 27 Dec 2005 09:39:36 +0100

Hi Swathi,

> As per your request i have pasted the result of
> =E2=80=9Chciconfig -a=E2=80=9D and =E2=80=9Chcidump -X -V=E2=80=9D. Alo=
ng with it
> someother information which i thought might be helpful
> in debugging.
>=20
> When i first started my pc if found that hcid demon
> was not running. So i re-started the bluetooth
> services and made the hcid to run
> -------------------------------------------------------
> [root@localhost bluetooth]# /etc/init.d/bluetooth
> status
> hcid is stopped
> sdpd (pid 1729) is running...
> [root@localhost bluetooth]# /etc/init.d/bluetooth
> restart
> Stopping Bluetooth services:                         =20
>     [FAILED]
> Starting Bluetooth services:                         =20
>     [  OK  ]
> [root@localhost bluetooth]# /etc/init.d/bluetooth
> restart
> Stopping Bluetooth services:                         =20
>     [  OK  ]
> Starting Bluetooth services:                         =20
>     [  OK  ]
> -------------------------------------------------------
>=20
> The headset is being put in the pairing mode. Hcidump
> -X -V is running in the background. I execute the
> btsco command
> -------------------------------------------------------
> [root@localhost /]# btsco 00:08:C6:3E:54:2C -v -r
> btsco v0.4c
> Device is 1:0
> Error: Failed to connect to SDP server: Function not
> implemented
> Assuming channel 2
>=20
> Voice setting: 0x0060
> Can't connect RFCOMM channel: Resource temporarily
> unavailable
> -------------------------------------------------------
>=20
> output of hcidump -X -V is as below
> -------------------------------------------------------
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>     bdaddr 00:08:C6:3E:54:2C ptype 0xcc18 rswitch 0x01
> clkoffset 0x0000
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > HCI Event: Command Status (0x0f) plen 4
>     Create Connection (0x01|0x0005) status 0x00 ncmd 1
> > HCI Event: PIN Code Request (0x16) plen 6
>     bdaddr 00:08:C6:3E:54:2C
> > HCI Event: Connect Complete (0x03) plen 11
>     status 0x22 handle 41 bdaddr 00:08:C6:3E:54:2C
> type ACL encrypt 0x00
>     Error: LMP Response Timeout
> < HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> > HCI Event: Command Complete (0x0e) plen 6
>     Read Voice Setting (0x03|0x0025) ncmd 1
>     status 0x00 voice setting 0x0060
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>     bdaddr 00:08:C6:3E:54:2C ptype 0xcc18 rswitch 0x01
> clkoffset 0x0000
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > HCI Event: Command Status (0x0f) plen 4
>     Create Connection (0x01|0x0005) status 0x00 ncmd 1
> > HCI Event: PIN Code Request (0x16) plen 6
>     bdaddr 00:08:C6:3E:54:2C
> > HCI Event: Connect Complete (0x03) plen 11
>     status 0x22 handle 42 bdaddr 00:08:C6:3E:54:2C
> type ACL encrypt 0x00
>     Error: LMP Response Timeout
> -------------------------------------------------------

run the next one with "hcidump -X -V -t" to get the timestamps, but I am
quite sure that the hcid is not running.

> -------------------------------------------------------
> [root@localhost mail]# /etc/init.d/bluetooth status
> hcid (pid 3136) is running...
> sdpd (pid 3140) is running...
> -------------------------------------------------------
> output of =E2=80=9Cps x=E2=80=9D
>  2714 ?        Ss     0:00 hcid: processing events
>  2716 ?        Ss     0:00 sdpd
> -------------------------------------------------------

Are you 100% sure that these are running as root. You might better check
with "ps -u root | grep hcid". The non-matching PIDs make it a little
but suspicious.

Check /var/log/messages for any syslog output. However since this looks
like a RedHat or Fedora distribution, it might be a SELinux problem. If
nothing else works, try to switch it off.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
