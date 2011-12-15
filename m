Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Dec 2011 14:17:00 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 4/4] Add support for PullMessagesListing in MAP
 client
Message-ID: <20111215121700.GA10535@x220>
References: <1323703867-20577-1-git-send-email-bulislaw@linux.com>
 <1323703867-20577-4-git-send-email-bulislaw@linux.com>
 <20111215115009.GB8056@x220>
 <CAPGrrxWWRPkCyKgRu2SkEmdhjdZgkjEQ+ES0DhfuoshvsVBUfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPGrrxWWRPkCyKgRu2SkEmdhjdZgkjEQ+ES0DhfuoshvsVBUfw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Thu, Dec 15, 2011, Bartosz Szatkowski wrote:
> > The name should be GetMessageListing and not GetMessagesListing (the
> > latter isn't really proper english). I went ahead and changed it through
> > a separate patch since I didn't notice before having already applied
> > your patch. Also, all this seems to be missing from the API
> > documentation (doc/*). Please send a patch for that.
> 
> The function name is "GetMessagesListing" in spec.
> There is no doc as at the moment there is no apparams handling and no
> xml parsing, so I'll send patch with doc when we reach full
> functionality.

So the plan is to return something else than the raw XML that MAP
provides? In that case I don't think it's necessary to hold on to the
exact spec naming of these functions. E.g. GetMessages or GetMessageList
might make more sense in the case that you return a pre-parsed
list/structure of some kind.

Johan
