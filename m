Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ruslan Mstoi <ruslan.mstoi@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Updated AVRCP PICS and PIXITs for PTS 5.3
Date: Wed, 08 Oct 2014 15:20:43 +0200
Message-ID: <1902263.zaP8kZgXKb@uw000953>
In-Reply-To: <1412760639-6280-1-git-send-email-ruslan.mstoi@linux.intel.com>
References: <1412760639-6280-1-git-send-email-ruslan.mstoi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ruslan,

On Wednesday 08 of October 2014 12:30:39 Ruslan Mstoi wrote:
> ---
>  android/pics-avrcp.txt  | 95 +++++++++++++++++++++++++++----------------------
>  android/pixit-avrcp.txt |  2 +-
>  android/pts-avrcp.txt   |  4 +--
>  3 files changed, 55 insertions(+), 46 deletions(-)
> 
> diff --git a/android/pics-avrcp.txt b/android/pics-avrcp.txt
> index f339689..da72fe1 100644
> --- a/android/pics-avrcp.txt
> +++ b/android/pics-avrcp.txt
> @@ -1,6 +1,6 @@
>  AVRCP PICS for the PTS tool.
>  
> -PTS version: 5.2
> +PTS version: 5.3
>  
>  * - different than PTS defaults
>  # - not yet implemented/supported
> @@ -12,8 +12,8 @@ O - optional
>  -------------------------------------------------------------------------------
>  Parameter Name    Selected	Description
>  -------------------------------------------------------------------------------
> -SPC_AVRCP_1_1     True		Role: Controller (CT) (C.1)
> -TSPC_AVRCP_1_2    True		Role: Target (TG) (C.1)
> +SPC_AVRCP_1_1     True (*)	Role: Controller (CT) (C.1)
> +TSPC_AVRCP_1_2    True (*)	Role: Target (TG) (C.1)
>  -------------------------------------------------------------------------------
>  C.1: Mandatory to support at least one of the defined roles.
>  -------------------------------------------------------------------------------
> @@ -29,7 +29,7 @@ TSPC_AVRCP_2_3    False (*)	CT: Initiating connection release (M)
>  TSPC_AVRCP_2_4    False (*)	CT: Accepting connection release (M)
>  TSPC_AVRCP_2_5    False		CT: Sending UNIT INFO (O)
>  TSPC_AVRCP_2_6    False		CT: Sending SUBUNIT INFO (O)
> -TSPC_AVRCP_2_7    False (*)	CT: Sending PASS THROUGH command category 1
> +TSPC_AVRCP_2_7    False	CT: Sending PASS THROUGH command category 1
>  					(C.1)
>  TSPC_AVRCP_2_8    False		CT: Sending PASS THROUGH command category 2
>  					(C.1)
> @@ -161,9 +161,9 @@ TSPC_AVRCP_3_16   False		CT: category 1 - Operation id:
>  					display_information (C.1)
>  TSPC_AVRCP_3_17   False		CT: category 1 - Operation id: help (C.1)
>  TSPC_AVRCP_3_18   False		CT: category 1 - Operation id: power (C.1)
> -TSPC_AVRCP_3_19   False (*)	CT: category 1 - Operation id: play (C.1)
> -TSPC_AVRCP_3_20   False (*)	CT: category 1 - Operation id: stop (C.1)
> -TSPC_AVRCP_3_21   False (*)	CT: category 1 - Operation id: pause (C.1)
> +TSPC_AVRCP_3_19   False		CT: category 1 - Operation id: play (C.1)
> +TSPC_AVRCP_3_20   False		CT: category 1 - Operation id: stop (C.1)
> +TSPC_AVRCP_3_21   False		CT: category 1 - Operation id: pause (C.1)
>  TSPC_AVRCP_3_22   False		CT: category 1 - Operation id: record (C.1)
>  TSPC_AVRCP_3_23   False		CT: category 1 - Operation id: rewind (C.1)
>  TSPC_AVRCP_3_24   False		CT: category 1 - Operation id: fast_forward
> @@ -211,8 +211,8 @@ TSPC_AVRCP_4_16   False		CT: category 2 - Operation id:
>  					display_information (C.2)
>  TSPC_AVRCP_4_17   False		CT: category 2 - Operation id: help (C.2)
>  TSPC_AVRCP_4_18   False		CT: category 2 - Operation id: power (C.2)
> -TSPC_AVRCP_4_19   False (*)	CT: category 2 - Operation id: volume_up (C.2)
> -TSPC_AVRCP_4_20   False (*)	CT: category 2 - Operation id: volume_down (C.2)
> +TSPC_AVRCP_4_19   False		CT: category 2 - Operation id: volume_up (C.2)
> +TSPC_AVRCP_4_20   False		CT: category 2 - Operation id: volume_down (C.2)
>  TSPC_AVRCP_4_21   False		CT: category 2 - Operation id: mute (C.2)
>  TSPC_AVRCP_4_22   False		CT: category 2 - Operation id: F1 (C.2)
>  TSPC_AVRCP_4_23   False		CT: category 2 - Operation id: F2 (C.2)
> @@ -330,11 +330,11 @@ Parameter Name    Selected	Description
>  -------------------------------------------------------------------------------
>  TSPC_AVRCP_7_1    True (*)	TG: Initiating connection establishment (O)
>  TSPC_AVRCP_7_2    True		TG: Accept connection establishment (M)
> -TSPC_AVRCP_7_3    True		TG: Initiating connection release (M)
> +TSPC_AVRCP_7_3    True (*)	TG: Initiating connection release (M)
>  TSPC_AVRCP_7_4    True		TG: Accepting connection release (M)
>  TSPC_AVRCP_7_5    True		TG: Receiving UNIT INFO (M)
>  TSPC_AVRCP_7_6    True		TG: Receiving SUBUNIT INFO (M)
> -TSPC_AVRCP_7_7    True		TG: Receiving PASS THROUGH command category 1
> +TSPC_AVRCP_7_7    True (*)	TG: Receiving PASS THROUGH command category 1
>  					(C.1)
>  TSPC_AVRCP_7_8    True (*)	TG: Receiving PASS THROUGH command category 2
>  					(C.1)
> @@ -414,10 +414,9 @@ TSPC_AVRCP_7_65   True		TG: Discoverable Mode (M)
>  TSPC_AVRCP_7_66   False		TG: PASSTHROUGH operation supporting press
>  					and hold (O)
>  TSPC_AVRCP_7_67   False		TG: Cover Art (O)
> -TSPC_AVRCP_7_68   False		TG: GetCapabilities, Cover Art (C.12)
> -TSPC_AVRCP_7_69   False		TG: GetImageProperties, Cover Art (C.12)
> -TSPC_AVRCP_7_70   False		TG: GetImage, Cover Art (C.12)
> -TSPC_AVRCP_7_71   False		TG: GetLinkedThumbnail, Cover Art (C.12)
> +TSPC_AVRCP_7_68   False		TG: GetImageProperties, Cover Art (C.16)
> +TSPC_AVRCP_7_69   False		TG: GetImage, Cover Art (C.16)
> +TSPC_AVRCP_7_70   False		TG: GetLinkedThumbnail, Cover Art (C.16)
>  -------------------------------------------------------------------------------
>  C.1: Mandatory to support at least one of the categories. Supported
>  	operation_id's are shown in Table 8 to Table 11.
> @@ -482,7 +481,7 @@ TSPC_AVRCP_8_17   False		TG: category 1 - Operation id: help (O)
>  TSPC_AVRCP_8_18   False		TG: category 1 - Operation id: power (O)
>  TSPC_AVRCP_8_19   True		TG: category 1 - Operation id: play (M)
>  TSPC_AVRCP_8_20   True		TG: category 1 - Operation id: stop (M)
> -TSPC_AVRCP_8_21   True		TG: category 1 - Operation id: pause (O)
> +TSPC_AVRCP_8_21   True (*)	TG: category 1 - Operation id: pause (O)
>  TSPC_AVRCP_8_22   False		TG: category 1 - Operation id: record (O)
>  TSPC_AVRCP_8_23   True (*)	TG: category 1 - Operation id: rewind (O)
>  TSPC_AVRCP_8_24   True (*)	TG: category 1 - Operation id: fast forward (O)
> @@ -495,8 +494,8 @@ TSPC_AVRCP_8_30   False		TG: category 1 - Operation id: F1 (O)
>  TSPC_AVRCP_8_31   False		TG: category 1 - Operation id: F2 (O)
>  TSPC_AVRCP_8_32   False		TG: category 1 - Operation id: F3 (O)
>  TSPC_AVRCP_8_33   False		TG: category 1 - Operation id: F4 (O)
> -TSPC_AVRCP_8_33a  False		TG: category 1 - Operation id: F5 (O)
> -TSPC_AVRCP_8_34   False		TG: category 1 - Operation id: vendor unique (O)
> +TSPC_AVRCP_8_34   False		TG: category 1 - Operation id: F5 (O)
> +TSPC_AVRCP_8_35   False		TG: category 1 - Operation id: vendor unique (O)
>  -------------------------------------------------------------------------------
>  
>  
> @@ -526,12 +525,12 @@ TSPC_AVRCP_9_18	  False		TG: category 2 - Operation id: power (O)
>  TSPC_AVRCP_9_19   True		TG: category 2 - Operation id: volume up (C.2)
>  TSPC_AVRCP_9_20   True		TG: category 2 - Operation id: volume down (C.2)
>  TSPC_AVRCP_9_21   False		TG: category 2 - Operation id: mute (O)
> -TSPC_AVRCP_9_24   False		TG: category 2 - Operation id: F1 (O)
> -TSPC_AVRCP_9_25   False		TG: category 2 - Operation id: F2 (O)
> -TSPC_AVRCP_9_26   False		TG: category 2 - Operation id: F3 (O)
> -TSPC_AVRCP_9_27   False		TG: category 2 - Operation id: F4 (O)
> -TSPC_AVRCP_9_27a  False		TG: category 2 - Operation id: F5 (O)
> -TSPC_AVRCP_9_28   False		TG: category 2 - Operation id: vendor unique (O)
> +TSPC_AVRCP_9_22   False		TG: category 2 - Operation id: F1 (O)
> +TSPC_AVRCP_9_23   False		TG: category 2 - Operation id: F2 (O)
> +TSPC_AVRCP_9_24   False		TG: category 2 - Operation id: F3 (O)
> +TSPC_AVRCP_9_25   False		TG: category 2 - Operation id: F4 (O)
> +TSPC_AVRCP_9_26   False		TG: category 2 - Operation id: F5 (O)
> +TSPC_AVRCP_9_27   False		TG: category 2 - Operation id: vendor unique (O)
>  -------------------------------------------------------------------------------
>  C.2: Mandatory to support if the device supports category 2 (TSPC_AVRCP_7_8).
>  -------------------------------------------------------------------------------
> @@ -554,8 +553,8 @@ TSPC_AVRCP_10_10  False		TG: category 3 - Operation id: 9 (O)
>  TSPC_AVRCP_10_11  False		TG: category 3 - Operation id: dot (O)
>  TSPC_AVRCP_10_12  False		TG: category 3 - Operation id: enter (O)
>  TSPC_AVRCP_10_13  False		TG: category 3 - Operation id: clear (O)
> -TSPC_AVRCP_10_14  False		TG: category 3 - Operation id: channel up (C.3)
> -TSPC_AVRCP_10_15  False		TG: category 3 - Operation id: channel down
> +TSPC_AVRCP_10_14  False (*)		TG: category 3 - Operation id: channel up (C.3)
> +TSPC_AVRCP_10_15  False (*)		TG: category 3 - Operation id: channel down
>  					(C.3)
>  TSPC_AVRCP_10_16  False		TG: category 3 - Operation id: previous channel
>  					(O)
> @@ -565,14 +564,14 @@ TSPC_AVRCP_10_19  False		TG: category 3 - Operation id: display
>  					information (O)
>  TSPC_AVRCP_10_20  False		TG: category 3 - Operation id: help (O)
>  TSPC_AVRCP_10_21  False		TG: category 3 - Operation id: power (O)
> -TSPC_AVRCP_10_21a False		TG: category 3 - Operation id: angle (O)
> -TSPC_AVRCP_10_21b False		TG: category 3 - Operation id: subpicture (O)
> -TSPC_AVRCP_10_22  False		TG: category 3 - Operation id: F1 (O)
> -TSPC_AVRCP_10_23  False		TG: category 3 - Operation id: F2 (O)
> -TSPC_AVRCP_10_24  False		TG: category 3 - Operation id: F3 (O)
> -TSPC_AVRCP_10_25  False		TG: category 3 - Operation id: F4 (O)
> -TSPC_AVRCP_10_25a False		TG: category 3 - Operation id: F5 (O)
> -TSPC_AVRCP_10_26  False		TG: category 3 - Operation id: vendor unique (O)
> +TSPC_AVRCP_10_22  False		TG: category 3 - Operation id: angle (O)
> +TSPC_AVRCP_10_23  False		TG: category 3 - Operation id: subpicture (O)
> +TSPC_AVRCP_10_24  False		TG: category 3 - Operation id: F1 (O)
> +TSPC_AVRCP_10_25  False		TG: category 3 - Operation id: F2 (O)
> +TSPC_AVRCP_10_26  False		TG: category 3 - Operation id: F3 (O)
> +TSPC_AVRCP_10_27  False		TG: category 3 - Operation id: F4 (O)
> +TSPC_AVRCP_10_28  False		TG: category 3 - Operation id: F5 (O)
> +TSPC_AVRCP_10_29  False		TG: category 3 - Operation id: vendor unique (O)
>  -------------------------------------------------------------------------------
>  C.3: Mandatory to support if the device supports category 3 (TSPC_AVRCP_7_9).
>  -------------------------------------------------------------------------------
> @@ -582,16 +581,16 @@ C.3: Mandatory to support if the device supports category 3 (TSPC_AVRCP_7_9).
>  -------------------------------------------------------------------------------
>  Parameter Name    Selected	Description
>  -------------------------------------------------------------------------------
> -TSPC_AVRCP_11_1   False		TG: category 4 - Operation id: select (C.4)
> -TSPC_AVRCP_11_2   False		TG: category 4 - Operation id: up (C.4)
> -TSPC_AVRCP_11_3   False		TG: category 4 - Operation id: down (C.4)
> -TSPC_AVRCP_11_4   False		TG: category 4 - Operation id: left (C.4)
> -TSPC_AVRCP_11_5   False		TG: category 4 - Operation id: right (C.4)
> +TSPC_AVRCP_11_1   False (*)		TG: category 4 - Operation id: select (C.4)
> +TSPC_AVRCP_11_2   False (*)		TG: category 4 - Operation id: up (C.4)
> +TSPC_AVRCP_11_3   False (*)		TG: category 4 - Operation id: down (C.4)
> +TSPC_AVRCP_11_4   False (*)		TG: category 4 - Operation id: left (C.4)
> +TSPC_AVRCP_11_5   False (*)		TG: category 4 - Operation id: right (C.4)
>  TSPC_AVRCP_11_6   False		TG: category 4 - Operation id: right up (O)
>  TSPC_AVRCP_11_7   False		TG: category 4 - Operation id: right down (O)
>  TSPC_AVRCP_11_8   False		TG: category 4 - Operation id: left up (O)
>  TSPC_AVRCP_11_9   False		TG: category 4 - Operation id: left down (O)
> -TSPC_AVRCP_11_10  False		TG: category 4 - Operation id: root menu (C.4)
> +TSPC_AVRCP_11_10  False (*)		TG: category 4 - Operation id: root menu (C.4)
>  TSPC_AVRCP_11_11  False		TG: category 4 - Operation id: setup menu (O)
>  TSPC_AVRCP_11_12  False		TG: category 4 - Operation id: contents menu (O)
>  TSPC_AVRCP_11_13  False		TG: category 4 - Operation id: favorite menu (O)
> @@ -618,9 +617,19 @@ TSPC_AVRCP_11_33  False		TG: category 4 - Operation id: F1 (O)
>  TSPC_AVRCP_11_34  False		TG: category 4 - Operation id: F2 (O)
>  TSPC_AVRCP_11_35  False		TG: category 4 - Operation id: F3 (O)
>  TSPC_AVRCP_11_36  False		TG: category 4 - Operation id: F4 (O)
> -TSPC_AVRCP_11_36a False		TG: category 4 - Operation id: F5 (O)
> -TSPC_AVRCP_11_37  False		TG: category 4 - Operation id: vendor unique (O)
> -TSPC_AVRCP_ALL    False		Enables all test cases when set to TRUE.
> +TSPC_AVRCP_11_37  False		TG: category 4 - Operation id: F5 (O)
> +TSPC_AVRCP_11_38  False		TG: category 4 - Operation id: vendor unique (O)
> +
> +TSPC_AVRCP_12_1   True			General discoverable mode
> +TSPC_AVRCP_13_1   True			General discoverable mode
> +TSPC_AVRCP_14_1   False		OBEX Connect operation (C.1)
> +TSPC_AVRCP_14_2   False		OBEX Get operation (C.1)
> +TSPC_AVRCP_14_3   False		OBEX Disconnect operation (C.1)
> +TSPC_AVRCP_15_1   False		OBEX Connect operation (C.1)
> +TSPC_AVRCP_15_2   False		OBEX Get operation (C.1)
> +TSPC_AVRCP_15_3   False		OBEX Disconnect operation (C.1)
> +
> +TSPC_ALL          False		Enables all test cases when set to TRUE.
>  -------------------------------------------------------------------------------
>  C.4: Mandatory to support if the device supports category 4 (TSPC_AVRCP_7_10).
>  -------------------------------------------------------------------------------
> diff --git a/android/pixit-avrcp.txt b/android/pixit-avrcp.txt
> index 7ab5f18..f576bd0 100644
> --- a/android/pixit-avrcp.txt
> +++ b/android/pixit-avrcp.txt
> @@ -1,6 +1,6 @@
>  AVRCP PIXIT for the PTS tool.
>  
> -PTS version: 5.2
> +PTS version: 5.3
>  
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> diff --git a/android/pts-avrcp.txt b/android/pts-avrcp.txt
> index c8663be..c8aeeca 100644
> --- a/android/pts-avrcp.txt
> +++ b/android/pts-avrcp.txt
> @@ -1,7 +1,7 @@
>  PTS test results for AVRCP
>  
> -PTS version: 5.2
> -Tested: 15-July-2014
> +PTS version: 5.3
> +Tested: 08-October-2014
>  Android version: 4.4.4
>  
>  Results:
> 

Patch applied. Thanks.

-- 
Best regards, 
Szymon Janc
