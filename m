Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Jan 2013 16:17:22 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] storage: Fix memory leak
Message-ID: <20130104141722.GA8761@x220>
References: <1357278148-27872-1-git-send-email-jaganath.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1357278148-27872-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Fri, Jan 04, 2013, Jaganath Kanakkassery wrote:
> If bt_uuid2string() returns NULL then svcclass has to be freed
> ---
>  src/storage.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Both patches have been applied. Thanks.

Johan
