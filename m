Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Feb 2012 12:05:53 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/2] tools: Fix test-client to use ERTM while on
 packet mode
Message-ID: <20120202200553.GA837@x220.amr.corp.intel.com>
References: <1328209622-30529-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328209622-30529-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Feb 02, 2012, Luiz Augusto von Dentz wrote:
> +					BT_IO_OPT_MODE, 0x03,

I think it'd be better to add proper defines for these magic values
first.

Johan
