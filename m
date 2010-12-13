Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101213120003.GA12104@jh-x301>
References: <AANLkTin4xG5KUEpn6QaZA0V6y3cDvxpWhwRJhMrE_8QO@mail.gmail.com>
	<20101213120003.GA12104@jh-x301>
Date: Mon, 13 Dec 2010 13:31:19 +0100
Message-ID: <AANLkTim2Q9dgj0t+AAcww33O=pdOHJp=sfQ_F7s8N08i@mail.gmail.com>
Subject: Re: How to implement multiple instances of obexd service?
From: Slawomir Bochenski <lkslawek@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Johan,

On Mon, Dec 13, 2010 at 1:00 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> And what about assigned bitmask values for services in src/obex.h?
>
> Do we need to change something there?

In that case src/obex.h is the only place that will need simple
modification for now -- MAP service value for services bitmask. This
may be OBEX_MAP (or OBEX_MAS) and I supppose its value should be the
next one available -- (1 << 8).

-- 
Slawomir Bochenski
