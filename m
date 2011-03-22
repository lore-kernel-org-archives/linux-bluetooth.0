Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org, johan.hedberg@nokia.com
Subject: [PATCH 0/1 v2] Add release all sessions when adapter is switched off
Date: Tue, 22 Mar 2011 13:46:57 +0200
Message-Id: <1300794418-453-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This is updated version to previous submission where more detailed comments
are added explaining why g_slist_free is not called after g_slist_foreach,
and second space is removed.

BR,
Dmitriy

