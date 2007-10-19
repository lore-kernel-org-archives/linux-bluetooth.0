Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Fri, 19 Oct 2007 09:03:43 -0700 (PDT)
From: Jim Carter <jimc@math.ucla.edu>
To: Kevin Fenzi <kevin@scrye.com>
In-Reply-To: <20071018124830.58d558be@ghistelwchlohm.scrye.com>
Message-ID: <Pine.LNX.4.64.0710190839510.16412@simba.math.ucla.edu>
References: <20071018114517.4b6d1850@ghistelwchlohm.scrye.com>
	<Pine.LNX.4.64.0710181052500.28683@simba.math.ucla.edu>
	<20071018124830.58d558be@ghistelwchlohm.scrye.com>
MIME-Version: 1.0
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
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

> On Thu, 18 Oct 2007 10:59:50 -0700 (PDT)
> Jim Carter <jimc@math.ucla.edu> wrote:
> > aplay or mplayer are talking to the ALSA device that uses the A2DP
> > profile. The phone app needs to use the device with the HFP profile.
> 
> Humm... do all headsets do A2DP? I thought mine did not. 

The ones with 2 earpieces and a mass of about 100 grams invariably (?) do 
A2DP which transmits stereo at 44100 Hz or 48000 Hz, compressed with the 
SBC codec.  The single-ear ones with a mass of about 20 grams invariably 
(?) do HSP/HFP, monaural at 8000 Hz, I think uncompressed.  That would be 
your Jabra BT 250v.  Some but not all of the music headsets can switch 
protocols and have call control buttons for HFP; these are advertised as 
"works with Skype".

So the Jabra is capable of doing the HSP protocol, and when the message 
says the protocol is "not available", the problem is likely not in the 
headset.  Not likely that the headset is broken or has buggy firmware, but 
just for paranoia, it would be a good data point if the same message were 
seen with a different headset.  

I've seen a similar message when I didn't have bluetoothd-service-audio 
configured to autostart and forgot to start it manually.  Do you have the 
corresponding protocol/profile daemon running?  I don't have my laptop 
handy to look up the name of this daemon but I think it's 
bluetoothd-service-sco.  This is in bluez-utils-3.19 (3.20 is latest; 
probably came in at 3.16.)

Unfortunately that's about the limit of my expertise, since I haven't 
messed with the HSP/HFP feature of the Motorola HT-820 that I have.

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
