Return-Path: <cyrus@holtmann.org>
Date: Mon, 29 Mar 2010 11:13:08 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Forrest Zhao <forrest.zhao@intel.com>
Cc: linux-bluetooth@vger.kernel.org, forrest.zhao@gmail.com
Subject: Re: [PATCH] Return error when modem_obj_path is NULL
Message-ID: <20100329081308.GA21666@jh-x301>
References: <1269896562-3408-1-git-send-email-forrest.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1269896562-3408-1-git-send-email-forrest.zhao@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Forrest,

On Mon, Mar 29, 2010, Forrest Zhao wrote:
> This could prevent crash in case modem_obj_path is NULL.
> ---
>  audio/telephony-ofono.c |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)

Thanks. Pushed upstream.

Johan
