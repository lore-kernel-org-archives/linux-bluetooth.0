Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Feb 2012 12:45:53 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] attrib-server: Fix memory leak attaching attribute
 channels
Message-ID: <20120209104553.GA5330@x220.ger.corp.intel.com>
References: <1328621205-14440-1-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328621205-14440-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Tue, Feb 07, 2012, Santiago Carot-Nemesio wrote:
> Channel is not being released when the channel is attached over
> an uninitialized GATT server.
> ---
>  src/attrib-server.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)

Both patches have been applied. Thanks.

Johan
