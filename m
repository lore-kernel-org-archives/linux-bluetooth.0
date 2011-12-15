Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Dec 2011 13:50:09 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 4/4] Add support for PullMessagesListing in MAP
 client
Message-ID: <20111215115009.GB8056@x220>
References: <1323703867-20577-1-git-send-email-bulislaw@linux.com>
 <1323703867-20577-4-git-send-email-bulislaw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323703867-20577-4-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Mon, Dec 12, 2011, Bartosz Szatkowski wrote:
> +	{ "GetMessagesListing",	"sa{ss}", "s",	map_get_messages_listing,
> +						G_DBUS_METHOD_FLAG_ASYNC },

The name should be GetMessageListing and not GetMessagesListing (the
latter isn't really proper english). I went ahead and changed it through
a separate patch since I didn't notice before having already applied
your patch. Also, all this seems to be missing from the API
documentation (doc/*). Please send a patch for that.

Johan
