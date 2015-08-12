Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACjvawmEeUSjJNSmvZE=tFFUtOUPBAdweLLf+R9KeUgN1PB_rA@mail.gmail.com>
References: <CACjvawmBmmMfaQZSZLOxWz1dJt2_B-QkF=oTZ8-VLYqKsCi6Qg@mail.gmail.com>
	<CACjvawkPj2uZz+pWUJaofumq8CBadVs5WM5ig3Jy+o4+DGX2eA@mail.gmail.com>
	<CACjvawmEeUSjJNSmvZE=tFFUtOUPBAdweLLf+R9KeUgN1PB_rA@mail.gmail.com>
Date: Wed, 12 Aug 2015 18:14:30 +0600
Message-ID: <CACjvawmWdvVtj2q4Gn69bBT=8C+ZY4EqY2PC_RJwmc3xZNNszw@mail.gmail.com>
Subject: Inconsistent behavior while getting manufacture data through dbus-api
From: Nazmul Alam <fadedreamz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello everybody.
I am seeing inconsistent behavior while fetching manufacture data
through dbus-api.

I have a mobile device reporting adv data and scan response. Both
having manufacture data. which I am trying to get from another device
running bluez-5.31.

The api is working as expected when I am using ubuntu. I can see
manufacture data from adv data and scan response in an interleaved
manner.

But when I change to raspberry pi I can only see scan response. And
seldom get adv data. After checking the issue with btmgmt, I see that
"find -l" command is reporting eir length of 62 (probably they are
aggregated). But dbus-api is reporting only one manufacture data.

What might be the cause of this inconsistency? Also is there any way
to make bluez to not aggregate those two into a single eir?

My kernel version for ubuntu is 3.13.0 and 4.1.4 for raspberry pi
(running raspbian).

Thanks in advance.
