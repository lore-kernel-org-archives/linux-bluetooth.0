Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Performance of Bluez
From: Marcel Holtmann <marcel@holtmann.org>
To: Richard van Dok <rdok@home.nl>
Cc: bluez-users@lists.sf.net
In-Reply-To: <4322.192.168.127.20.1071611970.squirrel@cp257602-a.dbsch1.nb.home.nl>
References: 
	 <4322.192.168.127.20.1071611970.squirrel@cp257602-a.dbsch1.nb.home.nl>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1071612564.27571.33.camel@pegasus>
Mime-Version: 1.0
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
Date: Tue, 16 Dec 2003 23:09:24 +0100

Hi Richard,

> I'm writing this mail because I have a question about the Bluez bluetoo=
th
> stack on Linux Redhat 7.3 (on a Clarkconnect box, in fact). I recently
> installed the software using the information found here:
> http://www.harbaum.org/till/palm/bluetooth/index.html
>=20
> First: everything works! It's great, I can even use MobileTS on a Sony
> Cli=E9 with PalmOS to take over the screen of windows systems. This was=
n't
> possible before, when the bluetooth stack was running on my Xp system.
>=20
> One question remains: the throughput of the Bluez stack is less than ha=
lf
> the amount I got under Windows. This might be due to an error I constan=
tly
> get in /var/log/messages when connected over Bluetooth. It states:
> rfcomm_send_data: Flow stopped, to credits (0) on DLCI 4, returning <va=
lue>
> <value> differs. Often seen values are 0, 328, 984, 656, 1312 and so on.

you should have said that you are using rfcommd. This software part of
BlueZ is deprecated and replaced with a kernel implementation of the
RFCOMM protocol. In conjunction with dund it should work perfect for
you. However you might have to update your kernel. See my patches for
more details.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
