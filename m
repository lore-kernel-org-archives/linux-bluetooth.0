Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Thu, 9 Jun 2016 16:39:13 -0400
From: Don Zickus <dzickus@redhat.com>
To: linux-bluetooth@vger.kernel.org
Subject: working bluetooth obex test scripts?
Message-ID: <20160609203913.GI90326@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I was trying to put together some bluetooth obex test scripts to help
continuously verify that interface works reliably on various machines we
have.

However, I am not very successful with the stuff in the test/ directory.

I started by focusing on ftp-client -d <address> -l.  I assume I had to run
the 'simple-obex-agent' on the machine with <address>.

Working around the dbus.SessionBus errors (I am connecting through ssh
instead of the desktop), I get 'Unable to find service record' after
ftp-client creates a session.

I think that is because it isn't connecting the remote agent correctly?

Anyway, pointers for good scripts to run to test the obex interface?

Cheers,
Don

