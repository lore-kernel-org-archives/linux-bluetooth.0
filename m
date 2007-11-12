Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Ken Koster <ken.koster@elektrobit.com>
To: bluez-devel@lists.sourceforge.net
Date: Mon, 12 Nov 2007 10:41:30 -0700
References: <200711091734.29670.ken.koster@elektrobit.com>
	<Pine.LNX.4.64.0711101806421.6015@xena.cft.ca.us>
In-Reply-To: <Pine.LNX.4.64.0711101806421.6015@xena.cft.ca.us>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1194889296-28423-28"
Message-Id: <200711120941.30666.ken.koster@elektrobit.com>
Subject: Re: [Bluez-devel] headset audio playback real slooowwww
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

------------=_1194889296-28423-28
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 10 November 2007, Jim Carter wrote:
> On Fri, 9 Nov 2007, Koster Ken wrote:
> 
> > bluez-lib and bluez-util to 3.19 and I'm attempting to make use of the 
> > audio service to send audio to a bluetooth headset.
> > 
> > Everything is working with the exception that the playback is at half the
> > normal speed, so everything recorded is lower in pitch and takes twice
> > as long.  (a seven second sound sample takes fourteen to play back)
> 
> You mentioned SCO later in the message; this protocol is monophonic.  If 
> the sound clip were recorded in stereo (I'm assuming 44100 Hz), with 
> independent channels (not joint stereo), then there would be two 
> nearly-identical copies of each sound sample, and if you forced it to go 
> out as mono, it would play at half speed.  There would be a 22 KHz whistle 
> as you alternated between possibly unequal stereo tracks, but since SCO is 
> at 8000 Hz, this would be inaudible after the sound stream was resampled 
> (or maybe being imaged down to 2 KHz but very quiet due to averaging).  
> Maybe that's what happened.

Unfortunately the clip is mono, recorded at an 8k rate.

I'm rapidly learning far more about SCO than I ever planned :-)

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


------------=_1194889296-28423-28
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
------------=_1194889296-28423-28
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------------=_1194889296-28423-28--
