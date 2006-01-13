Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43C6F96B.6080402@sonar-security.com>
From: Michael Puchol <mpuchol@sonar-security.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] Multiple headsets with one dongle
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
Date: Fri, 13 Jan 2006 01:50:51 +0100

Hi everyone,

Firs, I'd like to introduce myself, having just joined the list. I'm the 
hardware engineer at Southwing, a Barcelona-based company that develops 
Bluetooth headsets and carkits. We do both software and hardware design 
in-house. We have a decent lab, and quite a nice range of phones, 
dongles and headsets for testing. Most of our designs are based on the 
BC3 AudioFlash, and now we're dwelling into the SiW3500 now, plus the 
BC4 External. As far as coding goes, I can understand C code, cannot 
really write it without following examples, and could modify code to do 
simple things.

I haven't studied the Bluetooth specs fully (not enough time!), but I 
have begun playing with Asterisk, a BT dongle and a couple of headsets.

Asterisk is configured OK, with a 2.6 kernel on a CentOS 4.2 distro, 
chan_bluetooth is working just fine, as is the BT stack. I have managed 
to have two headsets paired with the dongle, and thus visible to 
Asterisk, and either of them answer an incoming call, or dial a preset 
number, but what I haven't been able to get working is one headset 
calling the other. Well, actually, it *does* work, but the audio is 
totally unusable.

 From what I have been able to gather so far, the headsets are using 
RFCOMM channel 2 (sdptool search --bdaddr 0x111E), and so when both are 
communicating with the dongle at the same time, they most likely are 
interfering each other. My questions are:

1. Am I correct in thinking the RFCOMM channel is derived from the BT 
address/MAC? If so, I could change the MAC of one of the headsets so 
that it would use a different hop sequence.

2. If 1) is incorrect, *where* is this RFCOMM channel configured in the 
CSR pskeys?

3. The dongle, configured as master, *should* support up to three slaves 
using the handsfree profile?

Best regards,

Mike


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
