Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Oct 2010 13:51:16 -0400
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] Fix obexd crash for empty listing invalid cache
Message-ID: <20101028175116.GA641@jh-x301>
References: <1288255408-3967-1-git-send-email-dmitriy.paliy@nokia.com>
 <1288255408-3967-2-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1288255408-3967-2-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Thu, Oct 28, 2010, Dmitriy Paliy wrote:
> This fixes obexd crash in 3-way calling scenario when filtered listing
> response is empty. Valid cache and empty pbap buffer mean that cache was
> already attempted to be created within a single session, but no data was
> available. Hence, it is not notified and no such file error returned.
> 
> Such avoids clearing and creating a new cache operations for each incoming
> call, which is one of possible solution to fix this bug. It can be
> extensive for large phone books. New cache is not created within current
> obex session or unless path is changed.
> ---
>  plugins/pbap.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)

Pushed upstream. Thanks.

Johan
