Return-Path: <cyrus@holtmann.org>
Message-ID: <4ECA0E71.1000201@tieto.com>
Date: Mon, 21 Nov 2011 09:40:17 +0100
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "kanak.gupta@stericsson.com" <kanak.gupta@stericsson.com>,
	"ulrik.lauren@stericsson.com" <ulrik.lauren@stericsson.com>,
	"henrik.possung@stericsson.com" <henrik.possung@stericsson.com>
Subject: Re: [PATCH] Race condition between RFCOMM and L2CAP
References: <1320844340-1966-1-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1320844340-1966-1-git-send-email-andrzej.kaczmarek@tieto.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 09.11.2011 14:12, Kaczmarek Andrzej wrote:
> Hi,
>
> I recently came across race condition between RFCOMM and L2CAP.
>
> When new rfcomm_session is allocated inside rfcomm_session_create there is also
> L2CAP channel connection started there (and ACL link implicitly). And it can
> happen that actions are scheduled in a way that rfcomm_security_cfm is called
> before newly created rfcomm_session finished initialization and still has
> refcnt set to 0 (because it's not yet linked to rfcomm_dlc). If this happens,
> session will be deleted on rfcomm_session_put and connection will fail:
(...)

Any comments here? This does happen for me with some devices and it's 
quite easily reproducible.

BR,
Andrzej
