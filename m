Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Andrei Pislaras <pislaras.andrei@gmail.com>
Date: Thu, 9 Jun 2016 10:32:43 +0300
Message-ID: <CAN2EJERy-4EOL7YJqE6XvQu+1uc4GzcvtyPDjZ-ss2L2hYoFKA@mail.gmail.com>
Subject: BlueZ test coverage - how to test?
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I am trying to understand how was obtained the results from
test-coverage.txt file. I have run mgmt-tester, sco-tester,
hci-tester; some tests passed, some tests not run.

For example:(hci-tester)
Test Summary
------------
Reset                                             Not Run
Read Local Version Information        Not Run
Read Local Supported Commands    Not Run

I will like to know how to understand these tests, should I have some
preconditions? In the c files I saw some PTS test id, should I use PTS
tool?
How to run test-hfp, test-mgmt ?

I have used BlueZ 5.37.

----------------
Thank you!
Andrei
----------------
