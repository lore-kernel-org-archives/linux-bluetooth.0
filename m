Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Rainer Dorsch <rdorsch@web.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] pand seem to ignore any pin configurations
References: <200505072203.45598.rdorsch@web.de> <1115498144.9031.19.camel@pegasus>
In-Reply-To: <1115498144.9031.19.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200505072339.13643.rdorsch@web.de>
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
Date: Sat, 7 May 2005 23:39:13 +0200

Hi Marcel,

thanks for the quick reply. Where would I specify the PIN on the PANU? Should 
pin_helper in hcid.conf provide this? Where would I specify the PIN on the 
NAP?


There is no --auth for pand:

silverboxy:~# pand -h
Bluetooth PAN daemon version 2.15
Usage:
        pand <options>
Options:
        --show --list -l          Show active PAN connections
        --listen -s               Listen for PAN connections
        --connect -c <bdaddr>     Create PAN connection
        --autozap -z              Disconnect automatically on exit
        --search -Q[duration]     Search and connect
        --kill -k <bdaddr>        Kill PAN connection
        --killall -K              Kill all PAN connections
        --role -r <role>          Local PAN role (PANU, NAP, GN)
        --service -d <role>       Remote PAN service (PANU, NAP, GN)
        --ethernet -e <name>      Network interface name
        --device -i <bdaddr>      Source bdaddr
        --nosdp -D                Disable SDP
        --encrypt -E              Enable encryption
        --secure -S               Secure connection
        --master -M               Become the master of a piconet
        --nodetach -n             Do not become a daemon
        --persist -p[interval]    Persist mode
        --cache -C[valid]         Cache addresses
        --pidfile -P <pidfile>    Create PID file
silverboxy:~#

Do I need 

        # Authentication and Encryption (Security Mode 3)
        auth enable;
        encrypt enable;

in the device section of /etc/bluetooth/hcid.conf?


When I do have them and the --encrypt option for pand on the NAP

rd@silverboxy:~$ ps uaxwww|grep pand|grep -v grep
root     15840  0.0  0.1  1548  536 ?        Ss   23:32   0:00 /usr/bin/pand 
--encrypt --listen --persist --role NAP --pidfile /var/run/pand.pid
rd@silverboxy:~$ 

I still get pinless authentification (or they somehow match, though I tried to 
make them different in all files).

Thanks,
Rainer



Am Samstag, 7. Mai 2005 22:35 schrieb Marcel Holtmann:
> Hi Rainer,
>
> > I have setup a PAN network with a NAP (bluez-utils 2.15/kernel 2.6.7) and
> > a PANU (bluez-utils/kernel-2.6.8). Each has an usb bt dongle and runs
> > Debian sarge. Surprisingly, they seem to ignore any pin configuration. If
> > there is good documentation on this somewhere, I would be happy with a
> > pointer.
> >
> >
> > My assumption is that the PANU provides a PIN and NAP needs to confirm
> > it.
> >
> > My first problem is that I do not understand, where to provide a PIN on
> > the PANU.
>
> start pand with --encrypt on the NAP side. While looking at it, I
> realized that the --auth option is missing. However --encrypt should
> imply --auth by definition of the Bluetooth specification.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: NEC IT Guy Games.
> Get your fingers limbered up and give it your best shot. 4 great events, 4
> opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
> win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

-- 
Rainer Dorsch
Alzentalstr. 28
D-71083 Herrenberg
07032-919495
Icq: 32550367


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
