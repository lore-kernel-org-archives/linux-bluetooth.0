Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Frederic Dalleau <frederic.dalleau@access-company.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <46AE7340.4010603@gmail.com>
References: <46AE7340.4010603@gmail.com>
Date: Tue, 31 Jul 2007 10:31:46 +0200
Message-Id: <1185870706.27218.43.camel@ubuntu.mpl.access-company.com>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] a2dp, sco and kernel version
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

Hi,

>  I got a much more improved 
> quality audio when using a2dp. Now I really get sound in HiFi.

The nokia guys at indt fixed the sbc codec to get good quality.

> even a2dpd works awfully no, it sounds crappy and 
> disconnects from the headset all the time. 

I'm annoyed by this bug. Several people have been reporting it.
It looks like they all uses kernel 2.6.21 and higher.

A patch has been proposed that you can try by appending
--enable-retrypatch=yes at configure command line. I have not made this
patch default yet because I think it hides the problem.

Now technical question :
A2DPD tries to send each sbc packet at the correct date for playback. To
do this, it uses gettimeofday at the beginning of the stream and if it
is too early to send a packet it will wait for the calculated date.

Sometimes, after a few seconds of playing, the  send() returns EAGAIN.
As if all data were not sent but enqueued, and the queue was full. But
if I send the packet at right date, this queue should not be full.
Most probable is the date of packet sending is bad, but I have checked,
and why would it work with earlier kernels.
Without the patch, a2dpd will disconnect instead of resending the data.
This is because if the packet is not sent at right date, the stream is
interrupted so no matter.

Any advice is welcome...

Frederic


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
