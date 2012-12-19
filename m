Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1355925987.1827.5.camel@aeonflux>
References: <1355921804-12533-1-git-send-email-anderson.lizardo@openbossa.org>
	<1355925987.1827.5.camel@aeonflux>
Date: Wed, 19 Dec 2012 11:05:36 -0400
Message-ID: <CAJdJm_PyC-+7yDXKnLrv0hmEOmaB5mSi3BhEB5rJpz0ET9vGrw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] build: Check for UDEV before setting rulesdir/rules_DATA
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Dec 19, 2012 at 10:06 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> On a side note, you fix has the issue that EXTRA_DIST is now skipped and
> that means it would have broken make distcheck by not including the
> actual rule file.

Sorry about that. I actually seen this error (it causes a "cp
tools/hid2hci.rules tools/hid2hci.rules"). But I thought it was due to
another patch that I was going to send, that removed but forgot to
retest.

I'll pay more attention next time ;)

Thanks,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
