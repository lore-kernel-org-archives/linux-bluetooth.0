Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Dec 2011 13:54:05 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 4/4] Add support for PullMessagesListing in MAP
 client
Message-ID: <20111215115405.GA9571@x220>
References: <1323703867-20577-1-git-send-email-bulislaw@linux.com>
 <1323703867-20577-4-git-send-email-bulislaw@linux.com>
 <20111215115009.GB8056@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111215115009.GB8056@x220>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Dec 15, 2011, Johan Hedberg wrote:
> On Mon, Dec 12, 2011, Bartosz Szatkowski wrote:
> > +	{ "GetMessagesListing",	"sa{ss}", "s",	map_get_messages_listing,
> > +						G_DBUS_METHOD_FLAG_ASYNC },
> 
> The name should be GetMessageListing and not GetMessagesListing (the
> latter isn't really proper english).

And now I notice that the spec. actually uses the plural form (which
still sounds to me like strange English). All this fuss could have been
avoided if we had had a proper discussion of the API beforehand and had
the documentation in place before these patches.

Johan
