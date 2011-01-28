Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1296231972-6070-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1296231972-6070-1-git-send-email-anderson.lizardo@openbossa.org>
Date: Fri, 28 Jan 2011 14:42:43 -0400
Message-ID: <AANLkTikdmGPt36KYQg2f_KFghSKC55cxVFpmOeMrcLe3@mail.gmail.com>
Subject: Re: [PATCH] Add read callback support to attribute server
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jan 28, 2011 at 12:26 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> This callback will allow profiles to act before an attribute is read,
> to e.g. update the attribute value from an external source.
>
> Note that by the time the callback is called, the necessary security
> checks (attribute permissions, authentication and encryption) were
> already performed by the core attribute server.
>
> The callback can optionally return an ATT status code, which will be
> sent to the client.

Please ignore this patch. I'll send another one which also addresses
read blob requests and attribute write.

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
