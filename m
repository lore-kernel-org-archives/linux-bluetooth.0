Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <431F0839.7050502@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: a2play and rtc/pthread
References: <20050830050012.1059BA0286@bostoncoop.net>
In-Reply-To: <20050830050012.1059BA0286@bostoncoop.net>
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
Date: Wed, 07 Sep 2005 09:33:13 -0600

Nat,

FWIW, I found and fixed a problem in the way we interpreted the rtc 
return, but I still kept having problems with using what libsbc returned 
for the duration of a frame.

Brad

Nat Butler wrote:
> Hi Brad,
> 
> I tried the new a2play code on my Motorola HT820.
> 
> 
>>I just committed changes to a2play so it can use the real time clock
>>inside a separate thread for sending frames to the headset. Please try
>>it out. (flag is -p)
>>
>>The values to tweak are TICKS and the first "100" in the frameticks
>>assignment.
> 
> 
> I'm finding that the sound cuts out after about 10 seconds of playing an mp3 with -p.  I haven't found a value to replace the 100 which corrects that.  
> 
> Per a previous suggestion of yours, I tried using different values from 87 for the itimer option.  A value of 84 seems to work decently with this headset.  The sound cuts out for a fraction of a second every 15 seconds or so.  I was unable to improve this with different values or by using a range of values with either the -t or -t -t options.  
> 
> -Nat
> 
> 
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
