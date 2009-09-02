Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Sep 2009 13:06:50 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Daniel =?iso-8859-1?Q?=D6rstadius?= <daniel.orstadius@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] AVDTP start/stop handling during disconnection
Message-ID: <20090902100626.GA13592@jh-x301>
References: <eb7933e20908270824w2dc3ae2x8257d20d307ce6fd@mail.gmail.com> <2d5a2c100908271008v67bb1b86xa5ad5ef6e95ba49a@mail.gmail.com> <20090901070204.GA27211@jh-x301> <eb7933e20909010409x4b85fa1bt162e52ecce028310@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <eb7933e20909010409x4b85fa1bt162e52ecce028310@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Tue, Sep 01, 2009, Daniel Örstadius wrote:
> From 627850090c93152b8faa3e4a724df24dbc556d4e Mon Sep 17 00:00:00 2001
> From: Daniel Orstadius <daniel.orstadius@gmail.com>
> Date: Tue, 1 Sep 2009 13:55:44 +0300
> Subject: [PATCH] Reject AVDTP START/STOP when disconnecting
> 
> ---
>  audio/avdtp.c |   19 +++++++++++++++++--
>  1 files changed, 17 insertions(+), 2 deletions(-)

The patch has been pushed upstream. Thanks.

Johan
