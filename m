Return-Path: <cyrus@holtmann.org>
From: Inga Stotland <ingas@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: rshaffer@codeaurora.org,
	marcel@holtmann.org,
	johan.hedberg@gmail.com
Subject: [PATCH v4 0/5] Enhanced support for extended inquiry response
Date: Thu, 22 Jul 2010 09:06:15 -0700
Message-Id: <1279814780-29673-1-git-send-email-ingas@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

EIR is updated whenever local SDP record database changes. 
Added support for UUID128 service descriptors in EIR to allow peek at available
services offered by a remote device without establishing SDP connection.  


-- 
Inga Stotland
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
