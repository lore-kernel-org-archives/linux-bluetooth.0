Return-Path: <cyrus@holtmann.org>
Date: Tue, 4 Mar 2014 18:05:05 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] AVCTP: Fix sending wrong response format
Message-ID: <20140304160505.GA4293@localhost.P-661HNU-F1>
References: <1393938497-4522-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1393938497-4522-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Mar 04, 2014, Luiz Augusto von Dentz wrote:
> Reject and Not Implemented responses of PASS THROUGH commands shall
> contain the data of the previous frame accourding to AVC Panel Subunit
> specification page 87.
> ---
>  android/avctp.c        | 4 ++--
>  profiles/audio/avctp.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Applied. Thanks.

Johan
