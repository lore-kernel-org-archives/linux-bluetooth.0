Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACLukzLoHB5u-Vp6RW1rE1z3HDo1hexw5eVOivQHmfhCwJqzAg@mail.gmail.com>
References: <1324051799-21439-1-git-send-email-sancane@gmail.com>
	<1324051799-21439-2-git-send-email-sancane@gmail.com>
	<CAKT1EBc=VRa9doQMDsOU+tBTZCrBjcsEkSD9Z_b37wO_CF15dg@mail.gmail.com>
	<CACLukzLoHB5u-Vp6RW1rE1z3HDo1hexw5eVOivQHmfhCwJqzAg@mail.gmail.com>
Date: Mon, 19 Dec 2011 10:41:56 -0400
Message-ID: <CAJdJm_O=m8L=TB2t8Z3Fc3awDFvAag=+-r4apbfRbTwNgSk7Dg@mail.gmail.com>
Subject: Re: [PATCH 01/11] attrib-server: Initial steps to provide
 multi-adapter GATT server support
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Santiago Carot <sancane@gmail.com>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Mon, Dec 19, 2011 at 10:35 AM, Santiago Carot <sancane@gmail.com> wrote:
>> Is there race condition here? Remember that plugins can also register
>> an adapter driver.
>> If a GATT "plugin" wants to register attributes during the probing the
>> attribute server needs to be ready.
>>
>
> I know that, remember these are transactional patches towardas
> multi-adapter support. They only prepare the environment to start
> coding. The patch 11 fixes this issue. In fact, one could think that
> it should in this place but when I started coding it I thought it was
> easier to reutilize functions which were already implemented and
> change it after multi-adapter started working.

I don't think patch 11 fixes the architectural issue of initializing
the attribute databases on a adapter driver. You can't guarantee it
will be initialized prior to other adapter drivers (registered by GATT
plugins).

> Changing the order of patches or redo them is easy once I get an ack
> to do that if the idea showed here is good. I'm just looking for
> comments about the main idea behind them.

Please take our comments as responses to the RFC :)

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
