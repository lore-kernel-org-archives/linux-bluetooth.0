Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41A2B331.4010001@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] audio problems with a2play
References: <41A22C0B.4050008@xmission.com>	<41A234FA.7020303@xmission.com> <20041123033429.132bf84b.henryk@ploetzli.ch>
In-Reply-To: <20041123033429.132bf84b.henryk@ploetzli.ch>
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
Date: Mon, 22 Nov 2004 20:49:05 -0700

Henryk,

Are you saying the problem is in a2play or in hcidump?

I don't know the "real" mapping between the indexed settings in the sbc 
file format and the bitmapped settings/capabilities we use with the a2dp 
protocol.

Are these backwards then?

	s_config.sbc_elements.channel_mode = 1 << sbc_info.channel_mode;
	s_config.sbc_elements.frequency = 1 << sbc_info.sampling_frequency;
	s_config.sbc_elements.allocation_method =
	    1 << sbc_info.allocation_method;
	s_config.sbc_elements.subbands = 1 << sbc_info.subbands;
	s_config.sbc_elements.block_length = 1 << sbc_info.blocks;

Brad

Henryk Plötz wrote:
> Moin,
> 
> Hmm, If I'm not mistaken a2play has even other problems. I tried to play
> sbc_test_01.sbc (for a start) through it while doing hcidump -x (the
> old hcidump, that is). When doing the set configuration hcidump said
> 
> < ACL data: handle 0x002b flags 0x02 dlen 18
>     L2CAP(d): cid 0x40 len 14 [psm 25]
>       AVDTP(s): Set config cmd: transaction 0
>       04 04 01 00 07 06 00 00 81 86 02 FA 
> 
> which decodes as
> ACP SEID = 1 (OK)
> INT SEID = 1 (OK)
> Media transport capability (OK)
> Media Codec capability
> 	Audio (OK)
> 	SBC   (OK)
> 	Sampling frequency = 16kHz (should be 48)
> 	Channel mode = Joint stereo (should be mono)
> 	Block length = 4 (should be 16)
> 	Subbands = 8 (should be 4)
> 	Allocation method = SNR (OK)
> 	Bitspool = 2 to 250 (OK)
> 
> As you can see the only correct parameter (apart from the hardwired
> ones) is the allocation method. All others seem to be kind of bit
> reversed. As a side note: The new hcidump AVDTP parser has the same
> problem.
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
