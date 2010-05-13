Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 May 2010 17:52:02 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Elvis =?iso-8859-1?Q?Pf=FCtzenreuter?= <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/1] Makes extract_svclass_uuid function public
Message-ID: <20100513145202.GA4699@jh-x301>
References: <1273757940-11045-1-git-send-email-epx@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1273757940-11045-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, May 13, 2010, Elvis Pfützenreuter wrote:
> This patch makes the extract_svclass_uuid function public,
> so it may be used by applications that link to libbluetooth.

If it's public it needs to be prefixed with sdp_. What's the usecase
where you need this?

Johan
