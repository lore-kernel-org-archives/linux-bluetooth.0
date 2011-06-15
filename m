Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Jun 2011 08:27:05 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Andr=E9?= <teste@cabine.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Support for receiving RFCOMM connections without pairing
Message-ID: <20110615052705.GA19107@dell.ger.corp.intel.com>
References: <BANLkTimNS+gno8aEK-pFotbWyZt9sGHRUA@mail.gmail.com>
 <BANLkTimr_hUn9iWy-=es=afDzBgS2UUcpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <BANLkTimr_hUn9iWy-=es=afDzBgS2UUcpQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi André,

On Tue, Jun 14, 2011, André wrote:
> I'm trying to use the new Android API to create a RFCOMM socket
> without the need for a previous pairing:
> 
> http://developer.android.com/reference/android/bluetooth/BluetoothDevice.html#createInsecureRfcommSocketToServiceRecord%28java.util.UUID%29
> 
> Is it possible to accept these connections on a Debian linux system?
> I'm trying but bluetoothd is always asking for an agent, for pairing
> it seems. Can we just disable security/pairing?

If both your Android device and your Debian system have Bluetooth 2.1 or
newer controllers pairing is mandated by the Bluetooth specification for
everything else except service discovery. If your Debian system has a
2.0 or older Bluetooth controller all that's needed is to set the
security level for the server socket you're trying to connect to to low.

FWIW, it's possible to forcibly downgrade even a 2.1 system to a 2.0 one
as far as pairing is concerned by issuing the command
"hciconfig hci0 sspmode 0".

Johan
