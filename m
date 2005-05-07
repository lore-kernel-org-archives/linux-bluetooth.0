Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] pand seem to ignore any pin configurations
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <200505072339.13643.rdorsch@web.de>
References: <200505072203.45598.rdorsch@web.de>
	 <1115498144.9031.19.camel@pegasus>  <200505072339.13643.rdorsch@web.de>
Content-Type: text/plain
Message-Id: <1115503367.9031.31.camel@pegasus>
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
Date: Sun, 08 May 2005 00:02:47 +0200

Hi Rainer,

> thanks for the quick reply. Where would I specify the PIN on the PANU? Should 
> pin_helper in hcid.conf provide this? Where would I specify the PIN on the 
> NAP?

if you use "security user" then the PIN is provided through the PIN
helper script.

> There is no --auth for pand:

You read my answer, do you? I said that I realized that it is missing
and that you should use --encrypt instead. It is fixed in the CVS.

> Do I need 
> 
>         # Authentication and Encryption (Security Mode 3)
>         auth enable;
>         encrypt enable;
> 
> in the device section of /etc/bluetooth/hcid.conf?

If you know what security mode 3 means, feel free to use it otherwise
you might wanna look into the Bluetooth specification first. And btw
there is a reason why it is commented out ;)

> When I do have them and the --encrypt option for pand on the NAP
> 
> rd@silverboxy:~$ ps uaxwww|grep pand|grep -v grep
> root     15840  0.0  0.1  1548  536 ?        Ss   23:32   0:00 /usr/bin/pand 
> --encrypt --listen --persist --role NAP --pidfile /var/run/pand.pid
> rd@silverboxy:~$ 
> 
> I still get pinless authentification (or they somehow match, though I tried to 
> make them different in all files).

Check with "hcidump -X -V" is you are not already paired and both sides
only authenticate with a link key. You can also use "hcitool auth" do
trigger the authentication by hand.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
