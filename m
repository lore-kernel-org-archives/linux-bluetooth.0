Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43E183B5.4040006@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco occasional loud bursts of static
References: <43E17EF7.50801@purdue.edu>
In-Reply-To: <43E17EF7.50801@purdue.edu>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Wed, 01 Feb 2006 20:59:49 -0700

Chase

One thing to check is the code we have to accommodate a byte getting
lost. If we don't watch for this, subsequent samples have what should be
a high byte in the low position and vice-versa, so the result is loud
noise for the remainder of the connection.

I haven't looked closely at this, but it's really baffling to think a
single byte could be lost from a stream of 16-bit samples like that. The
protocol should drop entire samples when the signal is bad--losing
*half* a sample is a worst-case scenario.

Brad

> I have a dlink dbt-120 rev. b4 bluetooth adapter with a motorola hs850
> and I use btsco to talk with people online. When I have my laptop
> sitting on my lap, everything works fine. However, when I start to walk
> around, the sound transmitted to the other person from my headset will
> have bursts of loud static. I am guessing that this is a problem with
> the connection being worse. I would like to get this resolved, and I can
> do some coding as well. I have a 2 MB hcidump which somewhere near the
> end has the offending sound packets. I can't find any documentation on
> the SCO protocol, so I can't find where the static was. Can anyone point
> me in the right direction?
> 
> Thank you,
> Chase Douglas
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log
> files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
