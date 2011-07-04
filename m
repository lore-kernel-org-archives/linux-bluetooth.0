Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110703114150.GB10186@dell.ger.corp.intel.com>
References: <1309620760-17968-1-git-send-email-lucas.demarchi@profusion.mobi> <20110703114150.GB10186@dell.ger.corp.intel.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 4 Jul 2011 10:25:32 -0300
Message-ID: <CAMOw1v4CH4FEGv8b=keanZ0D+MvH0asi=1jEeYFO9ykTUMssdg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Convert dos file to unix
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>, linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Jul 3, 2011 at 8:41 AM, Johan Hedberg <johan.hedberg@gmail.com> wro=
te:
> Hi Lucas,
>
> On Sat, Jul 02, 2011, Lucas De Marchi wrote:
>> Call `tr -d \\r < tools/ubcsp.c', and since this will change all the
>> lines, remove the trailing white spaces too.
>> ---
>> =A0tools/ubcsp.c | 2360 ++++++++++++++++++++++++++++--------------------=
--------
>> =A01 files changed, 1180 insertions(+), 1180 deletions(-)
>
> I'm not really sure this is worth it since it'll e.g. screw up "git
> blame" for this file. If it was a file that's likely to receive updates
> it'd be different, but since the last change to it was from 2008 I don't
> see that as likely. OTOH I don't really have such a strong opinion about
> this, so if Marcel is fine with it we can apply the patch upstream.

I didn't notice the second patch could be applied regardless of this
first one (unless you removed the part that touches this file).

This \r char was screwing up codespell output and I'm not really happy
fixing it (though I'd welcome a patch).


Lucas De Marchi
