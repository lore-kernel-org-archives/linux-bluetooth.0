Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Jul 2011 11:27:19 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 obexd] Make mime type matching case-insensitive
Message-ID: <20110728082719.GA12420@dell>
References: <1311778927-8002-1-git-send-email-lkslawek@gmail.com>
 <1311783948-5738-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1311783948-5738-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Wed, Jul 27, 2011, Slawomir Bochenski wrote:
> This makes mime type checking performed inside plugins case-insensitive, to
> be in line with d37af12d8cb76d1eb893955938cb6475333dddb9.
> ---
> v3: Fix incorrect transition from boolean function in opp.c
> 
> Phew! Hope I got this right this time.
> 
>  plugins/ftp.c  |    2 +-
>  plugins/opp.c  |    2 +-
>  plugins/pbap.c |    6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)

Applied. Thanks.

Johan
