Return-Path: <cyrus@holtmann.org>
Date: Tue, 4 Dec 2012 13:25:40 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] profile: Fix possible NULL pointer dereference
Message-ID: <20121204112540.GA2153@x220>
References: <1354616124-10995-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1354616124-10995-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Dec 04, 2012, Szymon Janc wrote:
> If send_new_connection failed NULL err pointer would be dereferenced.
> ---
>  src/profile.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Both patches have been applied. Thanks.

Johan
