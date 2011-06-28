Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@gmail.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: [PATCH obexd v2 0/4] Add adapter session request/release to obex-client
Date: Wed, 29 Jun 2011 00:40:38 +0300
Message-Id: <1309297242-4154-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Luiz, thanks for the detailed review. However, I'm not sure that
fully understood you. Whole idea was to request session before
transfer and release it afterwards. Therefore, still I would like
to have adapter ReleaseSession.

Please, see subsequent patches if those reflect your comments.

BR,
Dmitriy

