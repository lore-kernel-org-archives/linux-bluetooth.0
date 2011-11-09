Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5b8fef65004ab00b22b5bb4484d0d79e@mail.hendrik-sattler.de>
References: <1320835923-10989-1-git-send-email-sancane@gmail.com>
	<1320835923-10989-2-git-send-email-sancane@gmail.com>
	<CAJdJm_OVgJbGrBmTgTUFaRHazDBweSagPJE0UP0eXa4MVFm61A@mail.gmail.com>
	<61c23c74e4beaa75fd2cf48a13012190@mail.hendrik-sattler.de>
	<CAJdJm_PDwZNJM2Ws2=bO_kF=vVASaBY3nPjEDgS3xWqLtPXv+A@mail.gmail.com>
	<5b8fef65004ab00b22b5bb4484d0d79e@mail.hendrik-sattler.de>
Date: Wed, 9 Nov 2011 10:17:17 -0400
Message-ID: <CAJdJm_NWVP+yKufGho+8GUqotMugiDQjzKNrTM-6OkZC6LhQKA@mail.gmail.com>
Subject: Re: [PATCH 1/6] Manage GATT attribute indications in handle callback.
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Hendrik Sattler <post@hendrik-sattler.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hendrik,

On Wed, Nov 9, 2011 at 9:53 AM, Hendrik Sattler <post@hendrik-sattler.de> wrote:
>> The idea here is to return 0 if they are same or non zero if they are
>> not same. The actual sign is not relevant because the comparison is
>> for finding items, not sorting them (in this case).
>
> Kind of a lazy approach, no?
> Ah well...

I agree with you, and maybe it is even risky if soneone reuses these
functions for list sorting as well without extending them, but this is
the current procedure on BlueZ as a whole:

$ grep -R 'return.*handle - ' src/ attrib/
src/sdpd-database.c:	return rec1->handle - rec2->handle;
src/sdpd-database.c:	return rec1->handle - rec2->handle;
src/device.c:	return r1->handle - r2->handle;
src/attrib-server.c:	return attrib->handle - handle;
src/attrib-server.c:	return attrib1->handle - attrib2->handle;
attrib/client.c:	return chr->handle - handle;

(all these handles are unsigned.)

Note that I'm not defending the current usage, but then it would need
be "fixed" in a separate commit to fix all cases and maintain
consistency.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
