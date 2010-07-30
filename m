Return-Path: <cyrus@holtmann.org>
From: Inga Stotland <ingas@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: rshaffer@codeaurora.org, johan.hedberg@gmail.com,
	marcel@holtmann.org
Subject: Enhancements to allow l2cap channel to use either AMP or BR/EDR
Date: Fri, 30 Jul 2010 11:30:22 -0700
Message-Id: <1280514626-22559-1-git-send-email-ingas@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

AMP vs BR/EDR preference for L2CAP channel can be configured as 
command line argument using new option "-J". Possible values: 
                 "require_br_edr", 
                 "prefer_amp", 
                 "prefer_br_edr"
If no preference indicated, the default is set to require BR/EDR. 

Additionally, this option can be changed during  runtime when L2CAP 
connection is up by entering the following keys from standard input:   
         "a", "A" - prefer AMP;
         "b", "B" - prefer BR/EDR;
         "r", "R" - require BR/EDR
This allows dynamic L2CAP channel move between BR/EDR and AMP.


--
Inga Stotland
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
