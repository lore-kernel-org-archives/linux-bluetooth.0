Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: jay@systech.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Bluez 5.49 Segmentation Fault
Date: Thu, 22 Mar 2018 21:04:05 +0100
Message-ID: <3101238.RsEhQVg2kc@ix>
In-Reply-To: <e4a2aaba-6888-6c44-b48d-e954514263b4@systech.com>
References: <e4a2aaba-6888-6c44-b48d-e954514263b4@systech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jay,

On Thursday, 22 March 2018 20:31:23 CET Jay Foster wrote:
> I am experiencing problems with the latest 5.49 version of the bluez
> bluetooth daemon.  Attempting to configure the Discoverable property of
> an adapter causes the bluetoothd to segmentation fault.  This works
> correctly for version 5.48 and earlier.
> 
> The following command demonstrates the bug.
> 
> dbus-send --system --dest=org.bluez --print-reply /org/bluez/hci0
> org.freedesktop.DBus.Properties.Set string:org.bluez.Adapter1
> string:Discoverable variant:boolean:true

I'm not able to reproduce this on 5.49 tag. Could you run bluetoothd under 
valgrind and provide the output?

-- 
pozdrawiam
Szymon Janc


