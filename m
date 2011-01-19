Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Jan 2011 20:40:00 +0530
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel Wagner <wagi@monom.org>
Cc: linux-bluetooth@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: Re: [PATCH v0 0/2] gdbus introspection fixes
Message-ID: <20110119151000.GB2112@jh-x301>
References: <1295018061-5849-1-git-send-email-wagi@monom.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1295018061-5849-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Fri, Jan 14, 2011, Daniel Wagner wrote:
> During some connman debug session I found some small hickups in the
> introspection code in gdbus. Marcel ask me to check with you first.
> 
> cheers,
> daniel
> 
> Daniel Wagner (2):
>   gdbus: invaldate_parent_data: walk the whole path down
>   gdbus: Remove root node 'name' attribute in introspection
> 
>  gdbus/object.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)

Both patches have been pushed upstream. Thanks.

Johan
