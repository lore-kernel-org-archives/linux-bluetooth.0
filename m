Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Mar 2010 01:56:43 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Francisco Alecrim <francisco.alecrim@openbossa.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Emit Adapter.PropertyChanged when UUIDs change
Message-ID: <20100329225643.GA5460@jh-x301>
References: <1269644076-10544-1-git-send-email-francisco.alecrim@openbossa.org>
 <1269644076-10544-2-git-send-email-francisco.alecrim@openbossa.org>
 <20100329074539.GA20839@jh-x301>
 <1269851341.11714.203.camel@localhost.localdomain>
 <2d5a2c101003291148u1836742w1222097fb865ef61@mail.gmail.com>
 <20100329215239.GA3748@jh-x301>
 <4BB125E8.1090200@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4BB125E8.1090200@openbossa.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alecrim,

On Mon, Mar 29, 2010, Francisco Alecrim wrote:
> >> IMO, it should be the same list as we export in extended inquiry
> >> response, so perhaps we could use the data from
> >> create_ext_inquiry_response which already filter those away. Perhaps
> >> some refactoring could also be done since this code seems to be called
> >> multiple times in case of new services because it also changes class
> >> which then triggers create_ext_inquiry_response again.
> 
> I'm not so sure about it but create_ext_inquiry_response list all
> services to any adapters. Shouldn't it list just services per
> adapter(access_db)?

It should be per-adapter (or records registered to BDADDR_ANY) since EIR
is also per-adapter, so looks like a possible bug in the current
implementation.

Btw, another restriction to note with the current EIR UUID list
implementation is that it only supports 16-bit UUIDs. The EIR format
itself would support also 32 and 128 bit formats but probably for
simplicity these have been left out. The Adapter UUIDs list should
however contain all UUIDs (with the exceptions that we already
discussed).

Johan
