Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 23 Aug 2010 17:42:08 +0800
Message-ID: <AANLkTinBBbDKwduE5A4OhLcXKVdnhkpnqFkf7PSqEEKv@mail.gmail.com>
Subject: data misalignment in l2cap_get_conf_opt
From: real mz <realmz6@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

 I met data misalignment exeception when using USB bt card. The fault
address is in l2cap_get_conf_opt() line 2296.
2290        switch (opt->len) {
2291        case 1:
2292                *val = *((u8 *) opt->val);
2293                break;
2294
2295        case 2:
2296                *val = __le16_to_cpu(*((__le16 *) opt->val));
2297                break;
2298
2299        case 4:
2300                *val = __le32_to_cpu(*((__le32 *) opt->val));
2301                break;

The address of opt->val is not 2-bytes aligned. actually this val is
read from conf_req[64] of struct l2cap_info, I think this opt->val can
not guarantee it is 2-bytes or 4-bytes aligned,
2296                *val = __le16_to_cpu(*((__le16 *) opt->val));
2300                *val = __le32_to_cpu(*((__le32 *) opt->val));
will cause misalignment fault in some processor that not support
unaligned access.

l2cap_pinfo struct:
 306struct l2cap_pinfo {
 307        struct bt_sock  bt;
 308        __le16          psm;
 309        __u16           dcid;
 310        __u16           scid;
 311
 312        __u16           imtu;
 313        __u16           omtu;
 314        __u16           flush_to;
 315        __u8            mode;
 316        __u8            num_conf_req;
 317        __u8            num_conf_rsp;
 318
 319        __u8            fcs;
 320        __u8            sec_level;
 321        __u8            role_switch;
 322        __u8            force_reliable;
 323
 324        __u8            conf_req[64];
...

Steven
