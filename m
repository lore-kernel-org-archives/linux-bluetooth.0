Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTimNS+gno8aEK-pFotbWyZt9sGHRUA@mail.gmail.com>
References: <BANLkTimNS+gno8aEK-pFotbWyZt9sGHRUA@mail.gmail.com>
Date: Tue, 14 Jun 2011 17:31:58 -0400
Message-ID: <BANLkTimr_hUn9iWy-=es=afDzBgS2UUcpQ@mail.gmail.com>
Subject: Support for receiving RFCOMM connections without pairing
From: =?ISO-8859-1?Q?Andr=E9?= <teste@cabine.org>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello.
I'm trying to use the new Android API to create a RFCOMM socket
without the need for a previous pairing:

http://developer.android.com/reference/android/bluetooth/BluetoothDevice.html#createInsecureRfcommSocketToServiceRecord%28java.util.UUID%29

Is it possible to accept these connections on a Debian linux system?
I'm trying but bluetoothd is always asking for an agent, for pairing
it seems. Can we just disable security/pairing?

Best regards,
André
