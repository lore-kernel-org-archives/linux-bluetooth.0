Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120928110833.GB14450@x220>
References: <1348526019-28402-1-git-send-email-vinicius.gomes@openbossa.org>
	<1348526019-28402-2-git-send-email-vinicius.gomes@openbossa.org>
	<20120928110833.GB14450@x220>
Date: Fri, 28 Sep 2012 07:28:21 -0400
Message-ID: <CAJdJm_PPjxkXoL+Q=f-3AozUnUErCrD-cQ2KzO1WQSvxJWyRrg@mail.gmail.com>
Subject: Re: [PATCH v3 BlueZ 1/4] gatt: Add support for find included services
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, Sep 28, 2012 at 7:08 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Btw, if you guys are wondering why the stricter coding style checks,
> I've added the following to .git/hooks/pre-{commit,applypatch}:
>
> git diff --cached | ~/src/linux/scripts/checkpatch.pl --no-signoff --ignore INITIALISED_STATIC,NEW_TYPEDEFS,VOLATILE --show-types --mailback -
>
> You might want to do the same (with the correct path to checkpatch.pl)).
> And thanks to Luiz for the idea (he's using the same when applying
> patches).

Thanks for the very useful tip! But which checkpatch.pl version are
you using? Mine (from bluetooth-next tree) lacks --ignore and
--show-types options.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
