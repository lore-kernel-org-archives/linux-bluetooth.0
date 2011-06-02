Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH 0/5] Renewed new missed calls handling
Date: Thu,  2 Jun 2011 15:23:18 +0200
Message-Id: <1307021003-15418-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch series implements working means of sending application
parameters header before body while still using OpenOBEX body header
streaming, utilizing it in PBAP plugin.

First patch reverts changes that were meant to do the same, however did not
provide any change to what was being sent.
