Return-Path: <cyrus@holtmann.org>
Message-ID: <1409060382.7335.25.camel@pohly-mobl1.fritz.box>
Subject: Suspend + abort session => obexd unusable
From: Patrick Ohly <patrick.ohly@intel.com>
To: Luiz Von Dentz <luiz.von.dentz@intel.com>
Cc: Mateusz Potrola <mateusz.polrola@gmail.com>,
	Bluez <linux-bluetooth@vger.kernel.org>
Date: Tue, 26 Aug 2014 15:39:42 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Luiz!

I noticed a problem in obexd and/or Bluez 5.21 (Debian Testing):

- PullAll from Samsung Galaxy S3
- Suspend
- kill the process who called obexd
- try to pull again from a different process
=> GDBus.Error:org.bluez.obex.Error.Failed: Unable to find service
record

obexd notices that its client died (there is a InterfacesRemoved signal
for the transfer and session path), but the cleanup seems to leave the
device or the local side in an unusable state.

Killing obexd and restarting it makes it possible to access the phone
again.

I've not been able to reproduce this without suspending first.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.



