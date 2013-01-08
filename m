Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v0 0/2] Media API clarifications
Date: Tue,  8 Jan 2013 10:41:03 +0100
Message-Id: <1357638065-19156-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The documentation of BlueZ 5.0 is lacking some details affecting the Media API, specially regarding the control of HFP/HSP volume.

There is no known implementation of MediaTransport1 at this point so updating the documentation with two new optional properties could be in practice done without updating the interface suffix.

Besides, the error codes returned by Acquire() and TryAcquire() are convenient to implement proper error logging in the client side.

Mikel Astiz (2):
  media: Add HFP/HSP gains to transport API
  media: Clarify Acquire/TryAcquire error cases

 doc/media-api.txt          | 32 +++++++++++++++++++++++++++++++-
 profiles/audio/transport.c |  2 +-
 2 files changed, 32 insertions(+), 2 deletions(-)

-- 
1.7.11.7

