Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org, johan.hedberg@nokia.com
Subject: [PATCH 0/1 v3] Add release all sessions when adapter is switched off
Date: Tue, 22 Mar 2011 14:29:06 +0200
Message-Id: <1300796947-1518-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This proposal includes also comment in the code on why g_slist_free is not
used after g_slist_foreach.

Br,
Dmitriy

