Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4 v3] Add aparams to pbap_object in pbap.c 
Date: Mon,  3 Jan 2011 12:05:17 +0200
Message-Id: <1294049118-5835-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

array_read function has to be static, which is fixed in this
version of the patch.

BR,
Dmitriy

