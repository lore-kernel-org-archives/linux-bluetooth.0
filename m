Return-Path: <cyrus@holtmann.org>
Message-ID: <1391410350.91187.YahooMailNeo@web160602.mail.bf1.yahoo.com>
Date: Sun, 2 Feb 2014 22:52:30 -0800 (PST)
From: Serkan Kaba <serkan_kaba@yahoo.com>
Reply-To: Serkan Kaba <serkan_kaba@yahoo.com>
Subject: AVRCP profile/plugin in bluez 5
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I was trying to get my GTK-N1BT hi-fi system. It was constantly bailing "UUIDs has unsupported type" errors and disconnecting after the pairing. All the online examples were referring to bluez 4 config (audio.conf) which even in 4 it was hard to get it working. I added the following in "General" section of audio.conf
<code>
Enable=Media,Sink,Source

</code>
and got it working

I couldn't figure out enabling avrcp profile with bluez 5. Please help
