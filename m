Return-Path: <cyrus@holtmann.org>
Message-ID: <236059.54740.qm@web52607.mail.re2.yahoo.com>
Date: Wed, 24 Feb 2010 13:50:04 -0800 (PST)
From: Ed Tsang <netdesign_98@yahoo.com>
Subject: obexd 0.14  "put" file corruption
To: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, 
I am using obexd 0.14 to push files into phone. The image file received by some phone seem a bit strange and in some phone it could not be display at all. So I tried a simple text file with line number as text. Then I saw the file received from the phone is corrupted. Looking into the hcidump look like the second "Put cmd" and forward, the first "0xc8" bytes was not copied (stay the same as the firs put cmd).
  Anyone know if this is a known problem in 0.14 or fixed in the latest (obexd 0.20).

Thanks,
Ed



      __________________________________________________________________
Get the name you've always wanted @ymail.com or @rocketmail.com! Go to http://ca.promos.yahoo.com/jacko/

