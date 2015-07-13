Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Mike Purvis <mpurvis@clearpathrobotics.com>
Date: Mon, 13 Jul 2015 12:43:24 -0400
Message-ID: <CACsJT9N+saPgDKjXFGkr7fn=M=8s_h2fTSmPCznwahC7f6eeOQ@mail.gmail.com>
Subject: UsermodeHID uncertainty
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I'm struggling to understand what the UsermodeHID option in BlueZ
does, and I'm not finding a good source of documentation on it. I
understand that using this option has the kernel pass raw HID traffic
to a usermode process for interpretation, rather than doing this
directly in the kernel, and this has advantages as far as
debuggability, pluggability, fault isolation, etc.

However, my questions—

- What is the usermode process? Do I have to start it somehow, or does
it start on its own? Is it an already running daemon?
- What is the communication channel between the kernel and user
process, and how can I listen in on the traffic?
- Is the usermode process directly managing things like devfs nodes
(eg, /dev/input/js0), or does it communicate back to the kernel for
that?
- As a user, what are my options for swapping out the usermode process
if I want to modify its behaviour? For example, handling disconnects
or pairing in a different manner than the default?

Thanks for any pointers or thoughts,

Mike
