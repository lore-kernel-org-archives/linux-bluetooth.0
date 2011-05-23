Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4DDA5E2F.6070701@ethicstech.in>
References: <4DDA5E2F.6070701@ethicstech.in>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Date: Mon, 23 May 2011 15:38:10 +0200
Message-ID: <BANLkTikWghLCzyZCCVVubSLdd4E3aFRqYg@mail.gmail.com>
Subject: Re: Is the BlueZ health device interface, problems with link security
 level is rectified
To: Siva kumar <sivakumar@ethicstech.in>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2011/5/23 Siva kumar <sivakumar@ethicstech.in>:
> Hi all,
>
>      Is the BlueZ health device interface, problems with link security level
> is rectified after applying the patch in HDP.C. i am trying to pair health
> device in bluez with ssp pairing , i am not able to get data. Only by
> disabling ssp mode i can get data with "hciconfig hci0 sspmode 0". Is there
> any bug in Health Device Profile of bluez
>
>

What kernel version are you using? There were problems with some old
versions of the kernel and ssp.

Regards
