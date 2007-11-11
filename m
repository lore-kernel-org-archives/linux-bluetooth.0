Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sat, 10 Nov 2007 18:19:25 -0800 (PST)
From: Jim Carter <jimc@math.ucla.edu>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200711091734.29670.ken.koster@elektrobit.com>
Message-ID: <Pine.LNX.4.64.0711101806421.6015@xena.cft.ca.us>
References: <200711091734.29670.ken.koster@elektrobit.com>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Fri, 9 Nov 2007, Koster Ken wrote:

> bluez-lib and bluez-util to 3.19 and I'm attempting to make use of the 
> audio service to send audio to a bluetooth headset.
> 
> Everything is working with the exception that the playback is at half the
> normal speed, so everything recorded is lower in pitch and takes twice
> as long.  (a seven second sound sample takes fourteen to play back)

You mentioned SCO later in the message; this protocol is monophonic.  If 
the sound clip were recorded in stereo (I'm assuming 44100 Hz), with 
independent channels (not joint stereo), then there would be two 
nearly-identical copies of each sound sample, and if you forced it to go 
out as mono, it would play at half speed.  There would be a 22 KHz whistle 
as you alternated between possibly unequal stereo tracks, but since SCO is 
at 8000 Hz, this would be inaudible after the sound stream was resampled 
(or maybe being imaged down to 2 KHz but very quiet due to averaging).  
Maybe that's what happened.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
