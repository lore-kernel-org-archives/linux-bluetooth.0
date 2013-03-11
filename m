Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Subject: Re: [PATCH v3 3/8] obexd: Read MAP client SDP attributes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1363014350-16114-4-git-send-email-christian.fetzer@oss.bmw-carit.de>
Date: Mon, 11 Mar 2013 09:12:37 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E6B535BC-0576-4D55-A373-B3597F7AE6FE@holtmann.org>
References: <1363014350-16114-1-git-send-email-christian.fetzer@oss.bmw-carit.de> <1363014350-16114-4-git-send-email-christian.fetzer@oss.bmw-carit.de>
To: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

> Parse SDP attributes mas_instance_id and supported_message_types from
> the transport's service attributes as soon as a connection is
> established.
> ---
> lib/sdp.h          |  2 ++
> obexd/client/map.c | 35 +++++++++++++++++++++++++++++++++--
> 2 files changed, 35 insertions(+), 2 deletions(-)

please stop mixing lib/ changes with anything else.

Actually any kind of patch that crosses multiple directories without having a really good reason for it is not a good idea. So do not do that.

Regards

Marcel

