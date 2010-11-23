Return-Path: <cyrus@holtmann.org>
Message-ID: <4CEB532F.1070804@theforce.com.au>
Date: Tue, 23 Nov 2010 16:37:51 +1100
From: Grahame Jordan <gbj@theforce.com.au>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: sdptool hanging remote
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am using bluez-4.77 on a Gumstix Verdex kernel 2.4.32 patch 21

When I run:
sdptool records 00:80:37:2F:06:08"
from the Workstation Ubuntu 10.04 Bluez-4.6? to the Gumstix the Gumstix 
hangs.
It does not hang completely but is very busy. It hangs for about 20 
seconds and then releases for about 1 second
before it locks up again.

I have tried this on several different Gumstix with the same issue.

Changing workstations from Ubuntu 10.04 to Ubuntu 8.04 does make a 
difference.
 From Ubuntu 8.04 there seems to be no problem. blue-utils 3.26?

Appreciate help


Thanks

Grahame Jordan
