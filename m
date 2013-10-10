Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCHv3 03/15] android: Add Socket Bluetooth HAL template
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20131010065631.GB23879@aemeltch-MOBL1>
Date: Thu, 10 Oct 2013 09:33:38 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <6CBBDF83-16BA-40FB-ACD8-4FB92CF1DFB8@holtmann.org>
References: <1381131496-9417-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1381243883-2745-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1381243883-2745-4-git-send-email-Andrei.Emeltchenko.news@gmail.com> <CCFB8A73-18EC-4FE3-9C92-8FBD91B9F6B9@holtmann.org> <20131010065631.GB23879@aemeltch-MOBL1>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

>>> +static bt_status_t listen(btsock_type_t type, const char *service_name,
>>> +					const uint8_t *uuid, int chan,
>>> +					int *sock, int flags)
>>> +{
>>> +	if ((uuid == NULL && chan <= 0) || sock == NULL) {
>> 
>> we are moving away from uuid == NULL checks. Use !uuid instead.
> 
> I do not like myself these kind of checks but since this seems to be BlueZ
> style. Should I change comparison val != NULL and val != 0 to !val ? Like
> in kernel?

yes, we are slowly moving towards val and !val checks. Especially for new code that coding style has to be enforced now.

Regards

Marcel

