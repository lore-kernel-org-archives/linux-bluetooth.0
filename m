Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41A40C9F.80609@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] audio problems with a2play
References: <41A22C0B.4050008@xmission.com>	<41A234FA.7020303@xmission.com>	<20041123033429.132bf84b.henryk@ploetzli.ch>	<41A2B331.4010001@xmission.com>	<20041123070621.50569968.henryk@ploetzli.ch>	<41A3471C.4000602@xmission.com>	<20041123203836.046fb4f4.henryk@ploetzli.ch>	<41A3ACE2.4030501@xmission.com> <20041124035850.4c086e3a.henryk@ploetzli.ch>
In-Reply-To: <20041124035850.4c086e3a.henryk@ploetzli.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Tue, 23 Nov 2004 21:22:55 -0700

Henryk,

I am working right now on assembling a packet with more frames using 
what is in cvs.

Brad

Henryk Plötz wrote:
> Moin,
> 
> Am Tue, 23 Nov 2004 14:34:26 -0700 schrieb Brad Midgley:
> 
> 
>>we just send one sbc frame then? I was assuming that but not sure.
> 
> 
> Yes, for the beginning.
> 
> 
>>Are you saying we should put 0x9c in the stream or it should be in the
>>stream already? The SBC-specific stuff is definitely where my 
>>understanding ends.
> 
> 
> It's already there. The format of an SBC frame is defined in the A2DP
> spec p. 53. They all start with a fixed length header of four bytes
> (that's what struct sbc_frame_header is) and then some more data (the
> length of which is calculated by calc_frame_len). We must send the whole
> frame (that is header plus data).
> 
> 
>>I think what we have in CVS looks better but it doesn't sound better
>>:(
> 
> 
> Hmm, I made it behaving to the specs (I think) (and yes, this time I
> actually made sure I committed it) and don't hear anything now. 
> 
> 
>>Are you using the bluetake too?
> 
> 
> Yes.
> 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
