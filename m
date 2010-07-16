Return-Path: <cyrus@holtmann.org>
Date: Fri, 16 Jul 2010 20:37:15 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Tim Bennett <tjbenne@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Secure Simple Pairing Mode - Setting NoInputNoOutput mode
Message-ID: <20100716233715.GA24138@jh-x301>
References: <4C40AF95.4080505@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4C40AF95.4080505@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tim,

On Fri, Jul 16, 2010, Tim Bennett wrote:
> Is there a method (programmatic or hciconfig - type) to change the Mode of a
> BT v2.1 dongle to require NoInputNoOutput/JustWorks pairing?
> 
> I want to make my box (running linux 2.6.30.2 kernel on an arm processor
> with Bluez 4.67 and a Broadcom v2.1 dongle) pair with another device in the
> "JustWorks" (NoInputNoOutput) mode.
> 
> 1. The SSP mode seems to default to "Numeric Comparison" mode.  I am trying
> to find out how to switch to "Just Works" (NoInputNoOutput mode)
> Can someone point me to a command or code that would switch my adapter into
> the NoInputNoOutput mode?
> Is it something I can configure through hciconfig or through a dbus command?
> 
>  2. The man page for hciconfig has the command hciconfig hciX sspmode
> [mode].  Is [mode] only valid for 0 or 1?
> 
> In looking in hciconfig.c, at the
> hci_read_simple_pairing_mode/hci_write_simple_pairing_mode functions, there
> is no clear indication as to what the accepted values are for [mode}

You're looking a bit in the wrong place. What you want is an agent that
registers "NoInputNoOutput" as its IO capability. You could e.g.
experiment by using test/simple-agent. Find the two places in it that
say "DisplayYesNo" and change them to "NoInputNoOutput". Then you can
use that script as a "just works" pairing initator or acceptor.

Johan
