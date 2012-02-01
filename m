Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1326803673.4432.2.camel@thor>
References: <1312921615.2261.1.camel@THOR>
	<4F04285E.1070500@monom.org>
	<4F0AA5A2.4070903@monom.org>
	<20120111112646.GB23277@x220>
	<1326742631.32064.21.camel@thor>
	<20120117082725.GA14943@x220.P-661HNU-F1>
	<1326803673.4432.2.camel@thor>
Date: Wed, 1 Feb 2012 14:22:46 -0800
Message-ID: <CABBYNZ+kASV4s-eHh6r8DZo15ivVc_LmZcGiSq7SJf_D4QP3PA@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: Fix l2cap conn failures for ssp devices
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	Daniel Wagner <wagi@monom.org>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter, Johan,

On Tue, Jan 17, 2012 at 4:34 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
>> I think it'd be important to continue with this work. Even for
>> controllers that don't allow a "security upgrade" you can still detect
>> the situation when you get an auth_complete without any preceding
>> link_key or PIN request and just drop the connection in such a case. For
>> legacy pairing this would only happen when going from MEDIUM to HIGH
>> since LOW means that you don't have a link key yet.

Perhaps we should apply this patch so at least we are able to connect
anything that requires service discovery before connect attempt e.g.
OBEX which IMO its a very serious issue, we can fix properly the
overload latter but leaving it as it is worst, iirc is this has been
reproducible since 3.0.

-- 
Luiz Augusto von Dentz
