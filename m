Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <443E7B8B.4010109@rumms.uni-mannheim.de>
From: Andreas Faerber <afaerber@rumms.uni-mannheim.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Periodic inquiry issues [was: EVT_EXTENDED_INQUIRY_RESULT]
References: <44229D0A.5080508@rumms.uni-mannheim.de>	 <1143122060.9923.12.camel@localhost>	 <4422C49C.2060004@rumms.uni-mannheim.de>	 <1143218750.12582.33.camel@localhost>	 <44242DFC.4080501@rumms.uni-mannheim.de> <1143223791.12582.47.camel@localhost> <44244610.40703@evilgenius.de>
In-Reply-To: <44244610.40703@evilgenius.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 13 Apr 2006 18:25:47 +0200

Hi,

Martin Karger wrote:
> in germany karstadt is selling the csr-based cellink bta-6030.

We've got our Cellink BTA-6030 with CSR chipset now and the problems are 
exactly the same as with the Broadcom based dongle. Maybe I'm doing 
something stupid...?

Let me repeat that this is on SuSE 10.1b8 with BlueZ 2.24 and I'm using 
HCI to do a periodic inquiry.
The oddities from my point of view are the following:

- On our original CSR based D-Link DBT-120 if there's one discoverable 
device then an inquiry returns this device and then after the specified 
time period a second time etc. On the Broadcom based Belkin and on the 
CSR based Cellink the repetition is *irregular* - from subsecond to 
minutes before and between results. (and the D-Link unfortunately 
doesn't support inqmode > 0, whereas Belkin inqmodes 1,2 and Cellink 
inqmode 1)
What is the exact relation between max_period, min_period and length 
within the struct periodic_inquiry_cp and what are recommended value 
combinations? Could that be the source of the problem? Currently I'm 
using length < min_period < max_period, e.g. length=30, min_period=31, 
max_period=45 (have also tried some other numbers) with num_rsp=100 and 
believe the times to be in units of 1.28 seconds according to the header 
file comments.

- We are doing the periodic inquiry to get a /live/ RSSI without needing 
to connect - however the RSSI remains constant (over a long time) even 
if we walk away with the discovered device... do I need to purge some 
kind of cache or is this a hardware problem? (observed on multiple/all? 
devices) I'd expect to see some change on both 10 m and 100 m dongles.

- Both the batostr function and my own C code get the device address as 
AA:BB:CC:DD:EE:FF (...->bdaddr.b[0..5]) while "hcitool scan" outputs 
them as 00:FF:EE:DD:CC:BB - could someone please explain this?

I've double-checked array bounds etc. and haven't found a clue. Any 
hints or ruling-out would be appreciated!

Best regards and Happy Easter,

Andreas


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
