Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4497A5AC.8050009@yahoo.com>
Date: Tue, 20 Jun 2006 09:37:16 +0200
From: Pedro Monjo Florit <pmonjo2000@yahoo.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
References: <435B3A56-B448-4E26-8BEB-E0879356ACBB@wideray.com>	<1150538876.17539.0.camel@aeonflux.holtmann.net>	<F73F58A0-A537-4ACE-8C56-D5F2D6735F61@wideray.com>
	<1150741647.4277.30.camel@localhost>
In-Reply-To: <1150741647.4277.30.camel@localhost>
Subject: Re: [Bluez-devel] Bug: infinite loop in extract_seq() when
 sdp_extract_seqtype() fails
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Jason and Marcel,

>>>> It appears that extract_seq() in sdp.c (bluez-libs) can enter an
>>>> infinite loop if sdp_extract_seqtype() fails when extract_seq() has
>>>> called itself recursively.  Here's how:
>>> Do you have a patch for it or can you send a small reproducer program?
>> This may be a false alarm.  When I looked closer, I could not explain  
>> how the program could reach the state I described.  The problem is  
>> that sdp_extract_attr() only calls extract_seq() for aggregate  
>> types.  In fact, exactly those types that sdp_extract_seqtype()  
>> expects.  With that invariant, I don't see how the program could fall  
>> into the loop I described, not without resorting to exotic explanations.
>>
>> All I know at this point is that /var/log/messages gets an endless  
>> flood of
>>
>>    sdp_extract_seqtype: Unknown sequence type, aborting
>>
>> We don't know yet what triggers this.  Of course I will follow up if  
>> it still turns out to be a problem in bluez.
> 
> it is kinda likely that SDP still have endless loops in it. However
> please make sure you use the latest bluez-libs from CVS and really run
> the latest sdpd and/or sdptool.


In a message I sent to the mailing-list back in February (Valentine's
day), I explained what, IMHO, is the same problem. I have seen this
infinite loop being triggered by a Samsung mobile phone, but still do
not know which. I did not state it then, but syslog got flooded with the
same message that Jason reports.

I have tried to reproduce the problem with two Samsung's, with no luck.
All I could suggest is that, anybody monitoring the list with a Samsung
at hand, could fiddle with sdptool and see if the problem arises.

Cheers,

Pedro


_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
