Return-Path: <cyrus@holtmann.org>
Message-ID: <1408961443.27910.149.camel@pohly-mobl1.fritz.box>
Subject: org.bluez.obex.Transfer1 Suspend/Resume in queued state
From: Patrick Ohly <patrick.ohly@intel.com>
To: Luiz Von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mateusz Potrola <mateusz.polrola@gmail.com>
Date: Mon, 25 Aug 2014 12:10:43 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello!

When testing support for Suspend/Resume in SyncEvolution's PBAP backend
I ran into a situation that is not handled well at the moment:

     1. PullAll creates a new transfer and queues it.
     2. Suspend is called while the transfer is not running yet ->
        "GDBus.Error:org.bluez.obex.Error.NotInProgress: Not in
        progress"
     3. When ready, the transfer runs (untested; at the moment,
        SyncEvolution cancels the transfer when receiving the error).

The only way how SyncEvolution can suspend in this case is to catch the
error, wait for the "active" Status and retry to suspend. This is
sub-optimal (besides being more complex) because the whole point of the
suspend is to not interfere with other activities until the transfer
gets resumed again.

Would it be possible to get rid of the NotInProgress error during Status
= "queued", for example by keeping the transfer in the queued state
until it gets resumed?

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.



