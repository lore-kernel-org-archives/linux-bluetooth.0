Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTin8pUACCu4YYuhLpFB7DxCfsYhN3cOpYYaVcTQ6@mail.gmail.com>
References: <AANLkTin8pUACCu4YYuhLpFB7DxCfsYhN3cOpYYaVcTQ6@mail.gmail.com>
Date: Mon, 25 Oct 2010 09:34:52 -0400
Message-ID: <AANLkTikXg0gX8BwujjzR4b_yuN1GTe-+oQPcFYbZR1O7@mail.gmail.com>
Subject: Re: [RFC] LE connections and advertising management
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Oct 25, 2010 at 8:53 AM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> 4. Kernel manages the connection establishment, currently there isn't
> a  way to change the connection parameters. BMI or ioctls will be
> required to change the default parameters and also to trigger SMP
> negotiation.

Another idea would be to use setsockopt(), like it's currently being
used for HCI filters (see lib/hci.c). E.g.:

hci_filter_clear(&nf);
hci_filter_set_ptype(HCI_EVENT_PKT, &nf);
hci_filter_set_event(EVT_LE_META_EVENT, &nf);
setsockopt(dd, SOL_HCI, HCI_FILTER, &nf, sizeof(nf);

Not sure if the SMP negotiation happens too soon to use it though.

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
