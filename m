Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Add API for creating gatt services
Date: Thu,  3 Apr 2014 11:43:54 +0200
Message-Id: <1396518234-8375-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1396518234-8375-1-git-send-email-marcin.kraglak@tieto.com>
References: <1396518234-8375-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Intoduce skeleton of API for creating services.
With this api it will be possible to reserve num of handles to services,
to start and stop them in runtime. In future implementation we can create
service abstraction also.
In future we can consider storing services on sorted list instead of
storing attributes on local_attribute_db.

Marcin Kraglak (1):
  gatt: Add API to manage services

 src/gatt.c | 38 ++++++++++++++++++++++++++++++++++
 src/gatt.h | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)

-- 
1.8.5.3

