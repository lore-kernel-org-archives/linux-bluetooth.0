Return-Path: <cyrus@holtmann.org>
Subject: Re: Is it possible to completely turn off encryption
From: Marcel Holtmann <marcel@holtmann.org>
To: netdesign_98@yahoo.com
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <510518.84246.qm@web52608.mail.re2.yahoo.com>
References: <510518.84246.qm@web52608.mail.re2.yahoo.com>
Content-Type: text/plain
Date: Wed, 28 Jan 2009 06:59:04 +0100
Message-Id: <1233122344.18259.22.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> Is it possible to completely turn off the encryption (even if the remote device want it).
>    hciconfig hcio noencrypt  -- seem to turn off our request of encryption
>    But if the remote device request it, we seem to still go through with it.
>  Situtation: when we search the BlackBerry's SDP server, they pop up and ask for pin. They seem to be very secure minded. 
>    hciconfig hcio noencrypt
>    sdptool browse --tree  <BDADDR> 
>        will cause the BlackBerry 7290 to pop up the pairing screen (PIN).
>    hciconfig hci1 feature  
>        shown the dongle (BroadCom chip) support encryption (mandated feature?)
>    There seem no way (e.g. hciconfig hci1 feature set) to fool the other side that we don't have encryption capabilities (not sure if it is "legal" as this might be an mandated feature).

you are confusing authentication with encryption and with the security
mode 3 that most RIM devices are using. Please read up in the Bluetooth
specification what these terms mean and how they work together.

Regards

Marcel


