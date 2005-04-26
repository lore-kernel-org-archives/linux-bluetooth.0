Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <426E741D.8040308@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: a2play code that is working
References: <20050426122127.57962.qmail@web8302.mail.in.yahoo.com>	 <1114527365.10706.288.camel@pegasus> <426E6857.6010204@xmission.com>	 <426E70F6.4060700@xmission.com> <1114534644.10706.316.camel@pegasus>
In-Reply-To: <1114534644.10706.316.camel@pegasus>
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
Date: Tue, 26 Apr 2005 11:02:21 -0600

ok, I will add the parameters to sbc_struct.

Marcel Holtmann wrote:
> Hi Brad,
> 
> 
>>How about if I move the declaration for struct sbc_frame into sbc.h and 
>>change that last argument to sbc_encode to be an sbc_frame *
>>
>>We wouldn't expose the data in the private struct, but just reuse the 
>>struct for communicating sbc info back to the caller...
> 
> 
> this is a bad idea, because then we can never change the internals of
> the decoder/encoder. One of the goals should be to get a SBC codec that
> uses only integer operation.
> 
> The sbc_struct already contains "rate" and "channels" and we should
> simply add the rest of them. I was do lazy to do in the first place and
> actually because I had no use for them.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by: Tell us your software development plans!
> Take this survey and enter to win a one-year sub to SourceForge.net
> Plus IDC's 2005 look-ahead and a copy of this survey
> Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
