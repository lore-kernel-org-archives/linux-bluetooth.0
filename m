Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 Jan 2010 09:23:50 +0100
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: need understanding about bt
Message-ID: <20100106092350.47ba4a63@strolchi.home.s3e.de>
In-Reply-To: <201001051910.08204.gene.heskett@verizon.net>
References: <201001051910.08204.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gene,

(didn't we have a similar thread ~half a year ago?)

On Tue, 05 Jan 2010 19:10:08 -0500
Gene Heskett <gene.heskett@verizon.net> wrote:

> So, how do I reliably get this /dev/rfcomm0 device created?  Running kernels 
> in the 2.6.32.x range here.

You can either use the rfcomm utility, see "rfcomm -h", or use the
test-serial script from bluez-test (if it is packaged for your distro,
otherwise it lives in the bluez source in test/test-serial) which is
the preferred method nowadays IIUC and which works for me:

seife@strolchi:~> test-serial 00:24:EF:D1:B3:23
Connected /dev/rfcomm0 to 00:24:EF:D1:B3:23
Press CTRL-C to disconnect

then, in another terminal, I can send AT commands to my phone
via /dev/rfcomm0.

Note that the test-serial has a fixed timeout of 1000 seconds and will
close the link afterwards, but that should be trivial to hack out of
the script.

If you want to use the old-fashioned style, I had written some
documentation about that in a former life. It's still available through
http://en.opensuse.org/Bluetooth/rfcomm (it's not SUSE-specific at all,
if anything, you might need to put a call to "rfcomm bind all" into a
late-running init script for your distro).

Hope this helps and Good Luck :-)

	seife

-- 
Stefan Seyfried

"Any ideas, John?"
"Well, surrounding them's out."
