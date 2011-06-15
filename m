Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110615052705.GA19107@dell.ger.corp.intel.com>
References: <BANLkTimNS+gno8aEK-pFotbWyZt9sGHRUA@mail.gmail.com>
	<BANLkTimr_hUn9iWy-=es=afDzBgS2UUcpQ@mail.gmail.com>
	<20110615052705.GA19107@dell.ger.corp.intel.com>
Date: Wed, 15 Jun 2011 11:53:00 -0400
Message-ID: <BANLkTik+xsPcDAk5ejUo0NX77bPJfuV7_Q@mail.gmail.com>
Subject: Re: Support for receiving RFCOMM connections without pairing
From: =?ISO-8859-1?Q?Andr=E9?= <teste@cabine.org>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jun 15, 2011 at 1:27 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> I'm trying but bluetoothd is always asking for an agent, for pairing
>> it seems. Can we just disable security/pairing?
>
> If both your Android device and your Debian system have Bluetooth 2.1 or
> newer controllers pairing is mandated by the Bluetooth specification for
> everything else except service discovery. If your Debian system has a
> 2.0 or older Bluetooth controller all that's needed is to set the
> security level for the server socket you're trying to connect to to low.
>
> FWIW, it's possible to forcibly downgrade even a 2.1 system to a 2.0 one
> as far as pairing is concerned by issuing the command
> "hciconfig hci0 sspmode 0".

Thanks for the help! It worked.

Best regards,
André
