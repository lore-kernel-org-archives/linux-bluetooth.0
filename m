Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 2 Aug 2011 10:24:28 -0400
Message-ID: <CAJdJm_PMjCwqBg8gKrsEc2GEYpbrs+2P67y9SCwuN371dWegZg@mail.gmail.com>
Subject: [PATCH BlueZ 0/5] Proximity Reporter implementation (for testing)
 (was: Re: [PATCH] Proximity Monitor implementation (for testing))
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

On Mon, Jul 25, 2011 at 4:15 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> This series implements a basic Proximity Monitor for testing purposes. It lacks
> a number of features, but is already useful for testing our current Proximity
> Monitor implementation.
>
> Note: when applying these patches, make sure it is applied *after* Proximity
> Monitor ones, otherwise it will conflict on the Makefile.am changes.

Of course, the text above does not make sense. I meant:

This series implements a basic Proximity Reporter for testing purposes. It lacks
a number of features, but is already useful for testing our current Proximity
Monitor implementation.

Regards and sorry for the confusion,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
