Return-Path: <cyrus@holtmann.org>
Date: Tue, 4 Nov 2014 16:48:59 +0100
From: Alexander Aring <alex.aring@gmail.com>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 bluetooth-next] 6lowpan: fix udp header compression
 when using raw sockets
Message-ID: <20141104154855.GB30647@omega>
References: <1415114991-3687-1-git-send-email-simon.vincent@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1415114991-3687-1-git-send-email-simon.vincent@xsilon.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Nov 04, 2014 at 03:29:51PM +0000, Simon Vincent wrote:
> If you use RAW sockets the transport header offset is not set by the
> ipv6 stack so when we get to the udp header compression it does not
> compress the right part of the packet.
> 
> This patch adds a check for this scenario and sets the transport
> header offset.
> 
> Signed-off-by: Simon Vincent <simon.vincent@xsilon.com>

Acked-by: Alexander Aring <alex.aring@gmail.com>
