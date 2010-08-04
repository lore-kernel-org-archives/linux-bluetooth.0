Return-Path: <cyrus@holtmann.org>
From: Inga Stotland <ingas@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: rshaffer@codeaurora.org,
	johan.hedberg@gmail.com,
	marcel@holtmann.org
Subject: [PATCH v6 0/7] Enhanced support for extended inquiry response
Date: Tue,  3 Aug 2010 17:03:50 -0700
Message-Id: <1280880237-2296-1-git-send-email-ingas@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

EIR needs to be updated whenever local SDP record database changes.
Previously, when an SDP record was added/removed/updated, EIR would 
be written in callback fired off HCI "Command Complete" event set off by
"Write Class Of Device" command. However, if the class of device did not
need to be updated, the EIR write was not happening either. This
implementation has been augmented to write new EIR when modification
in SDP database does not lead to updating of class of device.

Added support for UUID128 service descriptors in local EIR. 

Service UUIDs are written to "device properties" dictionary  when emitting
"Device Found" signal. This allows peek at available services offered by 
a remote device without establishing SDP connection.


-- 
Inga Stotland
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
