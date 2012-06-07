Return-Path: <cyrus@holtmann.org>
Message-ID: <4FD111EB.8070307@shapeseeker.com>
Date: Thu, 07 Jun 2012 21:41:15 +0100
From: Brian Smith <door@shapeseeker.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Small Patch for scotest.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi there.
Here is a tiny 3-line patch to scotest.c to get it working. (I've been 
trying to get bluez working on a Raspberry Pi, hitting USB problems, 
having a workng scotest is helpful). The problem is that bdaddr never 
gets initialized and tends to have random data in it, preventing the 
client/server end from matching up.

344a345,346
 >       hci_devba(0, &bdaddr);
 >


-- 
Brian Smith.
"The bells of clocktowers stitch the sleeper's dreams together." - Memory Palace

