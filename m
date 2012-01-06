Return-Path: <cyrus@holtmann.org>
Message-ID: <1325893697.6454.113.camel@aeonflux>
Subject: Re: Bluetooth 2.1 keyboard not sending keypress notifications
From: Marcel Holtmann <marcel@holtmann.org>
To: Scott James Remnant <keybuk@google.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 06 Jan 2012 15:48:17 -0800
In-Reply-To: <CAHZ1yC=3Ecj-4-SAHnD93S7_YVF+f_o__Hb2PYFcaoCs_NDoPw@mail.gmail.com>
References: <CAHZ1yC=3Ecj-4-SAHnD93S7_YVF+f_o__Hb2PYFcaoCs_NDoPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

> Have been testing a Bluetooth 2.1 keyboard, but we don't get any
> keypress notifications from it as the pincode is typed and the Agent's
> DisplayPasskey D-Bus method is never called (with two or three
> arguments).
> 
> Any ideas where to begin debugging this?

first, start with hcidump to see what commands and events are actually
send by the keyboard. And capture the bluetoothd debug output.

And I am pretty sure that a real 2.1 keyboard with Secure Simple Pairing
is not working at all. We never managed to purchase one of these. If you
managed to find one, then let us know where you got it from.

Regards

Marcel


