Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Peter K. Martin" <Peter.K.Martin@t-online.de>
To: <bluez-users@lists.sourceforge.net>
Subject: AW: [Bluez-users] Toshiba and BT (SuSE 9.2)
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAovN2EgK4N0KEsezKqw8nigEAAAAA@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1103131731.8717.23.camel@pegasus>
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
Date: Thu, 16 Dec 2004 11:49:13 +0100

Hi Marcel,
my BT-problem makes me a little bit sick now. I hoped to solve the =
problem
with you last hints but what happens - really nothing. So the AP is a =
silly
thing.
Here is what I have done:
In YaST still disabled dund and pand
At the very beginnig of my try and error story the kbluetoothd gave me =
the
proposal to change BT device class to 0x100100 and I did so in hcid.conf =
--
does it effect negative to dund?
Because
##>
##>So they are using LAN access using PPP and not the Dialup=20
##>Networking profile. Even if the name is somekind misleading=20
##>you must use dund for the connection. Maybe this one does=20
##>this right job:
##>
##>	dund -n -D -P 1 -X 00:0B:CE:00:01:8F

Linux-Notebook:~ # dund -n -D -P 1 -X 00:0B:CE:00:01:8F
LAP (LAN Access over PPP) daemon version 2.10
Usage:
        dund <options> [pppd options]
Options:
        --show --list -l          Show active LAP connections
        --listen -s               Listen for LAP connections
        --connect -c <bdaddr>     Create LAP connection
        --search -Q[duration]     Search and connect
        --kill -k <bdaddr>        Kill LAP connection
        --killall -K              Kill all LAP connections
        --channel -P <channel>    RFCOMM channel
        --source -S <bdaddr>      Source bdaddr
        --nosdp -D                Disable SDP
        --nodetach -n             Do not become a daemon
        --persist -p[interval]    Persist mode
        --pppd -d <pppd>          Location of the PPP daemon (pppd)
        --msdun -X[timeo]         Enable Microsoft dialup networking =
support
        --cache -C[valid]         Enable addess cache
Linux-Notebook:~ #

I tried a second time after deleting link_key and the result was the =
same.

##>
##>If not then your must send in the hcidump and hope that=20
##>someone decodes the PPP problems. Using PAN would be a lot easier.

hcidump -x showed nothing right after starting dund -n -D -P 1 -X
00:0B:CE:00:01:8F
and after some 20 seconds these responses appeared

Linux-Notebook:~ # hcidump -x
HCIDump - HCI packet analyzer ver 1.11
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Inquiry (0x01|0x0001) plen 5
  33 8B 9E 06 00
> HCI Event: Command Status (0x0f) plen 4
  00 01 01 04
> HCI Event: Inquiry Result (0x02) plen 15
  01 8F 01 00 CE 0B 00 01 00 00 00 03 02 9B 1F
> HCI Event: Inquiry Complete (0x01) plen 1
  00

I don't understand this behaviour as the kbluetoothd shows me the AP =
with
the LAN-symbol even when I do a refresh.
What's going on with the nasty AP? How can I convince it to give me the
rigth connection.

Regards
Peter




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
