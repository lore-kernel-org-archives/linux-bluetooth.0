Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Jul 2011 11:31:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
	Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: Re: [PATCH obexd v2 3/4] Add handling of system D-Bus method calls
Message-ID: <20110713083117.GC15147@dell.ger.corp.intel.com>
References: <1309297242-4154-1-git-send-email-dmitriy.paliy@nokia.com>
 <1309297242-4154-4-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1309297242-4154-4-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Wed, Jun 29, 2011, Dmitriy Paliy wrote:
> Sending system D-Bus method calls (DefaultAdapter, FindAdapter
> and RequestSession) and handling of pending D-Bus calls is added
> to obex-client.
> ---
>  client/session.c |  196 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  client/session.h |    2 +
>  2 files changed, 197 insertions(+), 1 deletions(-)

I've applied the first two patches but this third one doesn't compile:

client/session.c:189:21: error: no previous declaration for ‘find_session_request’ [-Werror=missing-declarations]

Please fix and resend.

Johan
