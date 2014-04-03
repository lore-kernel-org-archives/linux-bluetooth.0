Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Apr 2014 10:22:38 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v0] attrib: Improve Attribute Data length checking
Message-ID: <20140403072238.GB19304@t440s.lan>
References: <1396373610-28223-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1396373610-28223-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Tue, Apr 01, 2014, Claudio Takahasi wrote:
> According to Core SPEC, attribute data list must be grouped in elements
> of the same size.
> ---
>  attrib/gatt.c | 40 +++++++++++++++++-----------------------
>  1 file changed, 17 insertions(+), 23 deletions(-)

Applied. Thanks.

Johan
