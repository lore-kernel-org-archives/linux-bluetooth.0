Return-Path: <cyrus@holtmann.org>
Date: Wed, 21 Nov 2012 20:51:30 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jefferson Delfes <jefferson.delfes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] hciconfig: Add an option to set which advertise
 type will be on
Message-ID: <20121121185130.GB3074@x220.P-661HNU-F1>
References: <1353506992-3371-1-git-send-email-jefferson.delfes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1353506992-3371-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jefferson,

On Wed, Nov 21, 2012, Jefferson Delfes wrote:
> +	if (opt == NULL || strcmp(opt, "noleadv")) {

Wouldn't it be more intuitive to compare against "leadv" here instead of
"noleadv". Also whenever doing strcmp comparisons please use an explicit
== 0 or != 0. Also, if the logic (and length) of this function starts
growing too much you should really consider splitting it into one per
command.

Johan
