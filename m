Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 15 Jun 2016 13:00:25 -0400
From: Don Zickus <dzickus@redhat.com>
To: linux-bluetooth@vger.kernel.org
Subject: Debugging bluetoothd, dbus and selinux help?
Message-ID: <20160615170025.GB90326@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am trying to debug why bluetoothd decides to disconnect from the d-bus on
the host, when the client does an object push to an obex agent on the host.

When I set selinux to permissive mode ('setenforce 0'), things work fine (ie
the object push goes through).

I tried searching /var/log/audit/audit.log, journalctl and dbus-monitor for
clues (on the host) and can't find anything obvious.

Does anyone have any tips on how to find what security policy might be
interfering with my test?

Cheers,
Don

