Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/1] Fix suspend stream on opening if no data
Date: Wed, 13 Oct 2010 15:20:55 +0300
Message-Id: <1286972456-6168-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patch is to suspend obex stream on opening if there is no data
available yet to be sent. In such way unnecessary trafic is avoided
and IOP is improved with certain headsets. More specifically call
histories get requests from BH-902 are fixed.

Br,
Dmitriy

