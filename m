Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41A3471C.4000602@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] audio problems with a2play
References: <41A22C0B.4050008@xmission.com>	<41A234FA.7020303@xmission.com>	<20041123033429.132bf84b.henryk@ploetzli.ch>	<41A2B331.4010001@xmission.com> <20041123070621.50569968.henryk@ploetzli.ch>
In-Reply-To: <20041123070621.50569968.henryk@ploetzli.ch>
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
Date: Tue, 23 Nov 2004 07:20:12 -0700

Henryk,

 >>Are these backwards then?
 >
 > Most of them are, with the notable exception of the allocation_method.

I changed how the sbc_info values are translated into sbc_elements and I 
think we're getting the right values now:

	s_config.sbc_elements.channel_mode = 8 >> sbc_info.channel_mode;
	s_config.sbc_elements.frequency = 8 >> sbc_info.sampling_frequency;
	s_config.sbc_elements.allocation_method =
	    1 << sbc_info.allocation_method;
	s_config.sbc_elements.subbands = 2 >> sbc_info.subbands;
	s_config.sbc_elements.block_length = 8 >> sbc_info.blocks;

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
