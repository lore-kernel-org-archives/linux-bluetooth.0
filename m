Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 13 Oct 2015 08:10:55 +1000
Message-ID: <CAPcThSFEfLyb09r_AuyabEuP31Y1+WNjzpDHHcXANWt+4ovPog@mail.gmail.com>
Subject: Device class 0 read from Microsoft Designer Mouse (Bluetooth 4.0)
From: Qingtao Cao <qingtao.cao.au@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Qingtao Cao <qingtao.cao.au@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi community,

Recently I got a Microsoft Designer Mouse which supports bluetooth 4.0
but it doesn't work on Ubuntu 15.04 with bluez4-4.101-0ubuntu25.
Although I can pair with it, I can't connect with it.

I've noticed that the Class value read in relevant DeviceFound message
is 0 (full message in the bottom), and to my surprise there is no
"org.bluez.Input" interface exposed on relevant object created after
pairing therefore I can't invoke the Connect() method on such
interface.

Furthermore, after pairing its object path is contained in the Devices
property of local adapter, but the linkkeys file contains no relevant
entry.

Home come bluez reads class value 0 from this device? does this
attribute to no input interface exported by bluez? how can I better
attack this problem?

Many thanks for any advice.

Cheers,
Harry
