Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: "Gabriel A. Zorrilla" <gabriel@zorrilla.me>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: lescan stops after 10-15 minutes (bluez 5.48)
Date: Mon, 29 Jan 2018 10:16:45 +0100
Message-ID: <5325267.NxmNQnImGX@ix>
In-Reply-To: <CAOwdT4=_T4zXX-S0c5h+siL9Pa2DoNAAFB+fK4gTaPqKnP5N5w@mail.gmail.com>
References: <CAOwdT4=_T4zXX-S0c5h+siL9Pa2DoNAAFB+fK4gTaPqKnP5N5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gabriel,

On Sunday, 28 January 2018 20:22:47 CET Gabriel A. Zorrilla wrote:
> Hello there. I'm really desperate here. I'm trying to work with BLE in
> my Pi3. When i do:
> 
> sudo hcitools lescan (with or without -duplicates) the Pi scans
> normally then stops after about 10-15 minutes.
> 
> Here I made some btmon dumps:
> without duplicates: http://termbin.com/ox3z
> with duplicates: http://termbin.com/6nnn
> 
> * Pi3
> * Raspbian with 4.9.66-v7+ kernel.
> * Embedded bluetooth.
> * Compilled bluez 5.48
> 
> Don't know what extra info you would need to diagnose this. Perhaps
> it's a common bug in the Pi3 Raspbian distro, but cant find
> information about this on the web. Been googling for a week.
> 
> I really want to make this work, so dont hesitate in asking me some
> tests and such.
> 
> Thanks and regards,

You don't want to mix using HCI directly and bluetoothd. Bluetoothd will 
interfere with you accessing controller and this is most likely what you are 
seeing.

Is there a reason for you to use hcitool lescan instead of D-Bus APIs?

-- 
pozdrawiam
Szymon Janc


