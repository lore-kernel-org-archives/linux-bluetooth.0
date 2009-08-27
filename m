Return-Path: <cyrus@holtmann.org>
Message-ID: <1251363015.4a9648c731895@webmail.htwg-konstanz.de>
Date: Thu, 27 Aug 2009 10:50:15 +0200
From: boehmler@htwg-konstanz.de
To: linux-bluetooth@vger.kernel.org
Subject: Set ACL packettypes
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I'm doing some measurements about bluetooth latency and throughput. And I
especially want to know the differences between the ACL packettypes.

I tried to set the packettype to exactly one type via hciconfig on both dongles
but there are barely differences in the results. Marcel already told me that
the Link-Manager is optimizing the connection by itself and chooses the
packettype.

When looking at the hcidump in Wireshark both sides send the command 'Create
Connection' with the capability to only send/receive the configured packettype.
So who exactly is ignoring this configuration?
Is there a way to convince the LMP to use only the requested packettypes or is
there any workaround?

Thanks,
Eric

