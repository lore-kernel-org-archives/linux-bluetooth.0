Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACLukzK=0he14fvLUoLLDfvOShGNRDhyEsWYywBHbRcBSaK5Jw@mail.gmail.com>
References: <1328284418-4989-1-git-send-email-arik@wizery.com>
	<CACLukzK=0he14fvLUoLLDfvOShGNRDhyEsWYywBHbRcBSaK5Jw@mail.gmail.com>
Date: Fri, 3 Feb 2012 16:19:50 -0400
Message-ID: <CAJdJm_Ok9td+rp0J07EsjMp5ROTc6eQvPhSU7eXA7rTOofoCOA@mail.gmail.com>
Subject: Re: [PATCH v2] proximity: make reporter work per-adapter
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Santiago Carot <sancane@gmail.com>
Cc: Arik Nemtsov <arik@wizery.com>, linux-bluetooth@vger.kernel.org,
	claudio.takahasi@openbossa.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Fri, Feb 3, 2012 at 4:10 PM, Santiago Carot <sancane@gmail.com> wrote:
> Why don't you use the gatt-service API here?. I think it would be
> better a patch in this way than this one.

Arik is working on the conversion (plus other goodies like
disconnection callbacks). I asked him to send this fix first because
the Proximity Reporter was broken since the per adapter service
registration patches went upstream

Most of this patch is already a necessary preparation prior to
gatt-service API conversion, anyway.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
