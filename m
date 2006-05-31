Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d4f1333a0605301946t42f35b76r298e17bf7ffc4b5b@mail.gmail.com>
Date: Tue, 30 May 2006 21:46:26 -0500
From: "Travis H." <solinym@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1148907600.31689.9.camel@localhost>
MIME-Version: 1.0
References: <d4f1333a0605271008q1d86a4d4h865417a889abf0a2@mail.gmail.com>
	<1148907600.31689.9.camel@localhost>
Subject: Re: [Bluez-users] upgrade to FC5 "breaks" my bluetooth - what's
	wrong?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On 5/29/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> You need a dongle with HID proxy mode. A USB keyboard is fully supported
> by any modern BIOS.

Where can I learn about USB, specifically what all these terms mean?
I don't know what HID or HID proxy mode means.

I solved my problem; the MS bluetooth kbd/mse require you to reset
them with the button, scan them with "hcitool scan", then connect to
them.  This worked for me.

-- 
Scientia Est Potentia
Security "guru" for rent or hire - http://www.lightconsulting.com/~travis/ -><-
GPG fingerprint: 9D3F 395A DAC5 5CCC 9066  151D 0A6B 4098 0C55 1484


_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
