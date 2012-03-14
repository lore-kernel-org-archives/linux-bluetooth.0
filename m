Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_Or=Df-bDhVFtteiV8CEop8tEtxAMPBWxmmENeq3nfTWA@mail.gmail.com>
References: <1331457799-26506-1-git-send-email-arik@wizery.com> <CAJdJm_Or=Df-bDhVFtteiV8CEop8tEtxAMPBWxmmENeq3nfTWA@mail.gmail.com>
From: Arik Nemtsov <arik@wizery.com>
Date: Wed, 14 Mar 2012 15:33:27 +0200
Message-ID: <CA+XVXfej4Y6H9WvxM+HjumAK71y4pXtgZJ2MO4FOgbx85tu_RA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Implement TPS profile
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Mar 14, 2012 at 15:23, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
>
> I believe we need to hold this TPS series until some kernel support
> for TX power reading (either automatically on every connection and
> sent along the Device Connected event, or through a new mgmt command,
> depending on what you agreed on IRC regarding what's the best
> approach) is upstream.
>

Of course. I'm still waiting for a comment from Marcel about this.

The dependency is mentioned in the cover letter as well.

Regards,
Arik
