Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Apr 2011 16:48:25 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add ERROR code response to ATD in maemo6 telephony
Message-ID: <20110401134825.GC24588@jh-x301>
References: <1301659554-2773-1-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1301659554-2773-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Fri, Apr 01, 2011, Dmitriy Paliy wrote:
> ERROR code response is added to ATD command in maemo6 telephony driver
> based on HFP 1.5 specification, page 68:
> "Standard error indication code. It shall be issued on detection of any
> syntax, format or procedure error condition."
> ---
>  audio/telephony-maemo6.c |   12 ++++--------
>  1 files changed, 4 insertions(+), 8 deletions(-)

Pushed upstream. Thanks.

Johan
