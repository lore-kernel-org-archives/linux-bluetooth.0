Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <loom.20080817T214007-401@post.gmane.org>
References: <loom.20080817T214007-401@post.gmane.org>
Date: Mon, 18 Aug 2008 07:09:43 +0200
Message-Id: <1219036183.7591.13.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Question about cvsd input and output
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

> I have looked all the old articles, but still have a question.
> In the Bluetooth spec, it said the CVSD input shall be 64ksample/s and 16-bit
> linear PCM.
> It also says the output of the CVSD decoder are 16-bit linear PCM
> digital samples, at a sampling frequency of 8 ksample/sec.
> 
> I am a little confused about the data rate of the input side (64k*16bit =
> 1024kbps), which seems 8 times faster than the output of decoder.
> 
> Besides, I tried to open a SCO socket between two adapters (scotest), and the
> maximum data rate in one direction is 128kbps.
> Thus, I don't think we can actually feed 64ksamples/sec, 16-bit voice data into
> the CVSD codec of the adapter. 

the CVSD is only used over-the-air. The input for the host adapter is
based on the voice setting which defaults to 16-bit linear PCM.

Regards

Marcel



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
