Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 14 Sep 2009 12:57:44 +0530
Message-ID: <6887eb5d0909140027i81c90blf82b20f519f8d2f7@mail.gmail.com>
Subject: hci_get_route returns ENODEV
From: Kartikey Parmar <kartikey2781@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear friends,

I m calling hci_get_route(NULL) to get bluetooth USB adapter information.
It returns ENODEV. I tried to trace it, in function hci_for_each_dev()
it fails in hci_test_bit() function and hence can't get dev_id any
value assigned.

Same application runs nicely on my linux desktop PC, the issue is with
ARM linux platform (linux-2.6.30 & bluez-4.52).
-- 
Kartikey Parmar
R&D Software Engg
Matrix Telecom Pvt Ltd
Baroda, Gujarat (India)
09879095390 (M)
