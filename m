Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <johan.hedberg@gmail.com>, <linux-bluetooth@vger.kernel.org>
CC: <padovan@profusion.mobi>
Date: Thu, 21 Apr 2011 13:02:12 +0300
Subject: RE: [PATCH v2 3/6] Bluetooth: Map sec_level to link key requirements
Message-ID: <99B09243E1A5DA4898CDD8B7001114481086306E70@EXMB04.eu.tieto.com>
References: <1303372461-11848-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1303372461-11848-3-git-send-email-waldemar.rymarkiewicz@tieto.com>
In-Reply-To: <1303372461-11848-3-git-send-email-waldemar.rymarkiewicz@tieto.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan, 

> /* Enable security */
> int hci_conn_security(struct hci_conn *conn, __u8 sec_level, 
>__u8 auth_type)  {

Just to clarify. This change modifies hciops behaviour, but it's not visible for the user.
In case of re-auth an extra authentication request is generated, but hciops will link_key_request_replay (key already exists, no check against pin len) on link_key_request.

As a result, connection will be accepted without any user notification.


Thanks,
Waldek