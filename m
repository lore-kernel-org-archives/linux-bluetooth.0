Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Apr 2012 12:46:40 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Subject: RFC: security level elevation with MGMT
Message-ID: <20120430154640.GB3264@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Everyone,

Security level elevation in a ongoing connection is still a missing
feature when we are running mgmtops. HID uses this for example, to
increase the security when the remote device is a keyboard.

We've been looking to this issue and we came up with two possible
solutions, the first one was a new MGMT Event: Security Changed Event.
This solution might not be good since we would have to notify the change
using a different channel.

A second option would be do this notification in the same socket that
asked the security change, using poll() (with POLLPRI maybe). This
solution looks cleaner, but POLLPRI might not be appropriated for this.

Any comments/suggestions?


	Gustavo
