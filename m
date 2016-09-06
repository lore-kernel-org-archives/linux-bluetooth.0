Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Travis Griggs <travisgriggs@gmail.com>
Content-Type: text/plain; charset=us-ascii
Subject: Query BLE connected status?
Message-Id: <04AC5786-517A-4834-AFD7-B0C6AC29B869@gmail.com>
Date: Tue, 6 Sep 2016 11:20:21 -0700
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Is there a method using the dbus API that one can use to determine if =
there is an active BLE connection or not? I have an ARM Linux board =
setup as a BLE peripheral, and I want another process to behave =
differently based on whether it can determine there is an active =
connection at the moment or not. I could set a timestamp based on when I =
see WriteValue or other ble dbus activity and then timeout on that, but =
I was hoping for something more direct.=
