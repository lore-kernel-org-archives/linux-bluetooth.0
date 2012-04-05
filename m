Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Apr 2012 22:32:50 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] mgmt: update mgmt control channel id
Message-ID: <20120405193250.GA8510@x220.P-661HNU-F1>
References: <1333653775-10279-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333653775-10279-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Thu, Apr 05, 2012, Gustavo Padovan wrote:
> kernel side has updated its control channel id from 1 to 3.
> ---
>  lib/hci.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied. Thanks.

Note to those testing/developing/using mgmtops: Both the bluetooth and
bluetooth-next trees have the corresponding change so you'll need to
update your kernels to be able to use mgmtops again.

Johan
