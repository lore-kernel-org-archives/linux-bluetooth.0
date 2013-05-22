Return-Path: <cyrus@holtmann.org>
Date: Wed, 22 May 2013 12:31:45 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/1] profile: Fix incoming connections without SDP record
Message-ID: <20130522193145.GA14718@x220>
References: <1369149984-1953-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1369149984-1953-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

On Tue, May 21, 2013, Christian Fetzer wrote:
> After commit 7bd3626b6715ac6a117d56b95b455960f7cf34de, incoming
> connections require the service being available from SDP. This is not
> always guaranteed because some services might not be listed in SDP
> (like MNS).
> ---
>  src/profile.c | 1 +
>  1 file changed, 1 insertion(+)

Applied. Thanks.

Johan
