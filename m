Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <005601cdac45$e1ee8ac0$a5cba040$@dk>
References: <507D6F26.8040306@schulz.dk>
	<CAJdJm_NZwNbLwAHNj7JVPVKK2eBe90AeqPRFfqD0Rqr9=bWpNg@mail.gmail.com>
	<507D7480.6040205@schulz.dk>
	<005601cdac45$e1ee8ac0$a5cba040$@dk>
Date: Wed, 17 Oct 2012 08:21:02 -0300
Message-ID: <CAJdJm_P+udqJta3K-FhzYEO4bOm+W=u9koV953etN8TmO=eo4w@mail.gmail.com>
Subject: Re: gatttool and multiple devices connected
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Kim Schulz <kim@schulz.dk>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kim,

On Wed, Oct 17, 2012 at 6:00 AM, Kim Schulz <kim@schulz.dk> wrote:
> Turns out that the guy compiling our kernel choose a version
> 3.4.0.030400 so not really the
> bleeding edge version.
> Do you have any recommendation on what version of the kernel we should
> aim for?

This kernel is actually not that old (as long as it is based on the
official 3.4.0 one). Did you have hcidump logs for the attempt to
discover primary services on device B while connected to device A?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
