Return-Path: <aklish1@urbana.css.mot.com>
Date: Wed, 22 Oct 2003 10:51:03 -0500 (CDT)
From: Aaron Klish <aklish1@urbana.css.mot.com>
To: Aaron Klish <aklish1@wombat.urbana.css.mot.com>
cc: Marcel Holtmann <marcel@holtmann.org>, Aaron Klish <AKLISH1@motorola.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] RFCOMM TTY data loss
In-Reply-To: <Pine.GSO.4.20.0310211432100.10220-200000@wombat.urbana.css.mot.com>
Message-ID: <Pine.GSO.4.20.0310221044310.1278-100000@angel.urbana.css.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,
  Are there any plans in the future to allow control of RFCOMM MTU and credits from user space?
I'm using 2.4.20 (mh9 patch) and these parameters are currently assigned default values in the kernel.
L2CAP already has an option to control MTU through setsockopt.  It seems like adding control
for parameters for RFCOMM would be a good feature - perhaps also through setsockopt?   Any thoughts
on this?  Thanks.

Aaron  

------------
Aaron Klish
Bluetooth Software Engineer
Motorola PCS
PH# (217) 384-8598
FX# (217) 384-8550

[X]  Motorola General Business Information
[ ]  Motorola Internal Use Only
[ ]  Motorola Confidential Proprietary
