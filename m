Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1339029663-25654-2-git-send-email-andre.guedes@openbossa.org>
References: <1339029663-25654-1-git-send-email-andre.guedes@openbossa.org>
	<1339029663-25654-2-git-send-email-andre.guedes@openbossa.org>
Date: Wed, 6 Jun 2012 21:26:49 -0400
Message-ID: <CAJdJm_PoOtX2rp2zYs1Jeg-J855NwTvj36iVq=YRuHwVd-5o2g@mail.gmail.com>
Subject: Re: [RFC 2/8] gattrib: Fix g_attrib_set_mtu
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Wed, Jun 6, 2012 at 8:40 PM, Andre Guedes <andre.guedes@openbossa.org> wrote:
> 23 octets is the default (and minimum) ATT_MTU value. If someone tries
> to set ATT_MTU less than 23 octets g_attrib_set_mtu should fail (return
> FALSE). Additionally, there is no constraint regarding the maximum value
> of ATT_MTU, so we should not check for it.

Even though the spec does not mention a maximum ATT_MTU, we now need
to review and fix the ATT operations that mention limits on their PDU
(now that we removed the "artificial" 256 octect limit). Some I found:

- 3.2.9 Long Attribute Values (page 1839):

The maximum length of an attribute value shall be 512 octets.

- 3.4.4.2 Read By Type Response (page 1853):

The maximum length of an attribute handle-value pair is 255 octets, bounded
by the Length parameter that is one octet.

- 3.4.4.10 Read by Group Type Response (page 1861):

The maximum length of an Attribute Data is 255 octets, bounded by the Length
parameter that is one octet.

Also, what will happen to the ATT_MTU_MAX definition? Is it still
being used in other places?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
