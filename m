Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Jan 2010 13:04:31 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: nirav rabara <niravrabara@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Unable to get AT+CKPD=200 (key press command )
Message-ID: <20100118110431.GA7547@jh-x301>
References: <912bb79a1001180205y18dee28dj628d0187f90e4ceb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <912bb79a1001180205y18dee28dj628d0187f90e4ceb@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Jan 18, 2010, nirav rabara wrote:
> I am connection HS by using "Connect" DBUS API of headset interface, I
> am able to connect with device, but when I press key single time on HS
> it's not showing AT+CKPD=200 (I kept debugg in source).
> 
> But when I press HS key two times it show me,
> 
> bluetoothd[815]: Received AT+BLDN
> bluetoothd[815]: Telephone indicator "callsetup" 0 -> 2
> bluetoothd[815]: Telephone indicator "callsetup" 2 -> 3
> 
> and then when I press HS key single time it show following,
> 
> bluetoothd[815]: Received AT+CHUP
> bluetoothd[815]: Telephone indicator "callsetup" 3 -> 0
> bluetoothd[815]: Received AT+BTRH?
> 
> But I am not able to get AT+CKPD=200, It would be really appreciable
> if somebody guide/suggest me what should I do to get AT+CKPD=200 when
> connected through API "Connect" on DBUS.

AT+CKPD=200 is a feature of the Headset Profile (HSP). It seems like
you're connected using the Handsfree Profile (HFP) which would explain
why you are not getting AT+CKPD=200. You can toggle BlueZ HFP support
through /etc/bluetooth/audio.conf.

Johan
