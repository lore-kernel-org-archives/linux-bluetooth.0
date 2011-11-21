Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 Nov 2011 17:03:31 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add thermometer python script
Message-ID: <20111121150331.GA15177@fusion.localdomain>
References: <1321884395-7904-1-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321884395-7904-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Mon, Nov 21, 2011, Santiago Carot-Nemesio wrote:
> ---
>  test/test-thermometer.py |   81 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 81 insertions(+), 0 deletions(-)
>  create mode 100644 test/test-thermometer.py

Drop the .py suffix since no other test script uses that either, and add
the script to EXTRA_DIST in Makefile.tools so that it gets included in
"make dist".

Johan
