Return-Path: <cyrus@holtmann.org>
From: Frank Praznik <frank.praznik@oh.rr.com>
To: linux-bluetooth@vger.kernel.org
Cc: dh.herrmann@gmail.com, simon@mungewell.org
Subject: [PATCH 0/1] HIDP: Add a special case for the Dualshock 4
Date: Mon, 20 Jan 2014 18:37:01 -0500
Message-Id: <1390261022-3113-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds a special case in the HIDP core for the Dualshock 4 controller.
The controller only recognizes output reports with the report type 0x52 and 
only accepts reports sent via the ctrl channel. 

Unfortunately, this was the only way I could send data to the controller. I
looked around for alternatives, but adding a special case to the HIDP system
seemed to be the only way. If there is a way to set a custom report type and 
specify the channel without polluting the core with a device specific quirk 
I'll gladly use it.
