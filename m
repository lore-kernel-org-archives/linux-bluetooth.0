Return-Path: <cyrus@holtmann.org>
From: Inga Stotland <ingas@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: rshaffer@codeaurora.org,
	johan.hedberg@gmail.com,
	marcel@holtmann.org
Subject: [PATCH 0/3] Parsing of AMP related HCI commands and events 
Date: Wed, 18 Aug 2010 16:38:51 -0700
Message-Id: <1282174734-1314-1-git-send-email-ingas@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Added support for interpreting of the following HCI commands:

Create Physical Link,
Accept Physical Link,
Disconnect Physical Link,
Create Logical Link,
Accept Logical Link,
Disconnect Logical Link,
Logical Link Cancel,
Flow Spec Modify,
Read Encryption Key Size,
Read Local AMP Info,
Read Local AMP ASSOC,
Write Remote AMP ASSOC

and HCI events:

Physical Link Complete,
Disconnect Physical Link Complete,
Physical Link Loss Early Warning,
Physical Link Recovery,
Logical Link Complete,
Disconnect Logical Link Complete,
Flow Spec Modify Complete

 
-- 
Inga Stotland
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
