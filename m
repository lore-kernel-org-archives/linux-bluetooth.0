Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] hidp and connecting
References: <200405141524.04481.cijoml@volny.cz> <1084556671.25099.201.camel@pegasus>
In-Reply-To: <1084556671.25099.201.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200405142343.04831.cijoml@volny.cz>
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
Date: Fri, 14 May 2004 23:43:04 +0200

On Friday 14 of May 2004 19:44, Marcel Holtmann wrote:
> Hi Michal,
>
> > when hidd is not started and device wants connect, system prints errors
> > about unknown connections.
>
> what kind of errors are you talking about? You must be more specific.

hci_acldata_packet: hci0 ACL packet for unknown connection handle 41
hci_acldata_packet: hci0 ACL packet for unknown connection handle 42
etc...

>
> > 1) Maybe we should have somewhere in /etc/bluetooth list of allowed
> > devices which will be accepted without hidd runnnig?
>
> Why should we accept a device when hidd is not running?

Why not? If kernel knows them via list specified in some config by root, hidd 
should be used only for connecting a new one and killling them.

It reminds me, that --kill option kills connection, but device can reconnect. 
Maybe should be implemented option, which will kill device and it will not be 
allowed to reconnect.

>
> > 2) When hidp and other modules compiled directly into kernel, we should
> > under single mode allow all hid devices to connect without hidd running
> > to allow users maintain their system without any daemons running
>
> This is impossible. If you need this, you have to go with Bluetooth
> dongles that implement HID proxy.

Why? After connecting I can kill hidd and devices works. So if under single 
mode will not be control for bdaddr and unknown connections, it should be 
possible to work too.

>
> Regards
>
> Marcel

Michal


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
