Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
From: Bernd Porr <mail@berndporr.me.uk>
Subject: rfcomm stability problems
Message-ID: <c2eb7579-71de-f8bb-cbe7-4537d25aaa47@berndporr.me.uk>
Date: Fri, 12 Aug 2016 08:58:51 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I've upgraded recently to UBUNTU LTS xenial and since then the rfcomm 
has been working very unreliable up to complete kernel crashes with 
freezes. My testing results are here:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1611532

That happens with all kernels from 4.4 up to the development kernel. It 
worked fine with the stock ubuntu kernels of precise.

I'd be happy to do a bit of kernel debugging if somebody can point me to 
possible reasons and/or major changes from the 3.x kernel.

Best,
/Bernd
-- 
http://www.berndporr.me.uk
http://www.linux-usb-daq.co.uk
http://www.imdb.com/name/nm3293421/
+44 (0)7840 340069
