Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Feb 2011 13:06:07 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hcitool: add option for LE_Scan_Type
 parameter
Message-ID: <20110211210607.GB26894@jh-x301>
References: <1297373795-14909-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297373795-14909-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Feb 10, 2011, Emeltchenko Andrei wrote:
> +	"\tlescan [--scantype] set scan type 0 - passive, 1 - active (default)\n";

Maybe this should be a boolean flag like the address type? I.e.
--passive and/or --active command line switches?

Johan
