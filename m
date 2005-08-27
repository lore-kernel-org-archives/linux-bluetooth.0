Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <430FC2E4.2000504@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] a2play and Motorola HT820
References: <20050824051102.46AA8A00FC@bostoncoop.net>
In-Reply-To: <20050824051102.46AA8A00FC@bostoncoop.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Fri, 26 Aug 2005 19:33:24 -0600

Nat

> I tested the bluetooth-alsa software for playing mp3's over a Motorola HT820 
> headset.  My Thinkpad X40 laptop is running kernel 2.6.12.5, debian unstable.  
> Sco works fine through xmms, though the sound quality is poor.  A2play with 
> -n works fine for ~10s, then cuts out.  (It cuts out after ~5s without the 
> -n option.)  It usually returns, then cuts out again after a similar period.

I am redoing our timing loop with rtc because it is inconsistent between 
different computers.

If you're impatient, try it without the -n flag but modify the "magic" 
number of 87 to different values to find one that works better.

You can try one or two "-t" flags to change the encoder settings.

It looks like the ht820 has csr chips in it which is a good 
sign--they're normally very tolerant of variable timing in the stream.

Brad


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
