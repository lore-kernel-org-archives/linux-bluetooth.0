Return-Path: <cyrus@holtmann.org>
From: Greg Hazel <ghazel@gmail.com>
Content-Type: text/plain; charset=us-ascii
Subject: BT_AMP_POLICY and RFCOMM
Date: Mon, 23 Jan 2012 20:15:16 -0800
Message-Id: <D0339DC2-78B0-427D-9FC3-704725A88020@gmail.com>
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Apple Message framework v1251.1)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm trying to set BT_AMP_POLICY on an RFCOMM socket to BT_AMP_POLICY_PREFER_AMP. In return I'm getting "Operation not supported on transport endpoint" (errno 95). Glancing at the code, it looks like RFCOMM sockets do not handle BT_AMP_POLICY, and the default policy for the underlying L2CAP socket is BT_AMP_POLICY_REQUIRE_BR_EDR. However, the L2CAP socket is L2CAP_MODE_ERTM, so my expectation is that it would work to use AMP.

So, why was BT_AMP_POLICY left out for RFCOMM sockets? Was it simply an oversight?

-Greg

