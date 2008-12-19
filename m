Return-Path: <cyrus@holtmann.org>
Message-Id: <B5F305E0-C554-4753-AAB5-71DA06305A1D@cam.ac.uk>
From: Simon Hay <sjeh3@cam.ac.uk>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Connection time behaviour question
Date: Fri, 19 Dec 2008 13:33:44 +0000
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have a question about behaviour establishing connections that seems  
to have changed between different versions of BlueZ, and I'm hoping  
someone will be good enough to help explain what's going on for me!

I have a test program that opens an L2CAP connection to a device,  
reads the RSSI, closes it again, waits a few seconds and repeats the  
process.  Optionally, it will do clock caching - i.e. read the clock  
offset when a connection is established and pass this in when making  
the next connection.  Using version 3.18 the BlueZ libraries, this  
behaves more or less as I would expect:  if clock caching is not  
turned on, the connection times are distributed fairly evenly and if  
it is they are much quicker and fairly constant (e.g. 1300 ms, plus or  
minus a hundred or so for a particular device).  Using various  
subsequent versions however (in particular 3.29 and 4.22) we see  
different behaviour: whether clock caching is turned on or not, the  
connection times follow a sawtooth pattern, starting very low (about  
100 ms), then going up steadily in increments of a couple of hundred  
ms until they reach a peak (1000-2000) and then fall back to a very  
low value and the process repeats.  I'm somewhat confused as to why  
this is happening - I've tried to read through the code changes but  
without much success.  Can anyone shed any light on this for me?

Thanks very much in advance for your help!

Simon
