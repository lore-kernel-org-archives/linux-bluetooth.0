Return-Path: <cyrus@holtmann.org>
Date: Mon, 3 Jan 2011 12:39:00 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/4 v2] NewMissedCalls added for phonebook_pull
Message-ID: <20110103103900.GA9742@jh-x301>
References: <1293988841-10325-1-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1293988841-10325-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Sun, Jan 02, 2011, Dmitriy Paliy wrote:
> This is updated version of previous sebmission. New attribute
> uint16_t write_offset is added in this patch to struct obex_session
> in obex-priv.h.
> 
> Meaning of write_offset is an offset within TX OBEX packet w.r.t.
> begining of the send buffer. Naturally, this offset cannot be larger
> than tx_mtu and therefore it is of the same type.
> 
> It is used only for OBEX packets that are assembled from headers of
> different types. Those headers are marked with OBEX_FL_FIT_ONE_PACKET
> flag.

All four patches (v3 of 2/4) have been pushed upstream. Thanks.

Johan
