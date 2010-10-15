Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/2] Fix regression on suspend on opening
Date: Fri, 15 Oct 2010 09:57:06 +0300
Message-Id: <1287125828-5479-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This fixes regression when doing suspend on opening obex stream. If
obex_write_stream returns length of buffer, it is treated as an error
response later on, which is not correct.

Negative values returned by obex_write_stream are error codes, while
positive ones mean length of buffer. Positive values are never used
afterwards in the code. Therefore, due to this reason, and for being
compliant with obex_read_stream, which also returns 0 only, it was
decided to remove return of positive value representing length at all.

Result of such is also some code cleanup that removes unnecessary return
len when it is zero.

A typo is fixed in comments as well.

Br,
Dmitriy

