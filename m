Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Toshiba and BT (SuSE 9.2)
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAovN2EgK4N0KEsezKqw8nigEAAAAA@t-online.de>
References: 
	 <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAovN2EgK4N0KEsezKqw8nigEAAAAA@t-online.de>
Content-Type: text/plain
Message-Id: <1103195360.28046.56.camel@pegasus>
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
Date: Thu, 16 Dec 2004 12:09:20 +0100

Hi Peter,

> At the very beginnig of my try and error story the kbluetoothd gave me the
> proposal to change BT device class to 0x100100 and I did so in hcid.conf --
> does it effect negative to dund?

there is not negative effect.

> ##>
> ##>So they are using LAN access using PPP and not the Dialup 
> ##>Networking profile. Even if the name is somekind misleading 
> ##>you must use dund for the connection. Maybe this one does 
> ##>this right job:
> ##>
> ##>	dund -n -D -P 1 -X 00:0B:CE:00:01:8F
> 
> Linux-Notebook:~ # dund -n -D -P 1 -X 00:0B:CE:00:01:8F
> LAP (LAN Access over PPP) daemon version 2.10
> Usage:
>         dund <options> [pppd options]
> Options:
>         --show --list -l          Show active LAP connections
>         --listen -s               Listen for LAP connections
>         --connect -c <bdaddr>     Create LAP connection
>         --search -Q[duration]     Search and connect
>         --kill -k <bdaddr>        Kill LAP connection
>         --killall -K              Kill all LAP connections
>         --channel -P <channel>    RFCOMM channel
>         --source -S <bdaddr>      Source bdaddr
>         --nosdp -D                Disable SDP
>         --nodetach -n             Do not become a daemon
>         --persist -p[interval]    Persist mode
>         --pppd -d <pppd>          Location of the PPP daemon (pppd)
>         --msdun -X[timeo]         Enable Microsoft dialup networking support
>         --cache -C[valid]         Enable addess cache
> Linux-Notebook:~ #

Oh may bad. There is a typo in there :(

	dund -n -D -P 1 -X -c 00:0B:CE:00:01:8F

> I don't understand this behaviour as the kbluetoothd shows me the AP with
> the LAN-symbol even when I do a refresh.

May this icon is based on the class of device of your AP or a service
search on it. This has nothing to do with your problem.

> What's going on with the nasty AP? How can I convince it to give me the
> rigth connection.

It is PPP over RFCOMM and PPP itself is not a nice thing.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
