Return-Path: <netdev-owner@vger.kernel.org>
Date: Wed, 13 Apr 2016 22:43:36 -0400 (EDT)
Message-Id: <20160413.224336.614846243301591836.davem@davemloft.net>
To: hannes@stressinduktion.org
Cc: netdev@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH net-next] sock: tigthen lockdep checks for
 sock_owned_by_user
From: David Miller <davem@davemloft.net>
In-Reply-To: <1460121087-2859-1-git-send-email-hannes@stressinduktion.org>
References: <1460121087-2859-1-git-send-email-hannes@stressinduktion.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Hannes Frederic Sowa <hannes@stressinduktion.org>
Date: Fri,  8 Apr 2016 15:11:27 +0200

> sock_owned_by_user should not be used without socket lock held. It seems
> to be a common practice to check .owned before lock reclassification, so
> provide a little help to abstract this check away.
> 
> Cc: linux-cifs@vger.kernel.org
> Cc: linux-bluetooth@vger.kernel.org
> Cc: linux-nfs@vger.kernel.org
> Signed-off-by: Hannes Frederic Sowa <hannes@stressinduktion.org>

Applied.
