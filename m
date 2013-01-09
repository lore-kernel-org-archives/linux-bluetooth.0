Return-Path: <cyrus@holtmann.org>
Message-ID: <1357758611.1806.47.camel@aeonflux>
Subject: Re: [PATCH BlueZ 2/3] unit: Rename x_pdu() macro on SDP test program
From: Marcel Holtmann <marcel@holtmann.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 09 Jan 2013 11:10:11 -0800
In-Reply-To: <1357744762-5111-2-git-send-email-anderson.lizardo@openbossa.org>
References: <1357744762-5111-1-git-send-email-anderson.lizardo@openbossa.org>
	 <1357744762-5111-2-git-send-email-anderson.lizardo@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> Using the "raw_data" name makes sense, given the macro is just casting
> input (raw) data. It will also be reused in other tests with raw input
> data.
> 
> Also fix this minor checkpatch.pl error:
> 
> ERROR:COMPLEX_MACRO: Macros with complex values should be enclosed in
> parenthesis
> +#define raw_data(args...) (const unsigned char[]) { args }
> ---
>  unit/test-sdp.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

patch has been applied.

Regards

Marcel


