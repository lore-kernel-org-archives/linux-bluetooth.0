Return-Path: <cyrus@holtmann.org>
Message-ID: <1357862791.1806.78.camel@aeonflux>
Subject: Re: [PATCH BlueZ 2/2] attrib: Fix compilation errors when compiled
 without optimization
From: Marcel Holtmann <marcel@holtmann.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 10 Jan 2013 16:06:31 -0800
In-Reply-To: <1357659987-4219-2-git-send-email-anderson.lizardo@openbossa.org>
References: <1357659987-4219-1-git-send-email-anderson.lizardo@openbossa.org>
	 <1357659987-4219-2-git-send-email-anderson.lizardo@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderzon,

> Fix these build errors:
> 
> attrib/att.c: In function ‘dec_read_by_grp_req’:
> attrib/att.c:165:10: error: comparison between signed and unsigned
> integer expressions [-Werror=sign-compare]
> attrib/att.c:170:10: error: comparison between signed and unsigned
> integer expressions [-Werror=sign-compare]
> attrib/att.c: In function ‘dec_read_by_type_req’:
> attrib/att.c:393:10: error: comparison between signed and unsigned
> integer expressions [-Werror=sign-compare]
> attrib/att.c:402:10: error: comparison between signed and unsigned
> integer expressions [-Werror=sign-compare]
> ---
>  attrib/att.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied.

Regards

Marcel


