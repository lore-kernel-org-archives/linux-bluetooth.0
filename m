Return-Path: <stephen@networkplumber.org>
Date: Thu, 6 Apr 2017 17:19:41 -0400
From: Stephen Hemminger <stephen@networkplumber.org>
To: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Fw: [Bug 195269] New: Bluetooth - 6lowpan -- RFC7668 vs. draft -
 IPv6 addressing
Message-ID: <20170406171941.2fe9e3d0@plumbers-lap.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

Any bugzilla entries networking related ends up (forwarding to MAINTAINERS)

Begin forwarded message:

Date: Thu, 06 Apr 2017 11:37:40 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: stephen@networkplumber.org
Subject: [Bug 195269] New: Bluetooth - 6lowpan -- RFC7668 vs. draft - IPv6 addressing


https://bugzilla.kernel.org/show_bug.cgi?id=195269

            Bug ID: 195269
           Summary: Bluetooth - 6lowpan -- RFC7668 vs. draft - IPv6
                    addressing
           Product: Networking
           Version: 2.5
    Kernel Version: 4.9.0-2-amd64 (Debian)
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: aignerb@technikum-wien.at
        Regression: No

Dear all,

my first bug report (hopefully :-)) for the Kernel ^^

Citing 6lowpan.c:675:

/* Universal/local bit set, BT 6lowpan draft ch. 3.2.1 */

If the address is identified as a public address, the original address byte
get's a set bit at 2^1.
Otherwise, it will be deleted.
so far, so good. That works well, BUT:


the current RFC7668 does NOT state anything like that. Neither in ch. 3.2.1 or
any other chapters I looked through.


Please tell me, am I wrong or is this a non-conform implementation?


Anyway, thank you very much for this rock-stable piece of software :-)

Best wishes, Benjamin

-- 
You are receiving this mail because:
You are the assignee for the bug.
