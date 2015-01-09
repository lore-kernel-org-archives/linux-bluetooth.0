Return-Path: <cyrus@holtmann.org>
Date: Fri, 9 Jan 2015 11:47:42 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] shared/gap: Fix memory leak in gap
Message-ID: <20150109094742.GB7762@t440s.lan>
References: <1418992653-6704-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1418992653-6704-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,


On Fri, Dec 19, 2014, Andrei Emeltchenko wrote:
> Allocated irk memory was never assigned.
> ---
>  src/shared/gap.c | 5 +++++
>  1 file changed, 5 insertions(+)

Applied. Thanks.

Johan
