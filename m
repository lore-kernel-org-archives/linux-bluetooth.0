Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43BE0A84.4040007@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] linux 2.4.20 & alsa 0.9.6
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAmaUem1Nm8k+FVVBwbPkbkcKAAAAQAAAAOM1JOHBst0q7ZTbxEE486QEAAAAA@gmail.com>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAmaUem1Nm8k+FVVBwbPkbkcKAAAAQAAAAOM1JOHBst0q7ZTbxEE486QEAAAAA@gmail.com>
Content-Type: text/plain; charset=EUC-KR
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
Date: Thu, 05 Jan 2006 23:13:24 -0700

pdjj14

>  Thank you for your kindness. ^^
>  I want to listen the music which be played at PC as BT headset.
>  My environment is Redhat 9.0 + kernel 2.4.20-8 + bluez-utils-2.10 + bluez-
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
