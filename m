Return-Path: <bluez-users-admin@lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
From: "bart claeys" <bart.claeys@mail.com>
To: Bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] RSSI
Message-Id: <20040428142719.CA28543E42@ws1-9.us4.outblaze.com>
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
Date: Wed, 28 Apr 2004 09:27:19 -0500

> Hi Abhishek, 
> 
> > In BlueZ, what does 'hcitool rssi 
' return? does it return the 
> > actual RSSI value or is the output similar to the result of the 
> > HCI_Read_RSSI command as mentioned in the BT spec? 
> 
> it returns the result of the HCI_Read_RSSI command. 
> 
> Regards 
> 
> Marcel 

Hi,

I also ran some tests between an iPAQ H3970 and a D-link DBT-120 USB device.
at a distance smaller than 10m, the value returned for rssi was always 0.
at a distance lager than 12m, the value was always -10
the BT specs say the HCI_Read_RSSI command command will read the value for the difference between the measured
Received Signal Strength Indication (RSSI) and the limits of the Golden Receive Power Range. The range of the returned value is between -128 and 127, and the units is dB.

My question is: why do I always get -10 even when the distance between the devices is 25m? Is this a limitation on the D-link BT stick? Is it possible that the returned value is in dBm in stead of dB?

I also found a paper of a student at
http://www.telecommunications.crc.org.au/docs/VacStudent%20Presentations/Laville.pdf
page 8: the result this person observed are very simular to the results I have. He used dBm as units, but I don't know if that's correct...

thanks in advance, regards,

Bart
-- 
___________________________________________________________
Sign-up for Ads Free at Mail.com
http://promo.mail.com/adsfreejump.htm



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
