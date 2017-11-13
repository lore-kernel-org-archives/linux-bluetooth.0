Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 13 Nov 2017 13:37:39 +0100
From: Konrad Zapalowicz <konrad.zapalowicz@canonical.com>
To: Thomas Green <TGreen2@Sorenson.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: porting from bluez4
Message-ID: <20171113123739.GF13231@annapurna>
References: <C2BC44D770753C45AAAC42695FB5BE020125718348@SLC-EXMB01.CORP.SRELAY.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C2BC44D770753C45AAAC42695FB5BE020125718348@SLC-EXMB01.CORP.SRELAY.COM>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 11/10, Thomas Green wrote:
> All,
> 
> I'm porting our company's application from bluez4 to bluez5.  I'm currently using bluez5.42  (I'm nervous about using higher than that because I've had to backport many kernel changes to support this recent version (what else do I need to backport?)).  I have most things working, but there are two issues I've not yet been able to resolve.  The first is devices reconnecting when they come back into range.  For example, I am testing with a Jawbone from Jambox.  When coming back into range (or powering back on), I watch it attempt to connect, and it fails.  If I have bluetoothctl up I see the status change from connected to unconnected about three or four times before the Jambox quits trying and powers back down.   I have a BTLE keyboard that comes back into range and will not connect until I hit a key and the connection happens.   I have other BTLE devices that attempt to reconnect, but fail as well.

If you would like to stay around 5.42 I would suggest going for 5.43
instead as this is a mostly bug fix release over 5.42.

As for the re-connection issues the best would be to capture HCI traces
using btmon and analyze them to know why the connection attempt is denied.

Best,
K

> 
> The second issue is that of  headset devices.  In Bluez4 there was a headset 'profile' and the IndicateCall method that could be invoked.  In bluez5 there is the Alert1 interface with the NewAlert call, but it is deprecated code, so what should I be using?  As a matter of interest, if I try to use the NewAlert method what is the proper use?  I've tried:
> 
> root# dbus-send --print-reply --system --dest=org.bluez --type=method_call /org/bluez org.bluez.Alert1.NewAlert string:"ringer" uint16:1 string:"active"
> Error org.bluez.Error.InvalidArguments: Invalid arguments in method call
> 
> TIA,
> 
> Tom
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
