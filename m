Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Nov 2010 22:01:40 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 2/6] Add Find By Type Value Response
 encoding/decoding functions
Message-ID: <20101118200140.GA8260@jh-x301>
References: <AANLkTikKFkhyjCQi4PzWbn4Y6kt3kqhNgvyUv4zNKxAQ@mail.gmail.com>
 <1290102524-26493-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290102524-26493-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Thu, Nov 18, 2010, Claudio Takahasi wrote:
> Find by type operation is used by Discover Primary Service by Service
> UUID. Find By Type Value Response shall contain one or more group handles.
> ---
>  attrib/att.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
>  attrib/att.h |    7 +++++++
>  2 files changed, 53 insertions(+), 0 deletions(-)

Thanks for the update. This and the rest of your patches have been
pushed upstream.

Johan
