Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/2] Fix regression on suspend on opening
Date: Thu, 14 Oct 2010 15:35:28 +0300
Message-Id: <1287059730-10988-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This fixes regression when doing suspend on opening obex stream. If
obex_write_stream returns length of buffer, it is treated as error
reponse, which is not correct.

A typo is fixed in comments as well.

Br,
Dmitriy

