Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Apr 2010 18:07:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot Nemesio <scarot@libresoft.es>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: SDP comments
Message-ID: <20100427150710.GB11895@jh-x301>
References: <1272375265.2157.17.camel@mosquito>
 <1272375425.2157.20.camel@mosquito>
 <1272375578.2157.22.camel@mosquito>
 <1272376267.2157.29.camel@mosquito>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1272376267.2157.29.camel@mosquito>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Apr 27, 2010, Santiago Carot Nemesio wrote:
> It may be interesting to take in mind that some functions in sdp_lib
> such as sdp_list_append or sdp_list_insert_sorted can return NULL if
> there isn't enought memory. Grepping the code i saw sentences like next:
> ...
> ap = sdp_list_append(ap, pds);
> ...
> I think that it can result in a memory leak when the asignation return
> NULL over a not empty list. What do you think?

You're right. However this seems more like a design issue with the
library than something that could be easily fixed. Either we'd have to
break the API or then go for the glib way of calling abort() on memory
allocation failures (which in a way would also be breaking the API).

Johan
