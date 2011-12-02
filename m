Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACLukzK1YyqBszGc679Vj-Pf9+M+s+LaBpnd2_+pan8TCwHODA@mail.gmail.com>
References: <1322129290-10767-1-git-send-email-sancane@gmail.com>
	<20111202112957.GC17203@x220.ger.corp.intel.com>
	<CACLukzK1YyqBszGc679Vj-Pf9+M+s+LaBpnd2_+pan8TCwHODA@mail.gmail.com>
Date: Fri, 2 Dec 2011 11:36:41 -0400
Message-ID: <CAJdJm_P5OU6vqs+-9xL36=1DWVtgzzY1CEPf6rD3Tws5BSik2g@mail.gmail.com>
Subject: Re: [PATCH 1/2] Provide return status in gatt_service_add function
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Santiago Carot <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Fri, Dec 2, 2011 at 7:43 AM, Santiago Carot <sancane@gmail.com> wrote:
> When I was working in this stuff, I was wondering if there may exist
> the case when a plugin registers several services and the last one
> fails, Do you think it would have sense to provide the service ID as
> return parameter to allow plugins remove their attributes before
> aborting the loading operation?, On the other hand, this feature would
> raise the posibility of finding gaps in the distribution of handlers
> assigned in GATT due that plugins could add and remove services
> dynamically, I'm not sure if that is expected in GATT.

I think that, before doing anything like this, we should ensure the
handles allocated for GATT servers do not change after registration
(i.e. they are kept in storage and reloaded when bluez starts). If
possible, can you contribute on this regard?

Thanks,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
