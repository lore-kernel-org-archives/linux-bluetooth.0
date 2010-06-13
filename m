Return-Path: <cyrus@holtmann.org>
From: "Andrew Kohlsmith (mailing lists account)" <aklists@mixdown.ca>
To: linux-bluetooth@vger.kernel.org
Subject: Re: odd cid change in l2cap negotiation
Date: Sun, 13 Jun 2010 19:12:28 -0400
References: <201006131728.36687.aklists@mixdown.ca>
In-Reply-To: <201006131728.36687.aklists@mixdown.ca>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201006131912.28692.aklists@mixdown.ca>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sunday, June 13, 2010 05:28:35 pm Andrew Kohlsmith (mailing lists account) 
wrote:
> I'm working on a small embedded system with its own stack and using BlueZ
> on Ubuntu 9.04 (4.32 according to apt-cache).

I should also note the kernel I'm running, as some discussion on the IRC 
channel indicated that this stuff is actually in the kernel and not bluetoothd.

$ uname -a
Linux office.mixdown.ca 2.6.28-19-generic #61-Ubuntu SMP Wed May 26 23:32:46 UTC 
2010 x86_64 GNU/Linux

-A.
