Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <ext.szymon.janc@tieto.com>
To: Barry Byford <31baz66@gmail.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Subject: Re: Error 133 (0x85): GATT ERROR
Date: Tue, 09 Feb 2016 10:03:53 +0100
Message-ID: <10106988.mHUPtLp52x@leonov>
In-Reply-To: <CAAu3APbwKOBrWbqjrWJ9oCJ_tzNHau9ne4A36_MQgcbsyB30cQ@mail.gmail.com>
References: <CAAu3APaeS_7xnuTW_JgdJKkAcfY1x4zU=3VxTkSHqEZYsSkY_A@mail.gmail.com> <D2DE79F2.1BDF6%adam.moore@savant.com> <CAAu3APbwKOBrWbqjrWJ9oCJ_tzNHau9ne4A36_MQgcbsyB30cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Barry,

On Tuesday 09 of February 2016 08:00:52 Barry Byford wrote:

 <snip>

> >>According to my phone the code on the Raspberry Pi is advertising with
> >>only the 'LE General Discoverable Mode' flag set. The 'BR/EDR not
> >>Supported' is not set.
> >>I've looked at the DBus API documentation again and it is not obvious
> >>that I can change this setting on the advertisement. Am I missing
> >>something?
> >>
> > Have you tried setting ControllerMode = le in bluez¹s main.conf?  If set,
> > bluetoothd will explicitly enable le and disable br/edr in the kernel via
> > the management interface, and that should set advertising flags
> > appropriately.  There does not appear to be a DBus API, probably because
> > this is more of a static setting.
> 
> Thanks for the suggestion. I've added that setting to the
> /etc/bluetooth/main.conf and when the Raspberry Pi advertises it now
> has the 'BR/EDR Not supported' flag set.
> Now when I try to connect from my phone it fails with the same error
> message on my phone although in the hcidump and bluetoothd logs
> nothing appears when the phone tries to connect.
> 
> Thanks again for the suggestion.

If this is Android phone with 4.0 BT (no 4.1/4.2 features) then you need to 
unpair the device and toggle phone BT off/on. Otherwise Bluedroid stack cache 
info that your device is dual mode and tries to connect over BR/EDR.

-- 
BR
Szymon Janc
