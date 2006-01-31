Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [Bluez-devel] Wake-On-Bluetooth Support
Message-ID: <44BDAFB888F59F408FAE3CC35AB4704102E4A509@orsmsx409>
From: "Zou, Yixiong" <yixiong.zou@intel.com>
To: <bluez-devel@lists.sourceforge.net>
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
Date: Tue, 31 Jan 2006 10:32:30 -0800


>-----Original Message-----
>From: bluez-devel-admin@lists.sourceforge.net=20
>[mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of=20
>Marcel Holtmann
>Sent: Tuesday, January 31, 2006 10:24 AM
>To: bluez-devel@lists.sourceforge.net
>Subject: Re: [Bluez-devel] Wake-On-Bluetooth Support
>
>Hi,
>
>> Does anybody know the current status of the=20
>Wake-On-Bluetooth support? =20
>> For example, if I put the host into S1, can I wake it up by=20
>sending it a Bluetooth event? =20
>> If this is not implemented, could someone give me a pointer=20
>on where I should be=20
>> looking at for this? =20
>
>this actually depends on the chip and so far I haven't seen anything
>like this. I only heard rumors about Apple doing it.
>
>Regards
>
>Marcel
>

Can you tell me what type of capability is needed in the chip for this =
to work?  I thought it is just a matter of not powering down the =
Bluetooth device while in S1 and then send out a generic wake-up event =
to the PCI bus or something. =20

Thank you.=20

-----------------------------------

Yixiong Zou (yixiong.zou@intel.com)
Open Source Technology Center
Intel Corp.


 =20


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
