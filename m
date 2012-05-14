Return-Path: <cyrus@holtmann.org>
Message-ID: <1336964326.5970.238.camel@aeonflux>
Subject: Re: [PATCH 2/4] monitor: add device filter support
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Sun, 13 May 2012 19:58:46 -0700
In-Reply-To: <1336753132-8282-2-git-send-email-gustavo@padovan.org>
References: <1336753132-8282-1-git-send-email-gustavo@padovan.org>
	 <1336753132-8282-2-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> -i hciX option will show only data from the specified device
> ---
>  monitor/main.c   |   12 ++++++++++--
>  monitor/packet.c |   10 +++++++++-
>  monitor/packet.h |    2 +-
>  3 files changed, 20 insertions(+), 4 deletions(-)

so what is this option actually good for? I think it is the wrong
approach for dealing with this.

We better have some generic filtering mechanism, then trying to just
duplicate options from hcidump into btmon.

btmon is different in the fact that it is actually able to record all
packets from all devices. You also do not wanna filter based on index
number. You wanna filter based on BD_ADDR and BR/EDR vs AMP.

Regards

Marcel


