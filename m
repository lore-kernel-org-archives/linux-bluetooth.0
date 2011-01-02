Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/4 v2] NewMissedCalls added for phonebook_pull
Date: Sun,  2 Jan 2011 19:20:37 +0200
Message-Id: <1293988841-10325-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This is updated version of previous sebmission. New attribute
uint16_t write_offset is added in this patch to struct obex_session
in obex-priv.h.

Meaning of write_offset is an offset within TX OBEX packet w.r.t.
begining of the send buffer. Naturally, this offset cannot be larger
than tx_mtu and therefore it is of the same type.

It is used only for OBEX packets that are assembled from headers of
different types. Those headers are marked with OBEX_FL_FIT_ONE_PACKET
flag.

BR,
Dmitriy

