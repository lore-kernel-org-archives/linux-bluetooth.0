Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 9 Nov 2010 15:18:35 +0800
Message-ID: <AANLkTimThap03_iYvxYyw39HOkMRAzzkscKjGMwmY7dX@mail.gmail.com>
Subject: I think we should add GoepL2capPsm attribute in sdp.h
From: hui li <nami.li1984@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently there is no GoepL2capPsm attribute value in sdp.h, I think
we should add this to supprot GOEP v2.0.
Maybe we can add
#define SDP_ATTR_GOEP_L2CAP_PSM			0x0200
in sdp.h.
