Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAKT1EBc=VRa9doQMDsOU+tBTZCrBjcsEkSD9Z_b37wO_CF15dg@mail.gmail.com>
References: <1324051799-21439-1-git-send-email-sancane@gmail.com>
	<1324051799-21439-2-git-send-email-sancane@gmail.com>
	<CAKT1EBc=VRa9doQMDsOU+tBTZCrBjcsEkSD9Z_b37wO_CF15dg@mail.gmail.com>
Date: Mon, 19 Dec 2011 10:35:26 -0400
Message-ID: <CAJdJm_NSkwUBKHUx=7AsdCypN4O6uP7nXwaWo9MbFPag8VX6xQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] attrib-server: Initial steps to provide
 multi-adapter GATT server support
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: Santiago Carot-Nemesio <sancane@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Mon, Dec 19, 2011 at 10:08 AM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
>> +static struct btd_adapter_driver attrib_adapter_driver = {
>> +       .name   = "attrib-adapter-driver",
>> +       .probe  = attrib_adapter_probe,
>> +       .remove = attrib_adapter_remove,
>> +};
>
> Is there race condition here? Remember that plugins can also register
> an adapter driver.
> If a GATT "plugin" wants to register attributes during the probing the
> attribute server needs to be ready.

I agree with Claudio here. We should not rely on adapter drivers for
initializing the attribute server (although I previously thought it
could be that simple as well). Otherwise, plugins can't also use
adapter driver's probe() to register attributes , which defeats the
idea of per-adapter ATT attributes.

I think the attribute server should be initialized at an early stage,
after the adapter is created, but prior to having the adapter drivers
called.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
