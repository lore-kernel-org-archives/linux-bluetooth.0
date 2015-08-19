Return-Path: <cyrus@holtmann.org>
Message-ID: <55D4834E.9080705@convergeddevices.net>
Date: Wed, 19 Aug 2015 14:23:26 +0100
From: tony <tony.makkiel@convergeddevices.net>
MIME-Version: 1.0
To: <linux-bluetooth@vger.kernel.org>
Subject: SEC SEM BV 09, MITM + No Bonding
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,
            I am going through Bluez 4.101 qualification process and am 
stuck with second part of test case SEC SEM BV 09. The test case needs 
BlueZ to connect to Tester with Authentication requirement 0 (MITM not 
required + No Bonding). Then have to trigger another L2CAP connection 
with Authentication requirement 1 (MITM required + No Bonding).

We managed to get through the first part using l2test
l2test -n -P 1 -E
But the second part always does general bonding (Authentication 
Requirement 5).
l2test -n -S -P 17 -J 2

Can somebody please advise on how to force blueZ to initiate connection 
with authentication requirement 1 (MITM required + No Bonding)? From the 
blueZ code, I noticed it follows lead from the remote device. But 
couldn't find anything obvious when initiating connection.

Many Thanks,
Tony
