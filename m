Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: "Gabriel A. Zorrilla" <gabriel@zorrilla.me>
Date: Sun, 28 Jan 2018 16:22:47 -0300
Message-ID: <CAOwdT4=_T4zXX-S0c5h+siL9Pa2DoNAAFB+fK4gTaPqKnP5N5w@mail.gmail.com>
Subject: lescan stops after 10-15 minutes (bluez 5.48)
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello there. I'm really desperate here. I'm trying to work with BLE in
my Pi3. When i do:

sudo hcitools lescan (with or without -duplicates) the Pi scans
normally then stops after about 10-15 minutes.

Here I made some btmon dumps:
without duplicates: http://termbin.com/ox3z
with duplicates: http://termbin.com/6nnn

* Pi3
* Raspbian with 4.9.66-v7+ kernel.
* Embedded bluetooth.
* Compilled bluez 5.48

Don't know what extra info you would need to diagnose this. Perhaps
it's a common bug in the Pi3 Raspbian distro, but cant find
information about this on the web. Been googling for a week.

I really want to make this work, so dont hesitate in asking me some
tests and such.

Thanks and regards,
