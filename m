Return-Path: <cyrus@holtmann.org>
Date: Mon, 10 Mar 2014 22:30:59 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Petri Gynther <pgynther@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bdaddr: Remove *_CP_SIZE defines
Message-ID: <20140310203059.GB26442@localhost.P-661HNU-F1>
References: <20140307225545.E2760100887@puck.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140307225545.E2760100887@puck.mtv.corp.google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Petri,

On Fri, Mar 07, 2014, Petri Gynther wrote:
> Remove *_CP_SIZE defines and use sizeof(cp) instead.
> ---
>  tools/bdaddr.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)

Applied. Thanks.

Johan
