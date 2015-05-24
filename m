Return-Path: <cyrus@holtmann.org>
Date: Sun, 24 May 2015 18:32:43 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] monitor: Improbe decoding of ATT Read by Group
 Type Respose
Message-ID: <20150524153243.GA20254@t440s>
References: <1432473311-16657-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432473311-16657-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Sun, May 24, 2015, Luiz Augusto von Dentz wrote:
> The group data is as follow:
> 
> Attribute Handle (2 octets) End Group Handle (2 octets) Attribute Value
> (Length - 4) octets
> 
> But since only primary and secondary can be used in ATT Read by Group
> Type Request the value is garanteed to be a UUID:
> 
> < ACL Data TX: Handle 3585 flags 0x00 dlen 24
>       ATT: Read By Group Type Response (0x11) len 19
>         Attribute data length: 6
>         Attribute group list: 3 entries
>         Handle range: 0x0001-0x0005
>         UUID: Generic Access Profile (0x1800)
>         Handle range: 0x0006-0x000d
>         UUID: Heart Rate (0x180d)
>         Handle range: 0x000e-0x0011
>         UUID: Battery Service (0x180f)
> ---
>  monitor/l2cap.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)

Applied now (with s/Improbe/Improve/ to the subject). Thanks.

Johan
