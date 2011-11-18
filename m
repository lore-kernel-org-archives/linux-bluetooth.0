Return-Path: <cyrus@holtmann.org>
Message-ID: <4EC6A0D4.5020008@oricom.ca>
Date: Fri, 18 Nov 2011 13:15:48 -0500
From: =?ISO-8859-1?Q?Yvan_Lagu=EB?= <ylague@oricom.ca>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Bluez-4.96 SPP lock...
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi from Quebec city, Canada...

On a desktop PC, Ubuntu Oneiric 11.10.
Using current distro kernel (3.0.0-12-generic-pae) with current Bluez 
package (Bluez-4.96):

Unable to parse serial data from Garmin GPS-10 Bluetooth GPS receiver...
I am using a Broadcom BCM-2035 USB dongle as my Bluetooth device.

The USB dongle appears to connect correctly to the GPS receiver, but the 
ACL link seems to lock up...

Workaround: Use Bluez-4.69 from Ubuntu Maverick 10.10, which works 
perfectly with my USB dongle / GPS-10 Garmin receiver combination.

I had similar problems with Ubuntu Natty 11.04, and also had to revert 
to Bluez-4.69 to get to read the serial data from Bluetooth GPS.

Best regards,
Mr. Yvan Laguë
Quebec city, Canada.

P.S.: Sorry to use this unusual approach to report my problem, as I seem 
unable to log into Launchpad, always getting some sort of "Open ID 
error" when trying to log in.

