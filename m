Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Oct 2011 13:32:42 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Vinicius Gomes <vinicius.gomes@openbossa.org>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [PATCH BlueZ] Fix memory corruption when decoding Read Response
 PDU
Message-ID: <20111005103242.GA29660@fusion.localdomain>
References: <1317236492-13064-1-git-send-email-anderson.lizardo@openbossa.org>
 <20111003085145.GC8956@fusion.localdomain>
 <CAJdJm_NHQJgKQ8Oec0F_zHfWtxfNia1jhddmocVwTO_dWKx1pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_NHQJgKQ8Oec0F_zHfWtxfNia1jhddmocVwTO_dWKx1pg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Tue, Oct 04, 2011, Anderson Lizardo wrote:
> > Have you considered changing the API so that the caller could tell the
> > function the size of the supplied buffer?
> 
> Yes. I even mentioned on the last paragraph :)

Yep, I missed it. Sorry.

> I was afraid it was too late to change this, but if you thing it is
> not an issue for external/third party code to break now, we can change
> this now.

This is not a public API so there's no problem there. (even if it was
public we'd have marked it as experimental for now)

Johan
