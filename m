Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] audio problems with a2play
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20041123203836.046fb4f4.henryk@ploetzli.ch>
References: <41A22C0B.4050008@xmission.com> <41A234FA.7020303@xmission.com>
	 <20041123033429.132bf84b.henryk@ploetzli.ch>
	 <41A2B331.4010001@xmission.com>
	 <20041123070621.50569968.henryk@ploetzli.ch>
	 <41A3471C.4000602@xmission.com>
	 <20041123203836.046fb4f4.henryk@ploetzli.ch>
Content-Type: text/plain
Message-Id: <1101244496.27351.29.camel@pegasus>
Mime-Version: 1.0
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
Date: Tue, 23 Nov 2004 22:14:56 +0100

Hi Henryk,

> I also saw that you were modifying the way a2play packs its frame though
> that still doesn't look right to me. Maybe we should talk about our
> interpretation of the specs in this case.
> 
> The way I see this we should have a media packet header from AVDTP p. 45
> and a media payload from A2DP p. 23. The media packet header should be
> 12 octets in length (as we don't use any CSRC). I think a2play does
> these right, except for the timestamp (I'll come to that in a second).
> 
> Next thing should be media payload header from A2DP which is 1 octet in
> length and correct, too.
> 
> Then there should be an SBC frame as per A2DP p. 53 just like my code
> produces them. That should start with 0x9C which I can't see anywhere in
> the a2play output.

so should it be and I got a trace from a friend with a prototype A2DP
device with a Zeevo ZV4002 and a Bluetooth stack from Impulsesoft. They
actually do it this way, but GCT puts in 0xff 0xff. I haven't find any
combination to make my Aiptek headphone understand the one byte media
payload header. The very ugly thing is that this headphone is actually
A2DP qualified.

> Now I saw Marcel tried adding a timestamp (which I did, too, without
> any effects, sadly). The way I read section 4.3.3.1 of A2DP would be
> that there should be an imaginary clock counting at the sampling
> frequency of the SBC frames and whose value should then be put into the
> timestamp field. Or, simply put: Count the samples sent so far. 

This was only a quick and dirty hack to see how my headphone behaves if
I fill in that field. Actually it don't cares at all. I will check the
other A2DP trace again, because I saw that they filled in the timestamp
value and maybe the only count the SBC frames.

> I've modified the CVS to my beliefs. Please correct me if you think I'm
> wrong.

Didn't showed up so far.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
