Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1351018956.1785.45.camel@aeonflux>
References: <1351011241-32515-1-git-send-email-johan.hedberg@gmail.com>
	<1351011241-32515-3-git-send-email-johan.hedberg@gmail.com>
	<1351018956.1785.45.camel@aeonflux>
Date: Tue, 23 Oct 2012 15:31:56 -0400
Message-ID: <CAJdJm_OLBgRVBFLD4sEp+OK-qkF_-CXXzuZOCAyiaD+TVMOYKQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] Bluetooth: mgmt: Restrict BR/EDR settings to
 BR/EDR-only adapters
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Oct 23, 2012 at 3:02 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Johan,
>
>> This patch makes sure that settings which are specific for BR/EDR
>> capable adapters are not allowed for non-BR/EDR (e.g. LE-only) adapters.
>> Instead, a "not supported" error is returned of such a setting is
>> attempted to be set for a non-BR/EDR adapter.
>>
>> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
>> ---
>>  net/bluetooth/mgmt.c |   22 +++++++++++++++++++---
>>  1 file changed, 19 insertions(+), 3 deletions(-)
>
> can we lead with this patch. It seems to be useful no matter what we do
> for LE peripheral or single-mode controllers.

I agree that current upstream will be more consistent if these
settings are made "not supported" for LE (as they indeed are not
implemented yet). I was just confused that the same patch series that
improve LE peripheral support does not include properly support for
Connectable/Discoverable modes on this role (which may restrict the
usefulness?).

Johan: do you have further plans on improving LE peripheral support
after these patches? If yes, please keep in mind that we still have
ongoing plans to push broadcaster/observer roles upstream, which also
requires hability to enable/disable advertising and set advertising
data/parameters.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
