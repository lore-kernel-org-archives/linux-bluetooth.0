Return-Path: <cyrus@holtmann.org>
Message-ID: <551BD9BD.9040501@message-id.googlemail.com>
Date: Wed, 01 Apr 2015 13:42:53 +0200
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
MIME-Version: 1.0
To: BlueZ devel list <linux-bluetooth@vger.kernel.org>
CC: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: unit/test-gatt broken again (as always :-)
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

in bluez-5.30, the testsuite again does not complete with

MALLOC_CHECK_=3 MALLOC_PERTURB_=69 make check

Valgrind complains about a use-after-free.

I simply bisected the issue, this is the broken commit.

commit 9a0d6d99c79e5cecb76b7a61b53556447f0ccbd1
Author: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Date:   Thu Mar 26 18:29:06 2015 +0530

    unit/test-gatt: Add TP/GAW/CL/BV-05-C test

    Verify that a Generic Attribute Profile client can write a long
    Characteristic Value selected by handle.

This is on plain x86_64, gcc-4.8.3 (old)

Best regards,

	Stefan
-- 
Stefan Seyfried
Linux Consultant & Developer -- GPG Key: 0x731B665B

B1 Systems GmbH
Osterfeldstraße 7 / 85088 Vohburg / http://www.b1-systems.de
GF: Ralph Dehner / Unternehmenssitz: Vohburg / AG: Ingolstadt,HRB 3537
