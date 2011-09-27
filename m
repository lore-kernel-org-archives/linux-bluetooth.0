Return-Path: <cyrus@holtmann.org>
Message-ID: <4E81AA25.6090907@start.ca>
Date: Tue, 27 Sep 2011 06:49:09 -0400
From: Colin Beckingham <colbec@start.ca>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Installation from git did not proceed cleanly?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, a few observations on installation from git repository on a 
reasonably fresh install of OpenSUSE 11.4. (Previous installations from 
tar.gz have all run correctly first time.)

1. Fetching the clone from the temporary repo not a problem
2. ./configure instruction from README/INSTALL did not work, no 
configure found
3. Found a related advice to run: aclocal, autoheaders,automake and 
autoconf and ran these
4. repeated automake with --add-missing - this added several programmes 
but was not able to deal with missing ltmain.sh
5. I copied ltmain.sh from my previous install of version 4.96, this 
allowed configure to proceed a bit further, ran into problems with 
"package_revision" number in ltmain, hand edited
6. Also a problem with missing Makefile.in - copied from 4.96 - bad way 
to proceed but nothing ventured...
7. ./configure, make, make install all ok from this point.
8. restart of bluez-coldplug service ok.

Result: bluetoothd is working as before. It reports version as 4.96. 
However expected patch for previously reported problem still produces 
same error, so my install may be bad.

Please advise where I went wrong so that I and others can do it 
correctly next time. Any need for additional instructions in INSTALL?
-- 
---
Colin Beckingham
