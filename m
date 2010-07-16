Return-Path: <cyrus@holtmann.org>
Message-ID: <4C40AF95.4080505@gmail.com>
Date: Fri, 16 Jul 2010 15:14:29 -0400
From: Tim Bennett <tjbenne@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Secure Simple Pairing Mode - Setting NoInputNoOutput mode
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Is there a method (programmatic or hciconfig - type) to change the Mode of a
BT v2.1 dongle to require NoInputNoOutput/JustWorks pairing?

I want to make my box (running linux 2.6.30.2 kernel on an arm processor
with Bluez 4.67 and a Broadcom v2.1 dongle) pair with another device in the
"JustWorks" (NoInputNoOutput) mode.

1. The SSP mode seems to default to "Numeric Comparison" mode.  I am trying
to find out how to switch to "Just Works" (NoInputNoOutput mode)
Can someone point me to a command or code that would switch my adapter into
the NoInputNoOutput mode?
Is it something I can configure through hciconfig or through a dbus command?

  2. The man page for hciconfig has the command hciconfig hciX sspmode
[mode].  Is [mode] only valid for 0 or 1?

In looking in hciconfig.c, at the
hci_read_simple_pairing_mode/hci_write_simple_pairing_mode functions, there
is no clear indication as to what the accepted values are for [mode}

Tim Bennett

