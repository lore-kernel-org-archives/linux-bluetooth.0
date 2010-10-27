Return-Path: <cyrus@holtmann.org>
Date: Wed, 27 Oct 2010 15:03:47 -0400
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Fix obexd crash for empty listing invalid cache
Message-ID: <20101027190347.GA8025@jh-x301>
References: <1288202201-861-1-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1288202201-861-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Wed, Oct 27, 2010, Dmitriy Paliy wrote:
> This fixes obexd crash in 3-way calling scenario when listing response is
> empty. Valid cache and empty pbap buffer mean that cache was already attempted
> to be created within a single session, but no data was available. Hence, it
> is not notified and no such file error returned. New cache is not created
> within current obex session or unless path is changed. Such removes necessity
> of querying and filtering contacts for each incoming call in the other case,
> which is extensive for large phone books. On the other hand, if user updates
> contacts, cache will not be renewed till obex session is closed or path is
> changed. Therefore TODO: note is added that clear of cache should be defined
> besides of end of session or change of path.

The commit message seems to have a max width of 78 characters which
means that it's not viewable with git log on a 80 character terminal
(git log indents the output by 4 characters). Please keep the max commit
message width to 74 characters or so. Also, if possible try to split it
up into multiple paragraphs. Paragraphs longer than 6 lines tend to be a
bit harder to follow.

> +		 * TODO: Define clear cache besides end of session or change
> +		 * of path.

That doesn't sound like proper english to me and I'm not sure what
you're trying to say. Should it be "Define a clear distinction between
end of session and change of path"?

Johan
