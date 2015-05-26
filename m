Return-Path: <cyrus@holtmann.org>
Message-ID: <5563C8E5.3010008@gmail.com>
Date: Tue, 26 May 2015 03:14:13 +0200
From: Florian Grandel <fgrandel@gmail.com>
MIME-Version: 1.0
To: Arman Uguray <armansito@chromium.org>,
 Johan Hedberg <johan.hedberg@gmail.com>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>
Subject: Test coverage for "add advertising" - timeouts, missing tests
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman and Johan,

Marcel would like to see a test that covers an advertising instance 
timeout to further reduce the potential for regressions caused by the 
multi-advertising changes.

I may be mistaken but I think we do not have such a test in mgmt-tester, 
yet.

(We do have tests that set a timeout in an add advertising call but the 
timeout will not expire as the delayed work is canceled. This is 
intended behavior - just not the test I would have to write.)

Today, Arman and I quickly discussed the possibility to test timeouts 
and we first thought that the tester would support it. But then I 
couldn't really find a hook to do so.

So now I'm left with a few questions:
- Did I overlook the hook to test timeouts?
- If not: Should we introduce one?
- If so: Is there a way to "simulate" the timeout in a way that doesn't 
require us to actually wait for a second or even more? Otherwise timeout 
tests would considerably slow down test execution.

And somewhat related a different problem that I encountered today:
- Is there a way to test that a given event is NOT being triggered by a 
test case? Maybe there's a way to find out when no more events can be 
expected so that we don't have to wait - which would considerably slow 
down tests again and would not be reliable anyway?

Thanks for your help!

Florian
