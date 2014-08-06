Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Reply-To: mvogt1@gmail.com
Date: Wed, 6 Aug 2014 12:27:07 +0200
Message-ID: <CAOE8yMCnd+1RGM+wLLDMHaBBakAdbPANtK5f8H-QOVTJnUhBAA@mail.gmail.com>
Subject: Bug?: 14KB/s throughput with Asus BT-400 (BCM20702A0)
From: Martin Vogt <mvogt1@gmail.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I have two ASUS BT-400 bluetooth adapter (chip: BCM20702A0) and
did some benchmarking.

The benchmarks is a simple Server->Client RfComm application,
which prints the throughput in KB/s.

When using the BT-400 adapter as a sender and a "speedlink"
(CSR8510 Nanosira M2272) as receiver I get around 140 Kb/s,
which is fine, and the maximum throughput I ever get in Bluetooth.

When I replace the "speedlink" with the BT-400 the throughput falls
back to 14 KB/s, which is very/unusable slow and looks like a bug.

This happens on Ubuntu 13.10 (3.11.0-20) and 14.04 (3.13.0-32-generic).

If I replace the BT-400 on the sender side with the "speedlink"
the throughput stays the same with 14 KB/s.

==> Thus the BT-400 adapter is only slow on the receiver side.

regards,

Martin
