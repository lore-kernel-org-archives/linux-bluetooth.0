Return-Path: <cyrus@holtmann.org>
From: Bharat Bhusan Panda <bharat.panda@samsung.com>
To: 'Johan Hedberg' <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, cpgs@samsung.com
References: <1423752296-6763-1-git-send-email-bharat.panda@samsung.com>
 <20150212145733.GA6577@t440s.P-661HNU-F1>
In-reply-to: <20150212145733.GA6577@t440s.P-661HNU-F1>
Subject: RE: [PATCH ] tools/gatt-client: print read/write error messages
Date: Thu, 12 Feb 2015 20:47:18 +0530
Message-id: <004e01d046d7$037470a0$0a5d51e0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Johan Hedberg
> Sent: Thursday, February 12, 2015 8:28 PM
> To: Bharat Panda
> Cc: linux-bluetooth@vger.kernel.org; cpgs@samsung.com
> Subject: Re: [PATCH ] tools/gatt-client: print read/write error messages
> 
> Hi Bharat,
> 
> On Thu, Feb 12, 2015, Bharat Panda wrote:
> > +static char *ecode_to_string(uint8_t ecode)
> 
> This should be static const char *
> 
> > +{
> > +	char *err = NULL;
> > +
> > +	switch (ecode) {
> > +		case BT_ATT_ERROR_INVALID_HANDLE:
> > +			err = "ERROR: Invalid Handle";
> > +			break;
> 
> First of all, please follow the coding style: the case statement should
start at
> the same indentation as the switch. Secondly, you can make this all more
> compact by removing the err variable:
> 
> 	case BT_ATT_ERROR_INVALID_HANDLE:
> 		return "Invalid Handle";
> 	case ...:
> 		return "...";
I have incorporated above review comments and submitted another version of
the patch.

Thanks.

Best Regards,
Bharat 


