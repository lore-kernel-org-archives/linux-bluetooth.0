Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 26 Dec 2015 18:18:57 +0300
Message-ID: <CAMib2GZCAOHfBv=SZrVWaPEHZV6WDkoct03TPqtjyvAcHwoeqQ@mail.gmail.com>
Subject: How to bind any linux media player to simple-player script?
From: Kyle Shneider <shneiderkyle@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'm testing a2dp profile. bluetoothd gets commands from connected
device, but there are no audio.
As i get it, reading code of simple-player, you should either pass
actual player's path as argument of simple-player script of change
hardcoded /test/player to actual player's path... something like that,
correct me if i'm wrong. Binded player should have mpris interface,
like /org/mpris/MediaPlayer2/rhythmbox
But all linux players use session bus, and in our case we work with
org.bluez on system bus. So how to properly bind any linux media
player to simple-player script.

-- 
Kyle Shneider
