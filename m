Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Thu, 18 Oct 2007 10:33:45 -0700 (PDT)
From: Jim Carter <jimc@math.ucla.edu>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <471730B2.3030606@free.fr>
Message-ID: <Pine.LNX.4.64.0710181017560.28683@simba.math.ucla.edu>
References: <719D5CCC2F6E3644B0A9F5C9B1D00088038171C2@esebe104.NOE.Nokia.com>
	<471730B2.3030606@free.fr>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] PATCH1/2: bluez-utils -
	fix-a2dp-buffer-constraints
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

On Thu, 18 Oct 2007, Fabien Chevalier wrote:
> > On 12 Oct 2007, Kai Vehmanen wrote: 

> > Current code seems to gather samples-to-be-sent in a buffer,
> > and when a threshold (a2dp->codesize or cfg.pkt_len) is reached,
> > a packet is then sent right away. So in other words, application
> > cannot really prefill more data than one packet worth, and most of 
> > the allocated buffer space gets never used.
> 
> Well, application can prefill more data, the data gets send immediately 
> to the headset, and buffering will happen at headset side. The issue is 
> if the buffer size as seen by the application is bigger than the real 
> headset buffer size, and the application waits for the buffer to be 
> almost empty before to refill it, then audio cuts might happen. :-(

I remember a month or two back, someone said that the A2DP profile was weak 
on flow control, requiring the source (ALSA) to send data at an even rate.  
If the headset's buffer is full can it cork the stream?  Or will the 
additional data just overwrite data already at the headset?

With bluez-utils-3.19 (3.20 is latest) I'm having consistently good results 
sending to the Bluetooth ALSA device, with neither silent gaps nor lost 
chunks.  But I'm seeing corruption when going through PulseAudio, which is 
attributed to an unknown formatting or parameter issue and is being dealt 
with on their mailing list.

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
