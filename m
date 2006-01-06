Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "pdjj14" <pdjj14@gmail.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] linux 2.4.20 & alsa 0.9.6
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAmaUem1Nm8k+FVVBwbPkbkcKAAAAQAAAADKpAtBuY3EiXO2W2Etn2/QEAAAAA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
In-Reply-To: <43BE0A84.4040007@xmission.com>
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
Date: Fri, 6 Jan 2006 15:42:14 +0900

 Thank you Brad...
 I have a question...
 To communication between PC and Headset using the bluez, I don't work in
my environment?
 I can change bluez-utils' version, but, I can't change kernel version.
 Are there other methods?

-----Original Message-----
From: bluez-devel-admin@lists.sourceforge.net [mailto:bluez-devel-
admin@lists.sourceforge.net] On Behalf Of Brad Midgley
Sent: Friday, January 06, 2006 3:13 PM
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] linux 2.4.20 & alsa 0.9.6

pdjj14

>  Thank you for your kindness. ^^
>  I want to listen the music which be played at PC as BT headset.
>  My environment is Redhat 9.0 + kernel 2.4.20-8 + bluez-utils-2.10 +
bluez-
> libs-2.10 + bluez-hcidump-1.10 + alsa-dirver-0.9.6 + alsa-lib-0.9.6 +
> bluezsco-0.1.

bluezsco has been unsupported for a long time. use btsco. Kernel 2.4.x
is really tough to get workig with bluetooth audio. If you could use a
current 2.6.x you will have better luck.

hciconfig is also old. i think that's why it doesn't report the sco mapping.

brad


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
