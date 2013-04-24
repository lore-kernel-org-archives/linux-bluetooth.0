Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Apr 2013 16:58:55 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC 1/2] gdbus: Add g_dbus_flush_properties()
Message-ID: <20130424135855.GA18679@x220>
References: <1366307424-19825-1-git-send-email-vinicius.gomes@openbossa.org>
 <CABBYNZJFT18e172brOH1QR2WCrZWEkxUsw3vwp8YDKCsYvRPQw@mail.gmail.com>
 <20130419133459.GA7044@echo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130419133459.GA7044@echo>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Apr 19, 2013, Vinicius Costa Gomes wrote:
> On 09:30 Fri 19 Apr, Luiz Augusto von Dentz wrote:
> > What about creating a new flag for properties that need to emit a
> > signal immediately when they change?
> 
> That would also solve the problem.
> 
> The way I see it, we should still not make any guarantees about when
> a propery changed signal will be emitted, only when the API behaviour
> requires, we use some kind of barrier to keep the ordering in check.
> 
> And having a function to call we make it easier to detect when this
> is abused, i.e. we know there's something very wrong if there's a flush
> after each emit.

Is this where the discussion got stuck? Since this feature is really
only needed for quite exceptional situations if an API change needs to
be done I'd be in favor of a separate flush function.

Another option is to make *all* D-Bus messages that gdbus sends to use
an idle callback, including method calls and returns. In the idle
callback the messages would be sent in the same order as they were added
to the send queue. This would not require any changes to the gdbus API.

Johan
