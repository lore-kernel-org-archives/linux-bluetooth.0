Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Mar 2011 17:11:55 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	henrik.possung@stericsson.com
Subject: Re: [PATCH] network: Fix for TP_BNEP_CTRL_BV_01_C qualification
 test
Message-ID: <20110314151154.GA1728@jh-x301>
References: <1300108706-22998-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300108706-22998-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Mon, Mar 14, 2011, Lukasz Rymanowski wrote:
> With this fix network plugin will correctly respond on unknown
> BNEP control command.
> ---
>  network/server.c |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)

Pushed upstream. Thanks.

Johan
