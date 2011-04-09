Return-Path: <cyrus@holtmann.org>
Date: Sat, 9 Apr 2011 10:27:30 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sheldon Demario <sheldon.demario@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix Characteristic read by UUID on gatttool
Message-ID: <20110409172730.GA26311@jh-x301>
References: <1302028665-5227-1-git-send-email-sheldon.demario@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1302028665-5227-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sheldon,

On Tue, Apr 05, 2011, Sheldon Demario wrote:
> The Characteristic read by UUID GATT procedure is not incremental,
> i.e. it returns the entire list in a single Read By Type request.
> Therefore it should not be called recursively.
> ---
>  attrib/gatttool.c    |    6 ------
>  attrib/interactive.c |    6 ------
>  2 files changed, 0 insertions(+), 12 deletions(-)

Pushed upstream. Thanks.

Johan
