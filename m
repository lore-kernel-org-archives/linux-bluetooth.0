Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 Feb 2012 10:05:05 -0300
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: "Kumar, Sunil A" <sunil.a.kumar@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Nair, Rashmi G" <rashmi.g.nair@intel.com>,
	"Khanzode, Prashant" <prashant.khanzode@intel.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: Re: Response to AVRCP Passthrough Commands.
Message-ID: <20120228130505.GA4170@vader>
References: <8948CE8A2D1716449B389D5F68D4A30E02048F@FMSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8948CE8A2D1716449B389D5F68D4A30E02048F@FMSMSX108.amr.corp.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kumar,

* Kumar, Sunil A <sunil.a.kumar@intel.com> [2012-02-28 09:47:20 +0000]:

> Hi,
> 
> The passthrough command handler - handle_panel_passthrough - ends up responding with response code - ACCEPTED - in below mentioned cases whereas expected response code as per specification is different. Please find the cases and expected response code mentioned below. The document referred for specifying the expected response code is " AV/C Digital Interface Command Set General Specification Version 4.2" which is referred to in AVRCP specification.
> 
> 1- Command is supported by Bluez but the Media App doesn't support the same e.g. "FAST FORWARD" is supported by Bluez means present in " key_map" table but Android Froyo Media App doesn't support the same. 
> 	- As per point 5 of section "6.3 AV/C response rules" in above specified document, the expected response code is - NOT IMPLEMENTED. Here is the text for point 5 from document: " If the fields marked in the ck column of the command frame include the unsupported value, the target shall return a NOT IMPLEMENTED response."

As per current implementation, the application on top of BlueZ is
supposed to implement that commands.

> 
> 2- Command is supported by Bluez and the Media App. But, command can't be executed at this time because of an error e.g. "PLAY" is supported by Bluez and Media App but playback is not possible when Media App receives this command because of an error.
> 	- As per point 6 of section "6.3 AV/C response rules" in above specified document, the expected response code is - REJECTED. Here is the text for point 6 from document: " If the target can not execute the CONTROL, STATUS, or NOTIFY command, and a NOT IMPLEMENTED response would not be required for the command, the target shall return a REJECTED response."
> 
> 3- Command is not supported by Bluez itself, so doesn't matter whether Media App supports it or not. e.g. " key_map" table is modified to remove "FAST FORWARD". 
> 	- As per point 5 of section "6.3 AV/C response rules" in above specified document, the expected response code is - NOT IMPLEMENTED. Here is the text for point 5 from document: " If the fields marked in the ck column of the command frame include the unsupported value, the target shall return a NOT IMPLEMENTED response."

In this latter case it seems a bug indeed. Does the patch bellow fix the
issue for you?

> 
> Could someone help answering following queries:
> 	- What is the reason for Bluez to respond with response code - ACCEPTED - in these cases? Is this well thought of or just an issue? 

The last one is probably a bug. Could you test the patch and see if it
passes all related tests in PTS?

> 	- If this is not an issue, it shall be great help if you can provide the reasons for current implementation.

We use uinput here to send the commands. uinput is just like a keyboard
pressing that "media keys". The problem here is that there's no feedback
from the application if the command was accepted or not.

Luiz, what do you think?


> 	- If this is an issue, is there already a plan to correct it? We need to establish the mechanism wherein Bluez waits for response from client (Media App) whenever necessary (case 1 and 2 mentioned above) before sending response.

Unless we stop using uinput to use another mechanism to send the
commands to application, I don't see an easy way to fix it.


Regards,
Lucas De Marchi

---
Subject: AVCTP: return not-implemented for unknown passthrough command

diff --git a/audio/avctp.c b/audio/avctp.c
index 5bd5db1..e36353d 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -235,9 +235,12 @@ static size_t handle_panel_passthrough(struct avctp *session,
 		break;
 	}
 
-	if (key_map[i].name == NULL)
+	if (key_map[i].name == NULL) {
 		DBG("AV/C: unknown button 0x%02X %s",
 						operands[0] & 0x7F, status);
+		*code = AVC_CTYPE_NOT_IMPLEMENTED;
+		return 0;
+	}
 
 done:
 	*code = AVC_CTYPE_ACCEPTED;
