Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: <linux-bluetooth@vger.kernel.org>
From: Felix Schulthess <felix.schulthess@scs.ch>
Subject: Finding MTU of current BLE connection
Message-ID: <1a2056c8-7d1b-a209-daab-39abf6cf5db4@scs.ch>
Date: Tue, 30 May 2017 16:53:42 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I am trying to figure out the MTU of a BLE connection while it is
active. If I understand the Core Specification correctly, this can be
accomplished with the "Exchange MTU Request" as specified in Vol. 3,
Part F, Section 3.4.2.

1. I know one can send HCI commands with the hcitool. Is it also
possible to issue the request specified above using any of the existing
hciconfig, hcitool, hciXXX tools to find the MTU?

2. There is a connection of which I know that its MTU is 512. Still,
running 'hciconfig hci0 dev' reports 'ACL MTU: 310:10'. Why is that so?

I use Bluez 5.44 on Debian Linux, Kernel version 4.9.18.

Best, Felix
