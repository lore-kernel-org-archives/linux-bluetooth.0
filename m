Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] hid/hid-sony: fix sony_set_operational_bt
From: Bastien Nocera <hadess@hadess.net>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-input@vger.kernel.org, linux-bluetooth@vger.kernel.org
In-Reply-To: <1272578374-9250-1-git-send-email-ospite@studenti.unina.it>
References: <1272578374-9250-1-git-send-email-ospite@studenti.unina.it>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Fri, 30 Apr 2010 00:23:30 +0100
Message-ID: <1272583410.2582.441.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2010-04-29 at 23:59 +0200, Antonio Ospite wrote:
> Don't send the report type as part of the data, this prevents the
> controller from going into the operational state at all.
> 
> This is completely equivalent to what the code originally meant to accomplish:
> as per in net/bluetooth/hidp/core.c::hidp_output_raw_report(), by using
> HID_FEATURE_REPORT here, what will be actually sent is
> (HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_FEATURE) which is exactly 0x53.
> 
> Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>

My mistake there. I should have tested the patch at run-time, and not
trusted my copy-paste skills :(

Signed-off-by: Bastien Nocera <hadess@hadess.net>


