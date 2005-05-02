Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4275CBF6.9070300@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SBC Decoder with /dev/dsp
References: <20050501124348.24307.qmail@web8310.mail.in.yahoo.com>	 <1114952271.21785.13.camel@pegasus> <1114965624.21785.71.camel@pegasus>
In-Reply-To: <1114965624.21785.71.camel@pegasus>
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
Date: Mon, 02 May 2005 00:43:02 -0600

Marcel,

Thanks for also cleaning up the stuff I did to make libao optional.

Is a2snk working now then? Can I factor out the common stuff in 
a2snk/a2play without messing up changes anyone is holding onto?

Any suggestions for the name of the new header file that a2snk/a2play 
will include? avdtp.h seems like a poor choice...

Brad

Marcel Holtmann wrote:
> Hi Mayank,
> 
> 
>>>This is the improved version for the sbcdec.c file
>>>which you asked for.
>>>
>>>It uses /dev/dsp to play the decoded samples.
>>>
>>>The output is pretty well if we incorporate the proper
>>>endian type.
>>>
>>>I suggest that you keep it as a separate file incase
>>>someone wants to use the AO Libraries.
>>
>>I will move the version using AO to sbcdec_ao and use your version
>>instead. However first I must cleanup your coding style a litte bit.
> 
> 
> I had to change a lot more and so I started over. Please take a look at
> the end result in the CVS.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: NEC IT Guy Games.
> Get your fingers limbered up and give it your best shot. 4 great events, 4
> opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
> win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
