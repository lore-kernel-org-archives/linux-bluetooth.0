Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCHv3 bluetooth-next] 6lowpan: fix udp header compression when using raw sockets
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1415114991-3687-1-git-send-email-simon.vincent@xsilon.com>
Date: Tue, 4 Nov 2014 08:32:05 -0800
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Message-Id: <5C1496A6-39B0-4F75-B4E3-C49BB1916AD1@holtmann.org>
References: <1415114991-3687-1-git-send-email-simon.vincent@xsilon.com>
To: Simon Vincent <simon.vincent@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Simon,

> If you use RAW sockets the transport header offset is not set by the
> ipv6 stack so when we get to the udp header compression it does not
> compress the right part of the packet.
> 
> This patch adds a check for this scenario and sets the transport
> header offset.
> 
> Signed-off-by: Simon Vincent <simon.vincent@xsilon.com>
> ---
> v3 fixed indentation
> net/6lowpan/iphc.c | 10 +++++++++-
> 1 file changed, 9 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

