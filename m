Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Thu, 18 Oct 2007 10:59:50 -0700 (PDT)
From: Jim Carter <jimc@math.ucla.edu>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20071018114517.4b6d1850@ghistelwchlohm.scrye.com>
Message-ID: <Pine.LNX.4.64.0710181052500.28683@simba.math.ucla.edu>
References: <20071018114517.4b6d1850@ghistelwchlohm.scrye.com>
MIME-Version: 1.0
Cc: kevin@scrye.com
Subject: Re: [Bluez-devel] bluetooth headset not working
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

On Thu, 18 Oct 2007, Kevin Fenzi wrote:

> I have setup my ~/.asoundrc. 
> I can play audio to my headset via mplayer or aplay fine. 
> When I try and set twinkle to use the ALSA bluetooth device it seems
> like it opens the headset, and then it spits out: 
> 
> ALSA lib pcm_bluetooth.c:417:(bluetooth_hsp_hw_params) Protocol not
> available (92) 

aplay or mplayer are talking to the ALSA device that uses the A2DP profile.  
The phone app needs to use the device with the HFP profile.  It looks like 
you got that set up in .asoundrc since a plausible subroutine is reporting 
the error.  Next question: does your headset do HFP, or is it purely a 
music headset (A2DP)?  Some headsets, including the Motorola HT820, will 
auto-switch, but I think not every music headset will do so.  Hope this 
helps!

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
