Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41A3ACE2.4030501@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] audio problems with a2play
References: <41A22C0B.4050008@xmission.com>	<41A234FA.7020303@xmission.com>	<20041123033429.132bf84b.henryk@ploetzli.ch>	<41A2B331.4010001@xmission.com>	<20041123070621.50569968.henryk@ploetzli.ch>	<41A3471C.4000602@xmission.com> <20041123203836.046fb4f4.henryk@ploetzli.ch>
In-Reply-To: <20041123203836.046fb4f4.henryk@ploetzli.ch>
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
Date: Tue, 23 Nov 2004 14:34:26 -0700

Henryk

> Yupp, looks correct to me. So does the new hcidumps's job of decoding
> it.

good

>>	s_config.sbc_elements.channel_mode = 8 >> sbc_info.channel_mode;
> 
> Heh, that's a clever way of doing this. 

I am willing to do something more conventional if this method breaks :)

> I also saw that you were modifying the way a2play packs its frame though
> that still doesn't look right to me. Maybe we should talk about our
> interpretation of the specs in this case.

yes, exactly. Marcel got it to work by tracing the (non-spec!) traffic 
produced by using his headset's transmitter. We don't have the luxury of 
capturing the traffic but we should try to follow the spec as well as we 
can.

> Next thing should be media payload header from A2DP which is 1 octet in
> length and correct, too.
> 
> Then there should be an SBC frame as per A2DP p. 53 just like my code
> produces them. That should start with 0x9C which I can't see anywhere in
> the a2play output.

we just send one sbc frame then? I was assuming that but not sure.

Are you saying we should put 0x9c in the stream or it should be in the 
stream already? The SBC-specific stuff is definitely where my 
understanding ends.

> Now I saw Marcel tried adding a timestamp (which I did, too, without
> any effects, sadly). The way I read section 4.3.3.1 of A2DP would be
> that there should be an imaginary clock counting at the sampling
> frequency of the SBC frames and whose value should then be put into the
> timestamp field. Or, simply put: Count the samples sent so far. 
> 
> I've modified the CVS to my beliefs. Please correct me if you think I'm
> wrong.

I think what we have in CVS looks better but it doesn't sound better :(

Are you using the bluetake too?

Brad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
