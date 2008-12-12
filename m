Return-Path: <cyrus@holtmann.org>
Date: Fri, 12 Dec 2008 13:20:44 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: linux-bluetooth@vger.kernel.org
Subject: doing hcitool name [addr] while a hcitool inq is running
Message-ID: <20081212122043.GC19659@vanheusden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Am I right that one cannot do a
	hcitool name 00:11:22:33:44:55
while a
	hcitool inq
is running on the same bluetooth device?


Folkert van Heusden

-- 
MultiTail is a versatile tool for watching logfiles and output of
commands. Filtering, coloring, merging, diff-view, etc.
http://www.vanheusden.com/multitail/
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
