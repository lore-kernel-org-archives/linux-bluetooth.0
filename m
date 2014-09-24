Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Sep 2014 10:53:37 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] shared/hfp: Remove not used permissive_syntax value
Message-ID: <20140924075337.GA14486@t440s.ger.corp.intel.com>
References: <1411544129-24515-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1411544129-24515-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Wed, Sep 24, 2014, Lukasz Rymanowski wrote:
> It was planned to be used in case of some un specified commands, but in
> the end we did not have to use it
> ---
>  src/shared/hfp.c | 12 ------------
>  1 file changed, 12 deletions(-)

Applied. Thanks.

Johan
