Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] audio problems with a2play
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20041124035850.4c086e3a.henryk@ploetzli.ch>
References: <41A22C0B.4050008@xmission.com> <41A234FA.7020303@xmission.com>
	 <20041123033429.132bf84b.henryk@ploetzli.ch>
	 <41A2B331.4010001@xmission.com>
	 <20041123070621.50569968.henryk@ploetzli.ch>
	 <41A3471C.4000602@xmission.com>
	 <20041123203836.046fb4f4.henryk@ploetzli.ch>
	 <41A3ACE2.4030501@xmission.com>
	 <20041124035850.4c086e3a.henryk@ploetzli.ch>
Content-Type: text/plain
Message-Id: <1101272785.27351.73.camel@pegasus>
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
Date: Wed, 24 Nov 2004 06:06:25 +0100

Hi Henryk,

> Hmm, I made it behaving to the specs (I think) (and yes, this time I
> actually made sure I committed it) and don't hear anything now. 

I think that all GCT based devices (1310:0100) will never behave like in
the specification defined.

Basically these two 0xff 0xff bytes mean nothing, but some values harm
and others don't. At the moment I am using these values:

	buf[12] = 0x80 >> sbc_info.sampling_frequency
		| 0x08 >> sbc_info.channel_mode;
	buf[13] = 0x80 >> sbc_info.blocks
		| 0x08 >> sbc_info.subbands
		| 0x01 << sbc_info.allocation_method;

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
