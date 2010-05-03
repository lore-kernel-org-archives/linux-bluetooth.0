Return-Path: <cyrus@holtmann.org>
Date: Mon, 3 May 2010 17:19:57 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.cz>
To: Bastien Nocera <hadess@hadess.net>
Cc: Antonio Ospite <ospite@studenti.unina.it>,
	linux-input@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] hid/hid-sony: fix sony_set_operational_bt
In-Reply-To: <1272583410.2582.441.camel@localhost.localdomain>
Message-ID: <alpine.LNX.2.00.1005031719460.9849@pobox.suse.cz>
References: <1272578374-9250-1-git-send-email-ospite@studenti.unina.it> <1272583410.2582.441.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 30 Apr 2010, Bastien Nocera wrote:

> > Don't send the report type as part of the data, this prevents the
> > controller from going into the operational state at all.
> > 
> > This is completely equivalent to what the code originally meant to accomplish:
> > as per in net/bluetooth/hidp/core.c::hidp_output_raw_report(), by using
> > HID_FEATURE_REPORT here, what will be actually sent is
> > (HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_FEATURE) which is exactly 0x53.
> > 
> > Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
> Signed-off-by: Bastien Nocera <hadess@hadess.net>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
