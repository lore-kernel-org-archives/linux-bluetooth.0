Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Add new method - service discovery to mgmt 
Date: Thu, 23 Oct 2014 10:15:34 -0700
Message-Id: <1414084535-23864-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This path adds start service discovery and stop service discovery methods.
Path for BlueZ that uses those new methods will follow.
