Return-Path: <cyrus@holtmann.org>
Message-ID: <131634.48135.qm@web56506.mail.re3.yahoo.com>
Date: Mon, 23 Aug 2010 00:22:06 -0700 (PDT)
From: Shreesh Holla <hshreesh@yahoo.com>
Subject: [RFCOMM] Cannot complete connections into Ubuntu
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm running Ubuntu with 2.6.32.24 kernel.
I have a simple RFCOMM program running on Windows Mobile which would connect 
into the Ubuntu machine. Of course I have the corresponding service running on 
the Ubuntu machine. The RFCOMM port numbers do match up.

This was working a few days back and now with no changes(i.e. the same 
executable), it refuses to work anymore.

So is there some configuration needed  now?

I have the dongle running in Ubuntu as : hciconfig hci0 noauth noencrypt pscan

Thanks,
Shreesh

