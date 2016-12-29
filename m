Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Juha Kuikka <juha.kuikka@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: juha.kuikka@synapse.com, juha.kuikka@gmail.com,
        frank.praznik@gmail.com, roderick.colenbrander@sony.com
Subject: [PATCH v2 0/4] BlueZ: Add support for pairing the DS4 controller over USB
Date: Wed, 28 Dec 2016 16:32:39 -0800
Message-Id: <1482971563-15745-1-git-send-email-juha.kuikka@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set first refactors the sixaxis plugin to more easily support
multiple controllers with different protocols.

Secondly support for pairing the Dualshock 4 controller over USB is added.

Last, the PID of the new DS4 controller is added into the input device special
case handler which allows this controller to be used.

Juha Kuikka (4):
  sixaxis: Re-organize functions for refactoring
  sixaxis: Refactor to add device-specific functions
  sixaxis: Add support for pairing DS4 over USB
  Add new DS4 controller PID into special case handler

 plugins/sixaxis.c       | 293 ++++++++++++++++++++++++++++++++----------------
 profiles/input/server.c |   6 +-
 2 files changed, 202 insertions(+), 97 deletions(-)

-- 
2.7.4

