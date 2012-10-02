Return-Path: <cyrus@holtmann.org>
Message-ID: <506AEDFC.9060300@rug.nl>
Date: Tue, 02 Oct 2012 15:37:00 +0200
From: Sietse Achterop <s.achterop@rug.nl>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Unreliable communication with multiple bluetooth devices and some
 delay
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


     Dear list,

not sure wheather this for this list, but if so please tell me.
I have problems with unreliable bluetooth communication.

I have 7 bluetooth devices (epucks, educational robots:  http://www.e-puck.org/).
They use the lmx9838 device for bluetooth and are seen as rfcomm-devices on linux.
The lmx-device is used in transparent mode.
This is on various linuxes, with kernels 2.6.32, 3.0.0 and 3.2, e.g. as in the latest ubuntu 12.04.1.

The test program is a simple loop that continuously sends each epuck a small message,
a string of say 6 characters.
I use stdio's fprintf to send chars to the /dev/rfcomm devices.
In pseudo code:
  open_devices();
  while true do
    for i = 1 to 7 do
       fprintf(fp[i], "l,1,2\n");
    od
    delay( 0.5 seconds);
  od

This works perfectly if the delay statement is REMOVED.
Then each 2 milliseconds a message is send to the next epuck.
But if the delay is ADDED again it gets very UNRELIABLE.
After 1 to 30 seconds a communication is failing and after a
20 second delay the connection of a epuck is dropped.
After a longer time all connections are dropped.

I tried a lot, but am at a loss at the moment.
The question is, where the problem. Why is the delay the problem?
Are the short messages the problem?
Is it a bug in the linux driver?

Hopefully someone on the list can help me a step in the right direction.

   Thanks in advance.
      Sietse Achterop
      University of Groningen
      The Netherlands
