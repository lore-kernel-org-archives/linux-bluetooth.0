Return-Path: <cyrus@holtmann.org>
Message-ID: <1357698323.1806.41.camel@aeonflux>
Subject: Re: [PATCH v2 BlueZ] lib: Fix SDP_TEXT_STR16/SDP_URL_STR16 parsing
From: Marcel Holtmann <marcel@holtmann.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 08 Jan 2013 18:25:23 -0800
In-Reply-To: <1357686325-29529-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1357670608-19081-2-git-send-email-anderson.lizardo@openbossa.org>
	 <1357686325-29529-1-git-send-email-anderson.lizardo@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> sdp_extract_attr() uses the "size" parameter to return the number of
> bytes consumed when parsing SDP Data Elements. This size is used to
> advance a buffer pointer to parse next element.
> 
> This size was being incorrectly calculated for SDP_{TEXT,URL}_STR16 in
> extract_str(), where the string length was added twice. The string
> length is already added later in the function for {TEXT,URL}_STR{8,16}
> by this statement:
> 
> *len += n;
> ---
>  lib/sdp.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied.

Regards

Marcel


