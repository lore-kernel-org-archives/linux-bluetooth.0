Return-Path: <cyrus@holtmann.org>
Date: Wed, 10 Nov 2010 15:17:22 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Automate remote name requests
Message-ID: <20101110131721.GA20570@jh-x301>
References: <1288282824-30736-1-git-send-email-johan.hedberg@gmail.com>
 <1289367862.9615.243.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289367862.9615.243.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Nov 10, 2010, Marcel Holtmann wrote:
> please split this patch into two. One creating the common function for
> the authentication requested and one for adding the name request.
> 
> My brain actually core dumps when following the logic and making sure
> that it is still correct. I pretty sure it is correct, but the whole
> patch is damn hard to review.

Yeah, sorry about this. I know the patch ended up being quite complex.
I'll resend it in three parts in a moment:

1. getting rid of multiple nested if-statements in the remote features
callbacks.
2. create a unified authentication request function
3. add the remote name request

Johan
