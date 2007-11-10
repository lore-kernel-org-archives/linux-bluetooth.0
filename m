Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Koster Ken <ken.koster@elektrobit.com>
To: bluez-devel@lists.sourceforge.net
Date: Fri, 9 Nov 2007 18:34:29 -0700
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1194658475-12788-13"
Message-Id: <200711091734.29670.ken.koster@elektrobit.com>
Subject: [Bluez-devel] headset audio playback real slooowwww
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format...

------------=_1194658475-12788-13
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I'm fighting a problem that I hope someone here can help with.

For reasons I won't go into here I'm stuck with an environment based off of
Kernel 2.6.10 running on an arm processor. I have been able to upgrade 
bluez-lib and bluez-util to 3.19 and I'm attempting to make use of the 
audio service to send audio to a bluetooth headset.

Everything is working with the exception that the playback is at half the
normal speed, so everything recorded is lower in pitch and takes twice
as long.  (a seven second sound sample takes fourteen to play back)

We're playing a sound sample I recorded on my laptop with arecord, it's a
u8 sample and plays back perfectly on the laptop.

Using hcidump and comparing the data being sent on the laptop with that on
the arm system shows the identical SCO data stream.  The only difference 
we can really see is that the laptop sends an 'HCI Command: Read Remote
Supported Features" to the headset while the arm system doesn't.  This
appears to be due to changes in the kernel code.  I managed to patch the
kernel code to add this (and only this) but it makes no difference.  A hack
I know, but we're getting desperate :-)

Using aplay -v -Dplug:bluetooth sample.u8  shows the identical pcm structure
and setup as the laptop.   Plug PCM: linear conversion PCM (S16_LE) followed
by Slave: Bluetooth Audio Device.

Any suggestions as to where I should concentrate? 

-- 
Ken Koster
Senior Software Engineer

EB - Discover the Experience 
22745 29th Dr. SE, Suite 200
Bothell, WA 98021, USA 
Tel: +1 425-444-2691 
Fax: +1 425-686-3102 
ken.koster@elektrobit.com 
www.elektrobit.com


----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.


------------=_1194658475-12788-13
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
------------=_1194658475-12788-13
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------------=_1194658475-12788-13--
