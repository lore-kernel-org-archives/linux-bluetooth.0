Return-Path: <cyrus@holtmann.org>
Message-ID: <5433A1D0.4040803@xsilon.com>
Date: Tue, 07 Oct 2014 09:18:24 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Question on recv_pkt
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm trying to work out why the skb is cloned in recv_pkt in net/bluetooth/6lowpan.c when performing IPHC [0].  I would like to call process_data with an unshared skb as my proposal for the next patch is to use pskb_expand_head[1] in the decompression routine to save copying but this requires an skb with users == 1 otherwise it will call BUG().
In light of the locking problem Jukka was seeing with my previous patch I'm wondering if me removing this skb_clone was the cause so I want to make sure I know what it's there for before sending the patch.  Any help is appreciated.

- Martin.


[0]http://lxr.free-electrons.com/source/net/bluetooth/6lowpan.c#L258
[1]http://lxr.free-electrons.com/source/net/core/skbuff.c#L1037

