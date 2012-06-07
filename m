Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_PoOtX2rp2zYs1Jeg-J855NwTvj36iVq=YRuHwVd-5o2g@mail.gmail.com>
References: <1339029663-25654-1-git-send-email-andre.guedes@openbossa.org>
	<1339029663-25654-2-git-send-email-andre.guedes@openbossa.org>
	<CAJdJm_PoOtX2rp2zYs1Jeg-J855NwTvj36iVq=YRuHwVd-5o2g@mail.gmail.com>
Date: Thu, 7 Jun 2012 17:13:23 -0300
Message-ID: <CACJA=fUuAHQFz1X23gMxXcLnRxpLgf_Mxfr6XeOce5NBfGmYrw@mail.gmail.com>
Subject: Re: [RFC 2/8] gattrib: Fix g_attrib_set_mtu
From: Andre Guedes <andre.guedes@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Wed, Jun 6, 2012 at 10:26 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Andre,
>
> On Wed, Jun 6, 2012 at 8:40 PM, Andre Guedes <andre.guedes@openbossa.org> wrote:
>> 23 octets is the default (and minimum) ATT_MTU value. If someone tries
>> to set ATT_MTU less than 23 octets g_attrib_set_mtu should fail (return
>> FALSE). Additionally, there is no constraint regarding the maximum value
>> of ATT_MTU, so we should not check for it.
>
> Even though the spec does not mention a maximum ATT_MTU, we now need
> to review and fix the ATT operations that mention limits on their PDU
> (now that we removed the "artificial" 256 octect limit). Some I found:

Yes, we're working on that.

> Also, what will happen to the ATT_MTU_MAX definition? Is it still
> being used in other places?

Yes, we use ATT_MTU_MAX to allocate opdu buffers, but we should
replace ATT_MTU_MAX by the current ATT_MTU.

BR,

Andre
