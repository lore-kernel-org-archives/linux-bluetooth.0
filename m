Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
In-Reply-To: <273ADBB8-1458-4DBB-BE1D-11FF4E7037AB@wideray.com>
References: <435B3A56-B448-4E26-8BEB-E0879356ACBB@wideray.com>	<1150538876.17539.0.camel@aeonflux.holtmann.net>	<F73F58A0-A537-4ACE-8C56-D5F2D6735F61@wideray.com>
	<1150741647.4277.30.camel@localhost> <4497A5AC.8050009@yahoo.com>
	<273ADBB8-1458-4DBB-BE1D-11FF4E7037AB@wideray.com>
Message-Id: <461B0A95-BB6D-4C36-8EE5-886AFB5665EA@qwikker.com>
From: Jason Watts <jason.watts@qwikker.com>
Date: Tue, 11 Jul 2006 15:46:55 -0700
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
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


On Jun 20, 2006, at 12:54 PM, Jason Watts wrote:

> On Jun 20, 2006, at 12:37 AM, Pedro Monjo Florit wrote:
>
>>>> All I know at this point is that /var/log/messages gets an endless
>>>> flood of
>>>>
>>>>    sdp_extract_seqtype: Unknown sequence type, aborting
>>>>
>>
>>
>> In a message I sent to the mailing-list back in February (Valentine's
>> day), I explained what, IMHO, is the same problem. I have seen this
>> infinite loop being triggered by a Samsung mobile phone, but still do
>> not know which.
>
>
> I've added code to capture a call chain when this problem occurs.
> We'll deploy this change and hopefully nail down the problem.


We've traced this to a known problem that occurs in bluez libs 2.10,  
but was fixed in 2.23 (in sdp.c 1.31).  I was looking at the wrong  
version of the source code before, so I couldn't find the faulty  
logic.  It had already been fixed by then!

Thanks for the fix. :-)

Jason Watts
Embedded Software Engineer
Qwikker, Inc.


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
