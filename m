Return-Path: <cyrus@holtmann.org>
Message-ID: <557BB36C.3010408@gmail.com>
Date: Sat, 13 Jun 2015 06:37:00 +0200
From: Florian Grandel <fgrandel@gmail.com>
MIME-Version: 1.0
To: Arman Uguray <armansito@chromium.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Multi-adv patchset assumptions
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi guys,

as you can see, I now finished the patch set that provides the full 
multi-adv feature for you to review and try out.

I made a few minor extra assumptions about multi-adv implementation 
details that IMO had not yet been specified in mgmt-api.txt and 
hopefully do not break backwards compatibility, notably:

- I arbitrarily set the default duration to 2 secs. This can of course
   be set to any other value you prefer.

- Switching the LE setting off permanently disables and removes all
   advertising instances - even if the device remains powered.

- Adding an instance while another instance is being advertised will
   wait for the new instance's scheduled time to first advertise that
   instance i.e. it may be that one or more other instances will have
   their turn first (FIFO). If the currently advertised instance is being
   changed, though, then that instance will be updated immediately.

- Removing an advertising instance that is currently being advertised
   will cancel the instance right away and not wait for it to time out.
   If there are other remaining advertising instances, then those will
   go on to advertise instead.

- After service discovery or after "set advertising off", instance
   advertising should re-enter its prior advertising state, i.e.
   advertise the same instance that has been advertised before, if any.

- Whenever an advertising instance is canceled prematurely (set adv,
   service discovery, etc.) only the remaining duration of the current
   advertising slot is "lost". The instance will not be deleted and the
   remaining advertising time (up to the overall timeout) will be
   advertised as soon as instance advertising is being re-enabled.

Most of these assumptions have been documented in mgmt-api.txt, too. You 
can look at the diff there for easier review.

Florian
