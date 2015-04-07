Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'linux-bluetooth' <linux-bluetooth@vger.kernel.org>
Cc: 'Bharat Bhusan Panda' <bharat.panda@samsung.com>
Subject: Query reagarding unit test-gatt
Date: Tue, 07 Apr 2015 14:00:44 +0530
Message-id: <000301d0710d$273c2130$75b46390$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

I am currently adding test cases for GATT. I am unable to understand the
behavior of the following scenario.

When I execute the following test case,
TP/GAW/CL/BV-08-C  - [Write Characteristic Descriptors - by Client]

bluez$  ./unit/test-gatt -d -p /TP/GAW/CL/BV-08-C

  GATT: > 12 08 00 01 02 03                                ......          
  GATT: < 13

Test Summary
------------
/TP/GAW/CL/BV-08-C                                   Passed       0.002
seconds

Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0

Here I am able to write it successfully. But in service_db_1 declaration,
0x0008 handle is a descriptor with only read permission.
As per its definition, it should return write not permitted error.
Is there any bug in gatt-client procedure or test-gatt or is this the
expected behavior ?


Regards,
Gowtham Anandha Babu

