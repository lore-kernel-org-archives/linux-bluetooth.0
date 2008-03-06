Return-Path: <cyrus@holtmann.org>
Date: Thu, 6 Mar 2008 10:23:14 -0500
From: jayjwa <jayjwa@atr2.ath.cx>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1204793365.8023.9.camel@littletux>
Message-ID: <alpine.LNX.1.00.0803061004390.3299@nge2.ngu.pk>
References: <alpine.LNX.1.00.0803052312120.7716@nge2.ngu.pk>
	<1204793365.8023.9.camel@littletux>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Headset not working, 2.6.24.x style
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


On Thu, 6 Mar 2008, Guillaume Bedot wrote:

-> I guess you have a bluetooth =< 1.2 headset. It's a known issue,
-> unfortunaletly it is not fixed yet.
-> 
-> You can try this kernel patch and report if this works for you (for me
-> it does) :
-> http://lkml.org/lkml/diff/2008/2/25/530/1


Thanks. I was just looking into this further and found this link which looks 
like the trouble I'm having:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/39414

specifically:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/39414/comments/47


I have the same message flood. My guess was the dongle supports esco, while 
the headset doesn't (because it's not in the feature set). Is this not 
the same issue? Here, the headset:

Requesting information ...
         BD Address:  00:1A:45:01:F9:42
         Device Name: Jabra BT135
         LMP Version: 2.0 (0x3) LMP Subversion: 0xbfa
         Manufacturer: Cambridge Silicon Radio (10)
         Features: 0xfc 0xfe 0x0b 0x00 0x08 0x08 0x00 0x00
                 <encryption> <slot offset> <timing accuracy> <role switch>
                 <hold mode> <sniff mode> <RSSI> <channel quality> <SCO link>
                 <HV2 packets> <HV3 packets> <u-law log> <A-law log> <CVSD>
                 <paging scheme> <transparent SCO> <AFH cap. slave>
                 <AFH cap. master>


I have to leave for the day in about 60 minutes. I'll give the patch a try but 
it might be tonight before I report back (depending on how fast I can build 
kernels). Last night I went with 2.6.23.17 instead of 2.6.24.3, 
but I'd really like to see my headset working under 2.6.24.x kernels.




-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
