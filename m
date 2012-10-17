Return-Path: <cyrus@holtmann.org>
Date: Wed, 17 Oct 2012 14:35:15 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Kim Schulz <kim@schulz.dk>, linux-bluetooth@vger.kernel.org
Subject: Re: gatttool and multiple devices connected
Message-ID: <20121017113515.GA16879@x220.ger.corp.intel.com>
References: <507D6F26.8040306@schulz.dk>
 <CAJdJm_NZwNbLwAHNj7JVPVKK2eBe90AeqPRFfqD0Rqr9=bWpNg@mail.gmail.com>
 <507D7480.6040205@schulz.dk>
 <005601cdac45$e1ee8ac0$a5cba040$@dk>
 <CAJdJm_P+udqJta3K-FhzYEO4bOm+W=u9koV953etN8TmO=eo4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_P+udqJta3K-FhzYEO4bOm+W=u9koV953etN8TmO=eo4w@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Wed, Oct 17, 2012, Anderson Lizardo wrote:
> On Wed, Oct 17, 2012 at 6:00 AM, Kim Schulz <kim@schulz.dk> wrote:
> > Turns out that the guy compiling our kernel choose a version
> > 3.4.0.030400 so not really the
> > bleeding edge version.
> > Do you have any recommendation on what version of the kernel we should
> > aim for?
> 
> This kernel is actually not that old (as long as it is based on the
> official 3.4.0 one). Did you have hcidump logs for the attempt to
> discover primary services on device B while connected to device A?

Actually I'd say that it is too old for LE usage. E.g. the address type
field to the L2CAP socket address was introduced in 3.5 which is quite
important from an LE standpoint.

Johan
