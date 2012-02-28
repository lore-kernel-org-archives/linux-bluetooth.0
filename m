Return-Path: <cyrus@holtmann.org>
From: "Kumar, Sunil A" <sunil.a.kumar@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "Nair, Rashmi G" <rashmi.g.nair@intel.com>,
	"Khanzode, Prashant" <prashant.khanzode@intel.com>
Subject: Response to AVRCP Passthrough Commands.
Date: Tue, 28 Feb 2012 09:47:20 +0000
Message-ID: <8948CE8A2D1716449B389D5F68D4A30E02048F@FMSMSX108.amr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

The passthrough command handler - handle_panel_passthrough - ends up responding with response code - ACCEPTED - in below mentioned cases whereas expected response code as per specification is different. Please find the cases and expected response code mentioned below. The document referred for specifying the expected response code is " AV/C Digital Interface Command Set General Specification Version 4.2" which is referred to in AVRCP specification.

1- Command is supported by Bluez but the Media App doesn't support the same e.g. "FAST FORWARD" is supported by Bluez means present in " key_map" table but Android Froyo Media App doesn't support the same. 
	- As per point 5 of section "6.3 AV/C response rules" in above specified document, the expected response code is - NOT IMPLEMENTED. Here is the text for point 5 from document: " If the fields marked in the ck column of the command frame include the unsupported value, the target shall return a NOT IMPLEMENTED response."

2- Command is supported by Bluez and the Media App. But, command can't be executed at this time because of an error e.g. "PLAY" is supported by Bluez and Media App but playback is not possible when Media App receives this command because of an error.
	- As per point 6 of section "6.3 AV/C response rules" in above specified document, the expected response code is - REJECTED. Here is the text for point 6 from document: " If the target can not execute the CONTROL, STATUS, or NOTIFY command, and a NOT IMPLEMENTED response would not be required for the command, the target shall return a REJECTED response."

3- Command is not supported by Bluez itself, so doesn't matter whether Media App supports it or not. e.g. " key_map" table is modified to remove "FAST FORWARD". 
	- As per point 5 of section "6.3 AV/C response rules" in above specified document, the expected response code is - NOT IMPLEMENTED. Here is the text for point 5 from document: " If the fields marked in the ck column of the command frame include the unsupported value, the target shall return a NOT IMPLEMENTED response."

Could someone help answering following queries:
	- What is the reason for Bluez to respond with response code - ACCEPTED - in these cases? Is this well thought of or just an issue? 
	- If this is not an issue, it shall be great help if you can provide the reasons for current implementation.
	- If this is an issue, is there already a plan to correct it? We need to establish the mechanism wherein Bluez waits for response from client (Media App) whenever necessary (case 1 and 2 mentioned above) before sending response.

Please let me know if you need more information in order to answer the queries.
Thanks.

Best Regards
Sunil Kumar  
