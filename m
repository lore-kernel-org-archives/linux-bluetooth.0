Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130430082531.GF777@x220.ger.corp.intel.com>
References: <1367300704-703-1-git-send-email-andre.guedes@openbossa.org>
	<1367300704-703-5-git-send-email-andre.guedes@openbossa.org>
	<20130430082531.GF777@x220.ger.corp.intel.com>
Date: Tue, 30 Apr 2013 15:06:19 -0300
Message-ID: <CACJA=fUG9iGOLFBd2bEbQBpkY1s+0iKnhs-k1R2Qd=-xd6Estw@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] Bluetooth: Remove start discovery handling from hci_event.c
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Apr 30, 2013 at 5:25 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Andre,
>
> On Tue, Apr 30, 2013, Andre Guedes wrote:
>> Since all mgmt start discovery command complete events are now handled
>> in start_discovery_complete callback in mgmt.c, we can remove this
>> handling from hci_event.c.
>>
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>>  net/bluetooth/hci_event.c | 24 +-----------------------
>>  1 file changed, 1 insertion(+), 23 deletions(-)
>
> Acked-by: Johan Hedberg <johan.hedberg@intel.com>
>
> However, it looks like after this patch you could have another one to
> remove mgmt_start_discovery_failed from hci_core.h since it's only
> needed inside mgmt.c. Or did I miss something?

Yes, you're right. I'll make mgmt_start_disovery_failed static and
remove it from hci_core.h.

Thanks,

Andre
