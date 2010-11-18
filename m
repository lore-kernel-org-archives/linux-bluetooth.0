Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Nov 2010 16:42:39 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Bruna Moreira <bruna.moreira@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] Extract service UUIDs from advertising data
Message-ID: <20101118144239.GA7811@jh-x301>
References: <1290009593-13658-1-git-send-email-bruna.moreira@openbossa.org>
 <1290009593-13658-2-git-send-email-bruna.moreira@openbossa.org>
 <20101118124320.GA4918@jh-x301>
 <AANLkTi=xBthrmGDV0pUK_Tbw-Lob4gT9RmTgPrPAYj7M@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTi=xBthrmGDV0pUK_Tbw-Lob4gT9RmTgPrPAYj7M@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Thu, Nov 18, 2010, Anderson Lizardo wrote:
> > What's the reason that the get_eir_uuids API is designed so that it can
> > handle a list which already contains elements before calling the
> > function? Since you free the list right after creating the uuids array
> > it seems like this shouldn't happen. Or am I missing something?
> 
> The list is destroyed here just to keep the old semantics for BR/EDR,
> which ignores service UUIDs from previous EIR data.
> 
> For LE devices (as you can see on the following 3/3 patch) we do not
> destroy the previous list when new advertising data is parsed.
> Instead, we "merge" the UUIDs list.

Fair enough. I've pushed the patch upstream now.

> Do you think we can unify semantics of BR/EDR and LE and always merge
> the service UUIDs for both EIR and advertising data?

Yeah, I think that could make sense. Feel free to send a patch for it.

> On the current code, the UUIDs array is always created on each EIR
> data (inside get_eir_uuids()) and destroyed right after the
> DeviceFound signal is emitted. For simplicity, we kept this same
> behavior.
> 
> I agree we can make some optimization here and avoid heap
> allocations/deallocations when UUIDs do not change. One idea might be
> to keep the uuids char* array as well as the GSList on the
> remote_dev_info struct, and only recreate this array if any new UUIDs
> were added to the GSList (this can be identified if the uuidcount has
> changed, because we never delete UUIDs). What do you think?

Yes, that sounds like a good optimization.

Johan
