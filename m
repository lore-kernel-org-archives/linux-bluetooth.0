Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTikYDIOyiXLTst3R3K-TC81pMFfvtbPpmRwJqVan@mail.gmail.com>
References: <AANLkTimYuaveU7To6oLdtDLlxXIky1KU7QHMTD47Mwwh@mail.gmail.com>
	<20100720093732.GA3210@jh-x301>
	<AANLkTikYDIOyiXLTst3R3K-TC81pMFfvtbPpmRwJqVan@mail.gmail.com>
Date: Fri, 23 Jul 2010 10:25:59 +0300
Message-ID: <AANLkTikgDEY67+bvfd78gD1EV2AigDti-3MQ3FeSgYsE@mail.gmail.com>
Subject: Re: Virtual cable unplug not supported in BlueZ?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Liang Bao <tim.bao@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Jul 23, 2010 at 5:03 AM, Liang Bao <tim.bao@gmail.com> wrote:
> Adapter.RemoveDevice() also removes the pair information according to
> the document doc/adapter-api.txt. However, unplug a virtual cable in
> HID spec doesn't mean unpair. Anyway, let me check the source once
> again. Thanks.

The question is, why do you want to use virtual cable unplug manually?
There doesn't seems to be any useful use case for that, there is no
"Virtual Cable Plug" either so if we do export virtual cable unplug
feature how we plug it again?

-- 
Luiz Augusto von Dentz
Computer Engineer
