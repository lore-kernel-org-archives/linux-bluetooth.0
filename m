Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130430083621.GJ777@x220.ger.corp.intel.com>
References: <1367300704-703-1-git-send-email-andre.guedes@openbossa.org>
	<1367300704-703-9-git-send-email-andre.guedes@openbossa.org>
	<20130430083621.GJ777@x220.ger.corp.intel.com>
Date: Tue, 30 Apr 2013 15:06:48 -0300
Message-ID: <CACJA=fXqr-YiqT4S8yA6h-c1XgXi=LKOqXd8Vqf8jm6D93Df3g@mail.gmail.com>
Subject: Re: [PATCH v2 08/13] Bluetooth: Remove stop discovery handling from hci_event.c
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Apr 30, 2013 at 5:36 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Andre,
>
> On Tue, Apr 30, 2013, Andre Guedes wrote:
>> Since all mgmt stop discovery command complete events are now handled
>> in stop_discovery_complete callback in mgmt.c, we can remove this
>> handling from hci_event.c.
>>
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>>  net/bluetooth/hci_event.c | 16 ++--------------
>>  1 file changed, 2 insertions(+), 14 deletions(-)
>
> Acked-by: Johan Hedberg <johan.hedberg@intel.com>
>
> However, looks like you're missing a patch to remove
> mgmt_stop_discovery_failed() from hci_core.h (since it seems it's now
> only needed inside mgmt.c).

Yes, you're right. I'll make mgmt_stop_disovery_failed static and
remove it from hci_core.h.

I'm going to do all these fixes and send a v3 patch set.

Thanks,

Andre
