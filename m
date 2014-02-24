Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140224083344.GA29475@x220.p-661hnu-f1>
References: <1392835893-6723-1-git-send-email-claudio.takahasi@openbossa.org>
	<1392835893-6723-8-git-send-email-claudio.takahasi@openbossa.org>
	<20140224083344.GA29475@x220.p-661hnu-f1>
Date: Mon, 24 Feb 2014 08:49:51 -0400
Message-ID: <CAJdJm_OWfmjs2CbFxGP--nno0x5o+6R3FU5+nEP6VC7bjgNKJQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v7 07/11] gatt: Add external services tracking
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	Alvaro Silva <alvaro.silva@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Mon, Feb 24, 2014 at 4:33 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> This whole timer thing seems too hackish to me.
>
> A better way to fix this might be to have something like
> g_dbus_client_set_proxies_complete_watch (or some better name) to let
> the code wait until GetManagedObjects has returned and the initial
> proxies added. Do you agree?

We came up with this workaround during development, but we forgot to
highlight on the cover letter. Indeed a function like the one you
propose should be enough.

Regarding the name for the function, I was thinking as
"g_dbus_client_proxies_ready_watch()". What do you think?


BTW, thanks for looking into these patches and beginning to apply them.

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil
