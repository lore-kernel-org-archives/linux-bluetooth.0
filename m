Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Apr 2011 10:50:21 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: Re: [PATCH 1/2] Add NO CARRIER response to HFP
Message-ID: <20110418075021.GA6013@jh-x301>
References: <1303075754-15375-1-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1303075754-15375-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Mon, Apr 18, 2011, Dmitriy Paliy wrote:
> HFP is updated by NO CARRIER response accordingly to HFP 1.5 p.68.
> ---
>  audio/headset.c |   17 ++++++++++-------
>  1 files changed, 10 insertions(+), 7 deletions(-)

Both patches have been pushed upstream after I fixed your author email
(please fix your git config) and a minor coding style issue in the
second patch.

Johan
