Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
From: "s.achterop@rug.nl" <s.achterop@rug.nl>
Subject: How to create multiple rfcomm devices with a set name
Message-ID: <c41a61c1-73f9-3e9a-ae18-c778a7db09f9@rug.nl>
Date: Sun, 21 May 2017 16:35:50 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

   Dear list,

I created a number of robot-vehicles that are controlled using bluetooth/rfcomm.
They are all controlled	via a single PC	that uses different /dev/rfcommx devices.

Earlier I used /etc/bluetooth/rfcomm.conf with lines such as:
     rfcomm117 {bind yes; device 10:00:E8:6C:EC:98; channel 1; comment "dtpa_117"; }
The name of the	robot is dtpa_117, and by connecting to	rfcomm117 I know I am talking via rfcomm to dtpa_117.

Now with debian/stretch	and ubuntu/16.04 (and rfcomm.conf not working anymore) i need something simular.
My question is how do I create a rfcomm-device that matches the above rule.
I only can create rfcomm0 devices.

My second question is how to create these devices automatically, using the information from the rfcomm.conf file.
Can this be done via udev rules? Or via	a systemd service?
I already searched quite a lot in the mailing list and on the net, but now got more or less stuck.

   Hopefully someone can	give me	a pointer on these two questions,
      Thanks in advance,
       	 Sietse	Achterop
          University of Groningen, The Netherlands.

