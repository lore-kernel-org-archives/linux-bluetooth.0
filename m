Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1352105705-13988-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1352105705-13988-1-git-send-email-andrzej.kaczmarek@tieto.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Tue, 13 Nov 2012 22:35:56 -0200
Message-ID: <CAMOw1v7zHJZP2nssumkkqqVkDCie5rwMTrS830iS3MbK1RrP+Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] CSCP plugin
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Nov 5, 2012 at 6:54 AM, Andrzej Kaczmarek
<andrzej.kaczmarek@tieto.com> wrote:
> Hi,
>
> Here are v2 patches for CSC profile implementation (cyclingspeed plugin).
>
> Changes since v1:
> - signal is emited when Location property is changed
> - supported locations CP procedure is done only once (see notes below)
> - test script can now calculate instantenous speed and cadence
> - few minor fixes found during testing and review
>
> It's now also tested with PTS - can pass all CSCP testcases but there are
> few things to remember if someone want to retest:
> - testcases in 4.5.3 are broken, look into erratas for updated ets file
> - TP/SPL/CO/BV-01-I shall be run after device is removed because Request
>   Supported Sensor Location procedure is done only once and then result
>   is cached - this is because running it every time device is connected
>   will make other testcases using SC Control Point fail due to unexpected
>   opcode written (and CSCP spec requires this value to be cached anyway)
> - as for now watcher shall be registered before running testcases using
>   SC Control Point to make them work - this is because PTS expects that
>   measurement notifications are enabled before control point indications,
>   otherwise it will wait for writing control point CCC even though it
>   was written before. Errata for this is already accepted and TS will be
>   changed so both CCC can be written in any order.
> - TP/SPS/CO/BV-02-I seems to be broken as it expected different value to
>   be written than what is displayed to tester - issue in PTS for this is
>   in progress
>
>
> Comments are welcome.

I reviewed mainly the gdbus calls, particularly the DBus.Properties
ones. It looks good for me.


Lucas De Marchi
