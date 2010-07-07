Return-Path: <cyrus@holtmann.org>
From: Inga Stotland <ingas@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, marcel@holtmann.org,
	rshaffer@codeaurora.org
Subject: [PATCH v2 0/3] Enhanced support for extended inquiry response
Date: Wed,  7 Jul 2010 15:08:35 -0700
Message-Id: <1278540518-18620-1-git-send-email-ingas@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

EIR is updated whenever local SDP record database changes. 
Added support for UUID128 service descriptors in EIR to allow peek at available
services offered by a remote device without establishing SDP connection. 


-- 
Inga Stotland
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
