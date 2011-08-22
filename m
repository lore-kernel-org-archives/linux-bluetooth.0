Return-Path: <cyrus@holtmann.org>
Date: Mon, 22 Aug 2011 10:40:04 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] phonebook-tracker.c: Calls query speed-up
Message-ID: <20110822074004.GB31673@dell>
References: <1313155128-26979-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313155128-26979-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Fri, Aug 12, 2011, Slawomir Bochenski wrote:
> Another change regarding performance of call history queries. This
> makes them non-sensitive (in terms of speed) to the corner case
> situations when there are hundreds of contacts all having the same
> phone number.
> ---
>  plugins/phonebook-tracker.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

Applied. Thanks.

Johan
