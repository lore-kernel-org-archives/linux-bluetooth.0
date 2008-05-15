Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <320370.69822.qm@web81301.mail.mud.yahoo.com>
References: <320370.69822.qm@web81301.mail.mud.yahoo.com>
Date: Thu, 15 May 2008 11:50:32 +0200
Message-Id: <1210845032.7025.44.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Losing SCO connection
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Michael,

> I wrote a little app that tries to support the hands-free (HF) profile but I am having trouble keeping the SCO connection alive.  Using an RFCOMM connection, I am able to establish the HF Service Level Connection per HF Profile specification and then create an SCO connection to a mobile phone.  But SCO seems to get disconnected by the phone after about 40-50msec of bidirectional voice data.  I can reconnect SCO but the phone disconnects it again.  Once in a while, this problem doesn't occur and SCO stays alive.  When this happens, I can tear down and bring up the HF setup repeatedly without any problem unless I power cycle the phone or the linux machine.  I would like to make it work on consistent basis.
> Please note that I am using the bluez lib only. I am not relying on the "services" utilities in the bluez-util package (I turned them all off).  Also, my SDP setup code seems to operate okay (i.e. output of "sdptool browse local" looks fine)
> Setup:
>     - Fedora 8 with
>         kernel 2.6.24.4
>         bluez-lib 3.20
>         L2CAP v2.9
>         RFCOMM v1.8
>         SCO v0.5
>     - Bluetooth dongle: Targus with Broadcom 2045    - phone: Nokia 6085
> I have tried another phone and another BT dongle and the problem is still there so I am leaning it's either my code or bluez...

did you try a CSR based dongle? It looks like the remote side is
disconnecting. Maybe it has something to do with your HFP control
channel handling. Can't really tell.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
