Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46C57BA5.5000400@free.fr>
Date: Fri, 17 Aug 2007 12:42:45 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <46C088D7.9000108@silicom.fr>	<1187023591.6262.28.camel@ubuntu.mpl.access-company.com>	<46C1A52F.7050102@free.fr>
	<1187109044.6698.276.camel@violet>
In-Reply-To: <1187109044.6698.276.camel@violet>
Subject: Re: [Bluez-devel] New A2DP support : HOWTO ?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Marcel Holtmann wrote:
> Hi Fabien,
> 
>> For some reason my headset tries to start the A2DP stream, connects to 
>> RFCOMM channel, and then stops the a2dp stream, while it stays connected 
>> to rfcomm (hs profile).
>>
>> To force the use of a2dp i had to reload the audio daemon, and then 
>> launch the multimedia player. It then tries to start a2dp stream, and it 
>> works.
> 
> which headset is this. What about hcitool info output from it.

Sony Ericsson HBH-DS970

/home/fchevalier/bluez-cvs# hcitool info 00:18:13:E7:6D:4F
Requesting information ...
         BD Address:  00:18:13:E7:6D:4F
         Device Name: HBH-DS970
/home/fchevalier/bluez-cvs# hcitool info 00:18:13:E7:6D:4F
Requesting information ...
         BD Address:  00:18:13:E7:6D:4F
         LMP Version: 2.0 (0x3) LMP Subversion: 0xe1b
         Manufacturer: Texas Instruments Inc. (13)
         Features: 0xff 0xfd 0x29 0x78 0x18 0x18 0x00 0x80
                 <3-slot packets> <5-slot packets> <encryption> <slot
offset>
                 <timing accuracy> <role switch> <hold mode> <sniff mode>
                 <park state> <channel quality> <SCO link> <HV2 packets>
                 <HV3 packets> <u-law log> <A-law log> <CVSD>
<transparent SCO>
                 <enhanced iscan> <interlaced iscan> <interlaced pscan>
                 <inquiry with RSSI> <AFH cap. slave> <AFH class. slave>
                 <AFH cap. master> <AFH class. master> <extended features>

> 
>> Btw i got perfect sound quality compared to a2dpd. No small glitches 
>> from time to time, just *perfect* sound. :-)
> 
> Check the latest CVS. Johan fixed some issues with the AVDTP state
> machine and the plugin interaction.

I just did it. However a2dp streaming dooesn't work anymore : i'm gonna
try to have a look to it...

Fabien


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
