Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 0/4] android/handsfree-client: First set of HFP HF
Date: Tue, 11 Nov 2014 18:52:53 +0100
Message-Id: <1415728377-20880-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In this set service record, slc creation and incoming/outgoing
connection support has been added.

This code has been tested on UPF49.

v2:
* Handle Szymon comments
* Fix for checking codec negotiation support in 4/7

v3:
* fix for cleanup hfp_hf_server in case of sdp record creation failure.

Lukasz Rymanowski (4):
  android/handsfree-client: Add incoming connection handling
  android/handsfree-client: Add SLC creation procedure
  android/handsfree-client: Add support for outgoing connection
  android/handsfree-client: Handle disconnect command

 android/handsfree-client.c | 907 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 898 insertions(+), 9 deletions(-)

-- 
1.8.4

