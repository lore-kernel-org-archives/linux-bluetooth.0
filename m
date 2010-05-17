Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2 1/1] Makes extract_svclass_uuid function public
From: Marcel Holtmann <marcel@holtmann.org>
To: Elvis =?ISO-8859-1?Q?Pf=FCtzenreuter?= <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1273763316-28425-1-git-send-email-epx@signove.com>
References: <1273763316-28425-1-git-send-email-epx@signove.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 17 May 2010 15:13:55 +0200
Message-ID: <1274102035.26613.7.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

> This patch makes the extract_svclass_uuid function public,
> so it may be used by applications that link to libbluetooth.

I really like to see how you are planning to use this function. It is
not a problem to make it public, but I am concerned you might be
misusing it.

Regards

Marcel


