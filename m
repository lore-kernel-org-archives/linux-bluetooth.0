Return-Path: <cyrus@holtmann.org>
From: "Urbani, Edmund" <edmund.urbani@lilandit.com>
Message-ID: <5461EEC6.8070706@LilandIT.com>
Date: Tue, 11 Nov 2014 12:11:02 +0100
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: hcitool lescan scripting question...
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hello,

now this may seem like a silly question, but I have been trying to do some 
simple shell scripting with hcitool's LE scan and redirected its out and err 
streams. The result is not quite what I am expecting:

hcitool lescan --duplicates > /tmp/lescan.out

This will create the output file immediately, but it remains empty until the 
hcitool process terminates. Only then does the entire output get flushed. Any 
idea why the output does not get written immediately? Ie. why I can't "tail -f 
/tmp/lescan.out"?

My intention was to pipe the output through a shell script to add a timestamp to 
each line, so I get a simple log during testing. I did not want to modify 
hcitool/write my own C program just for this purpose.

Kind regards,
  Edmund
