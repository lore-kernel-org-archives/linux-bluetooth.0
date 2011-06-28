Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 Jun 2011 10:51:53 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com, ulrik.lauren@stericsson.com
Subject: Re: [PATCH] Fix SAP message padding macro
Message-ID: <20110628075153.GB18047@dell.ger.corp.intel.com>
References: <1308645245-21791-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308645245-21791-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Tue, Jun 21, 2011, Lukasz Rymanowski wrote:
> With this patch it is not possible to have incorrect padding equal to 4.
> ---
>  sap/server.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
