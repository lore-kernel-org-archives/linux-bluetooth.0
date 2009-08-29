Return-Path: <cyrus@holtmann.org>
Subject: Re: Set ACL packettypes
From: Marcel Holtmann <marcel@holtmann.org>
To: boehmler@htwg-konstanz.de
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1251363015.4a9648c731895@webmail.htwg-konstanz.de>
References: <1251363015.4a9648c731895@webmail.htwg-konstanz.de>
Content-Type: text/plain
Date: Fri, 28 Aug 2009 21:34:01 -0700
Message-Id: <1251520441.2950.133.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eric,

> I'm doing some measurements about bluetooth latency and throughput. And I
> especially want to know the differences between the ACL packettypes.
> 
> I tried to set the packettype to exactly one type via hciconfig on both dongles
> but there are barely differences in the results. Marcel already told me that
> the Link-Manager is optimizing the connection by itself and chooses the
> packettype.
> 
> When looking at the hcidump in Wireshark both sides send the command 'Create
> Connection' with the capability to only send/receive the configured packettype.
> So who exactly is ignoring this configuration?
> Is there a way to convince the LMP to use only the requested packettypes or is
> there any workaround?

it depends on the hardware, but most likely not. The host stack has no
real idea what is the best packet type anyway. So the link manager must
optimize it since it has access to the baseband. Also DM1 is always
allowed anyway.

Regards

Marcel


