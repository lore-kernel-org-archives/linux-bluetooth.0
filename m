Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 28 Feb 2013 11:51:58 -0800
Message-ID: <CAHZ1yC=FkUt=ESbZ+OnfSXKrN0+XHVgcMxqOjQq-EaJU+TPf-w@mail.gmail.com>
Subject: Bluez 5.2 A2DP: "Unable to select SEP"
From: Scott James Remnant <keybuk@google.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey,

I'm having some difficulties connecting up A2DP in BlueZ 5.2, and I'm
sure I'm just missing something obvious so would appreciate a second
set of eyes.

I had thought that to send to an A2DP Sink on a device, I needed an
A2DP Source endpoint at my end, but when I try and register that
endpoint I just get org.bluez.Error.NotSupported

I can register an A2DP Sink endpoint no problem, but then when I call
org.bluez.Device1.Connect the connection fails with "Unable to select
SEP" in the logs.

Any ideas?

Scott
--
Scott James Remnant | Chrome OS Systems | keybuk@google.com | Google
