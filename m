Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20040331202108.54450.qmail@web10903.mail.yahoo.com>
From: Abhishek Patil <patil_abhishek@yahoo.com>
Reply-To: patilabh@cse.msu.edu
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] RSSI
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 31 Mar 2004 12:21:08 -0800 (PST)


Hi Everyone,

In BlueZ, what does 'hcitool rssi <address>' return? does it return the
actual RSSI value or is the output similar to the result of the
HCI_Read_RSSI command as mentioned in the BT spec? 

The BT spec says that HCI_Read_RSSI will read the value for the difference
between the measured Received Signal Strength Indication (RSSI) and the
limits of the Golden Receive Power Range for a connection handle to another
Bluetooth device.

Put in other words, will 'hcitool rssi <address>' return this difference or
does it give the exact RSSI value which is compared with the GRPR?

I ran some test between an iPAQ (H3800) and a 3COM BT USB device. I was
measuring the RSSI value as seen by the 3COM device (connected to a PC)
while the iPAQ was moved to different locations (I was not doing any data
transfer.. but I had the two devices connected). I noticed that the RSSI
values were highly variable. Even two sets of observations with identical
conditions were giving very different values for RSSI. So, my next question
is how accurate is the RSSI value? I know the BT spec says that there can
be a 6dB +/- variation. Is the result value in dB?

Can I use RSSI to quantify the distance between two BT devices? Meaning
lower values of RSSI -> higher distance?


I was looking at other parameters (link quality, transmit power) and found
that the link quality seemed to be a better indicator of the distance..
with increasing separation between the devices, the command 'hcitool lq
<address>' was giving lower values.. meaning there was a degradation in the
link quality. Any comments on this?


In Bluetooth, the transmitted power for a link is adjustable and the LM can
change the power of a link depending on the conditions. So again, can the
transmit power level (hcitool tpl <address>) be used as an indicator of the
distance? In my tests, I did see a variation in the tpl value for different
positions. 

And one last question.. do any of these values depend on the manufacturer -
i.e. for the same distance and identical environmental conditions.. will a
3COM device and say a cisco device give different values?

Thanks & Regards,
Abhishek


__________________________________
Do you Yahoo!?
Yahoo! Finance Tax Center - File online. File on time.
http://taxes.yahoo.com/filing.html


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
