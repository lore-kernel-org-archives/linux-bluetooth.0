Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@gmail.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: [RFC] Add adapter session request/release to obex-client
Date: Tue, 28 Jun 2011 00:39:35 +0300
Message-Id: <1309210781-2674-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This set of patches adds system bus connection to obex-client and
handling of adapter's method calls, among others, as
RequestSession and ReleaseSession.

Such ensures OBEX transfers done within a single adapter session,
which in turn significantly simplifies file transfer API for clients
of obex-client.

Any comments would be appreciated.

BR,
Dmitriy

