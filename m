Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <508DDCE7.6030708@globaledgesoft.com>
References: <508D6672.8000009@globaledgesoft.com>
	<CAJdJm_MXB71MTcbrViLh486RtpWpx+a7SDvUPdSj2VdOa1fWvw@mail.gmail.com>
	<CAJdJm_NHaBzobi=k3cMaM-J_3d6R7FCEvfrSJWbkiKxKpjKHWA@mail.gmail.com>
	<508DCE10.40801@globaledgesoft.com>
	<CAJdJm_P=USyDO5op7_7ynOT8Qe7dOifyN=notezK1HGCxOe8bA@mail.gmail.com>
	<508DDCE7.6030708@globaledgesoft.com>
Date: Tue, 30 Oct 2012 10:15:37 -0400
Message-ID: <CAJdJm_PLSAZBc+ef_YXsmQ+VE5aW3aD_CPs3x2Y7gY+8zY19Bw@mail.gmail.com>
Subject: Re: BLE issue: Start_LE_Encryption fails
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Ajay <ajay.kv@globaledgesoft.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ajay,

On Sun, Oct 28, 2012 at 9:33 PM, Ajay <ajay.kv@globaledgesoft.com> wrote:
>  ya , i got your point ,advertiser is informing the remote device  , that it
> is not BR/EDR capable .That is done and device is connecting now.
>         But  still i dont know, how to do le specific pairing and
> start_encryption enable(part of le pairing) . Is there any tool in bluez
> providing LE pairing before connecting the devices (want to try with 2
> ubuntu pc's ).

We use the "simple-agent" script from test/ directory in BlueZ for pairing.

On the slave side run:

test/simple-agent hci0

on the master side, after "hcitool lescan", run:

test/simple-agent hci0 <slave-address>

This should trigger Just Works SMP pairing.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
