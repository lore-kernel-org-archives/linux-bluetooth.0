Return-Path: <cyrus@holtmann.org>
From: Inga Stotland <ingas@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: rshaffer@codeaurora.org, johan.hedberg@gmail.com,
	marcel@holtmann.org
Subject: [PATCH v3 0/5] Enhanced support for extended inquiry response
Date: Tue, 20 Jul 2010 14:56:09 -0700
Message-Id: <1279662974-16454-1-git-send-email-ingas@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

EIR is updated whenever local SDP record database changes. 
Added support for UUID128 service descriptors in EIR to allow peek at available
services offered by a remote device without establishing SDP connection.

-- 
Inga Stotland
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

