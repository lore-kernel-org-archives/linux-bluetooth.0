Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v750)
In-Reply-To: <4497A5AC.8050009@yahoo.com>
References: <435B3A56-B448-4E26-8BEB-E0879356ACBB@wideray.com>	<1150538876.17539.0.camel@aeonflux.holtmann.net>	<F73F58A0-A537-4ACE-8C56-D5F2D6735F61@wideray.com>
	<1150741647.4277.30.camel@localhost> <4497A5AC.8050009@yahoo.com>
Message-Id: <273ADBB8-1458-4DBB-BE1D-11FF4E7037AB@wideray.com>
From: Jason Watts <jason.watts@wideray.com>
Date: Tue, 20 Jun 2006 12:54:52 -0700
To: BlueZ development <bluez-devel@lists.sourceforge.net>
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
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Jun 20, 2006, at 12:37 AM, Pedro Monjo Florit wrote:

>>> All I know at this point is that /var/log/messages gets an endless
>>> flood of
>>>
>>>    sdp_extract_seqtype: Unknown sequence type, aborting
>>>
>>> We don't know yet what triggers this.  Of course I will follow up if
>>> it still turns out to be a problem in bluez.
>>
>> it is kinda likely that SDP still have endless loops in it. However
>> please make sure you use the latest bluez-libs from CVS and really  =

>> run
>> the latest sdpd and/or sdptool.
>
>
> In a message I sent to the mailing-list back in February (Valentine's
> day), I explained what, IMHO, is the same problem. I have seen this
> infinite loop being triggered by a Samsung mobile phone, but still do
> not know which. I did not state it then, but syslog got flooded  =

> with the
> same message that Jason reports.

Thanks, Pedro.  This corroborates my findings and further isolates  =

the fault.

I don't know which phone, either.  This happened at a large venue, so  =

it could have been anyone in range.  However, I identified OUI and  =

CoD of the most likely culprits from our logs.  Samsung OUIs also  =

showed up in our data.

Here are the candidates, from most likely to least:

    OUI       CoD       Org. (from http://standards.ieee.org/regauth/ =

oui/oui.txt)
    00:15:B9  0x7A0204  Samsung Electronics
    00:12:47  0x7A0204  Samsung Electronics
    00:12:56  0x520204  LG Information & Comm.
    00:0E:6D  0x520204  Murata Manufacturing

I've added code to capture a call chain when this problem occurs.   =

We'll deploy this change and hopefully nail down the problem.


=BF.) Jason Watts
Embedded Software Engineer
Qwikker, Inc.



_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
