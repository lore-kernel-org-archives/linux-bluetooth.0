Return-Path: <cyrus@holtmann.org>
Message-ID: <20110617133701.20841fj03lelzzpc@mail.hendrik-sattler.de>
Date: Fri, 17 Jun 2011 13:37:01 +0200
From: Hendrik Sattler <post@hendrik-sattler.de>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 4/4] Add copy and move support for filesystem
 plugin
References: <1308292007-2111-1-git-send-email-luiz.dentz@gmail.com>
 <1308292007-2111-4-git-send-email-luiz.dentz@gmail.com>
 <20110617122836.75292sf1oprtrhwk@mail.hendrik-sattler.de>
 <20110617104655.GE28423@dell.ger.corp.intel.com>
In-Reply-To: <20110617104655.GE28423@dell.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Zitat von Johan Hedberg <johan.hedberg@gmail.com>:

> Hi Hendrik,
>
> On Fri, Jun 17, 2011, Hendrik Sattler wrote:
>> Additionally, the obex spec says that the copy/move actions also
>> copies/moves directories recursively.
>
> Where exactly do you see that? To my understanding Action isn't intended
> for directories at all. E.g. in section 3.4.8.1 of IrOBEX 1.4 there's
> just the following:

See section 3.4.8.4:
"A Move Action of a folder should also move the contents of all the  
subfolders beneath it."
"A Copy Action of a folder should also copy the contents of all the  
subfolders beneath it."

HS


