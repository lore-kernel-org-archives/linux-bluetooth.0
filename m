Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Adjust PICS and PIXITs for OPP
Date: Mon, 07 Apr 2014 11:39:54 +0200
Message-ID: <16634526.Byy7RHjf0o@uw000953>
In-Reply-To: <1396515551-13996-1-git-send-email-sebastian.chlad@tieto.com>
References: <1396515551-13996-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Thursday 03 of April 2014 10:59:11 Sebastian Chlad wrote:
> Adjusting PICS and PIXITs for OPP on PTS 5.1
> ---
>  android/pics-opp.txt  | 113 +++++++++++++++++++++++++-------------------------
>  android/pixit-opp.txt |  24 +++++------
>  2 files changed, 69 insertions(+), 68 deletions(-)
> 
> diff --git a/android/pics-opp.txt b/android/pics-opp.txt
> index cd4acce..0a5919e 100644
> --- a/android/pics-opp.txt
> +++ b/android/pics-opp.txt
> @@ -1,6 +1,6 @@
>  OPP PICS for the PTS tool.
>  
> -PTS version: 5.0
> +PTS version: 5.1
>  
>  * - different than PTS defaults
>  # - not yet implemented/supported
> @@ -12,10 +12,10 @@ O - optional
>  -------------------------------------------------------------------------------
>  Parameter Name	Selected	Description
>  -------------------------------------------------------------------------------
> -TSPC_OPP_1_1	True (*)	Role: Object Push Client.
> -TSPC_OPP_1_2	True (*)	Role: Object Push Server.
> +TSPC_OPP_1_1	True (*)	Role: Object Push Client (C.1)
> +TSPC_OPP_1_2	True (*)	Role: Object Push Server (C.1)

TSPC_OPP_1b_1 and TSPC_OPP_1b_2 seem to be missing, those define supported
profile version.

>  -------------------------------------------------------------------------------
> -C.1: It is Mandatory to Support at least one of the defined roles.
> +C.1: Mandatory to support at least one of the defined roles.
>  -------------------------------------------------------------------------------

>  
>  
> @@ -34,23 +34,18 @@ C.1: It is mandatory to support at least one of the profile versions.
>  -------------------------------------------------------------------------------
>  Parameter Name	Selected	Description
>  -------------------------------------------------------------------------------
> -TSPC_OPP_2_1	True		Client: Perform Service Discovery request.
> -					(M.1)
> +TSPC_OPP_2_1	True		Client: Perform Service Discovery request (M)
>  TSPC_OPP_2_2	True		Client: Authentication/PIN exchange supported.
> -					(M.1)
> +					(M)
>  TSPC_OPP_2_2a	True (*)	Client: Require Authentication/PIN by default.
>  					(O)
> -TSPC_OPP_2_3	True		Client: Object Push is supported. (M.1)
> -TSPC_OPP_2_4	True (*)	Client: vCard 2.1 format is supported for
> -					Object Push. (C.3)
> -TSPC_OPP_2_5	False		Client: vCalender 1.0 format is supported for
> -					Object Push. (O)
> -TSPC_OPP_2_6	False		Client: vMsg as defined in IrMC 1.1 is supported
> -					for Object Push. (O)
> -TSPC_OPP_2_7	False		Client: vNote as defined in IrMC 1.1 is
> -					supported for Object Push. (O)
> +TSPC_OPP_2_3	True		Client: Object Push (M)
> +TSPC_OPP_2_4	True (*)	Client: vCard 2.1 (C.3)
> +TSPC_OPP_2_5	False		Client: vCalender 1.0 (O)
> +TSPC_OPP_2_6	False		Client: vMsg as defined in IrMC 1.1 (O)
> +TSPC_OPP_2_7	False		Client: vNote as defined in IrMC 1.1 (O)
>  TSPC_OPP_2_8	True (*)	Client: Support content formats other than those
> -					declared in TSPC_OPP_2_44 through
> +					declared in TSPC_OPP_2_4 through
>  					TSPC_OPP_2_7. (O)
>  TSPC_OPP_2_8a	False		Client: Support specific set of other content
>  					formats. (C.4)
> @@ -61,10 +56,10 @@ TSPC_OPP_2_9a	False		Client: Push multiple vCard objects using
>  TSPC_OPP_2_9b	True (*)	Client: Push multiple vCard objects using the
>  					same PUT operation. (C.5)
>  TSPC_OPP_2_10	False		Client: Push multiple vCalender objects. (O)
> -TSPC_OPP_2_10a	False		Client: Push multiple vMsg objects using
> +TSPC_OPP_2_10a	False		Client: Push multiple vCalendar objects using
>  					different PUT operations. (C.6)
> -TSPC_OPP_2_10b	False		Client: Push multiple vMsg objects using the
> -					same PUT operation. (C.6)
> +TSPC_OPP_2_10b	False		Client: Push multiple vCalendar objects using
> +					the same PUT operation. (C.6)
>  TSPC_OPP_2_11	False		Client: Push multiple vMsg objects. (O)
>  TSPC_OPP_2_11a	False		Client: Push multiple vMsg objects using
>  					different PUT operations. (C.7)
> @@ -75,17 +70,21 @@ TSPC_OPP_2_12a	False		Client: Push multiple vNote objects using
>  					different PUT operations. (C.8)
>  TSPC_OPP_2_12b	False		Client: Push multiple vNote objects using the
>  					same PUT operation. (C.8)
> -TSPC_OPP_2_13	False		Client: Pull business card is supported. (O)
> -TSPC_OPP_2_14	False		Client: vCard 2.1 format is supported for
> -					Business Card Pull. (C.1)
> -TSPC_OPP_2_15	False		Client: Exchange business card is supported. (O)
> -TSPC_OPP_2_16	False		Client: vCard 2.1 format is supported for
> -					Business Card Exchange (C.2)
> +TSPC_OPP_2_13	False		Client: Pull business card (O)
> +TSPC_OPP_2_14	False		Client: vCard 2.1 (C.1)
> +TSPC_OPP_2_15	False		Client: Exchange business card (O)
> +TSPC_OPP_2_16	False		Client: vCard 2.1 (C.2)
> +TSPC_OPP_2_17	False		GOEP v2 (C.9)
> +TSPC_OPP_2_18	False		GOEP v2 Backward Compability (C.9)
> +TSPC_OPP_2_19	False		OBEX over L2CAP (C.9)
> +TSPC_OPP_2_20	False		OBEX Reliable Session (C.10)
> +TSPC_OPP_2_21	False		OBEX SRM (C.10)
> +TSPC_OPP_2_22	False		Send OBEX SRMP header (C.10)
> +TSPC_OPP_2_23	False		Receive OBEX SRMP header (C.11)
>  -------------------------------------------------------------------------------
>  C.1: Mandatory to Support IF (TSPC_OPP_2_13) Business Card Pull is supported.
>  C.2: Mandatory to Support IF (TSPC_OPP_2_15) Business Card Exchange is
>  	supported.
> -M.1: Mandatory to Support IF (TSPC_OPP_1_1) supported.
>  C.3: vCard 2.1 support is required for devices containing phonebook
>  	applications. vCard 2.1 support optional for other devices.
>  C.4: Mandatory to support one of TSPC_OPP_2_8a or TSPC_OPP_2_8b if TSPC_OPP_2_8
> @@ -98,6 +97,9 @@ C.7: Mandatory to support at least one of TSPC_OPP_2_11a and TSPC_OPP_2_11b if
>  	TSPC_OPP_2_11 is supported. Otherwise, both items are excluded.
>  C.8: Mandatory to support at least one of TSPC_OPP_2_12a and TSPC_OPP_2_12b if
>  	TSPC_OPP_2_12 is supported. Otherwise, both items are excluded.
> +C.9: Mandatory if TSPC_OPP_1b_2 supported.
> +C.10: Optional to support if TSPC_OPP_1b_2 supported else excluded.
> +C.11: Mandatory if TSPC_OPP_17 and TSPC_OPP_21 supported else excluded.
>  -------------------------------------------------------------------------------
>  
>  
> @@ -121,17 +123,13 @@ TSPC_OPP_3_1	True		Server: Provide information on supported
>  					request. (M)
>  TSPC_OPP_3_2	True		Server: Authentication/PIN exchange supported.
>  					(M)
> -TSPC_OPP_3_3	True		Server: Object Push is supported. (M)
> +TSPC_OPP_3_3	True		Server: Object Push (M)
>  TSPC_OPP_3_3a	True (*)	Server: Receive multiple objects in the same
>  					PUT operation. (O)
> -TSPC_OPP_3_4	True (*)	Server: vCard 2.1 format is supported for Object
> -					Push. (C.3)
> -TSPC_OPP_3_5	False		Server: vCalender 1.0 format is supported for
> -					Object Push. (O)
> -TSPC_OPP_3_6	False		Server: vMsg as defined in IrMC 1.1 is supported
> -					for Object Push. (O)
> -TSPC_OPP_3_7	False		Server: vNote as defined in IrMC 1.1 is
> -					supported for Object Push. (O)
> +TSPC_OPP_3_4	True (*)	Server: vCard 2.1 (C.3)
> +TSPC_OPP_3_5	False		Server: vCalender 1.0 format (O)
> +TSPC_OPP_3_6	False		Server: vMsg as defined in IrMC 1.1 (O)
> +TSPC_OPP_3_7	False		Server: vNote as defined in IrMC 1.1 (O)
>  TSPC_OPP_3_8	True (*)	Server: Support content formats other than those
>  					declared in TSPC_OPP_3_4 through
>  					TSPC_OPP_3_7. (O)
> @@ -139,31 +137,37 @@ TSPC_OPP_3_8a	False		Server: Support specific set of other content
>  					formats. (C.4)
>  TSPC_OPP_3_8b	True (*)	Server: Support all content formats. (C.4)
>  TSPC_OPP_3_9	True (*)	Server: Object Push vCard reject. (O)
> -TSPC_OPP_3_10	False		Server: Object Push vCal rejectt. (O)
> +TSPC_OPP_3_10	False		Server: Object Push vCal reject. (O)
>  TSPC_OPP_3_11	False		Server: Object Push vMsg reject. (O)
>  TSPC_OPP_3_12	False		Server: Object Push vNote reject. (O)
> -TSPC_OPP_3_13	False		Server: Business card pull is supported. (O.1)
> -TSPC_OPP_3_14	False		Server: vCard 2.1 format is supported for
> -					Business Card Pull. (C.1)
> +TSPC_OPP_3_13	False		Server: Business card pull (O.1)
> +TSPC_OPP_3_14	False		Server: vCard 2.1 (C.1)
>  TSPC_OPP_3_15	False		Server: Business card pull reject. (O)
> -TSPC_OPP_3_16	False		Server: Business card exchange is supported.
> -					(O.2)
> -TSPC_OPP_3_17	False		Server: vCard 2.1 format is supported for
> -					Business Card Exchange (C.2)
> +TSPC_OPP_3_16	False		Server: Business card exchange (O.2)
> +TSPC_OPP_3_17	False		Server: vCard 2.1 (C.2)
>  TSPC_OPP_3_18	False		Server: Business card exchange reject. (O)
> +TSPC_OPP_3_19	False		GOEP v2 (C.5)
> +TSPC_OPP_3_20	False		GOEP v2 Backward Compability (C.5)
> +TSPC_OPP_3_21	False		OBEX over L2CAP (C.5)
> +TSPC_OPP_3_22	False		OBEX Reliable Session (C.16)
> +TSPC_OPP_3_23	False		OBEX SRM (C.6)
> +TSPC_OPP_3_24	False		Send OBEX SRMP header (C.6)
> +TSPC_OPP_3_25	False		Receive OBEX SRMP header (C.7)
>  -------------------------------------------------------------------------------
> -M.1: Mandatory to Support IF (TSPC_OPP_1_2) supported.
> -C.2: Mandatory to Support IF (TSPC_OPP_3_16) Business Card Exchange is
> -	supported.
>  O.1: IF NOT Supported, an error message must be sent on request for Business
>  	Card Pull.
>  O.2: IF NOT Supported, an error message must be sent on request for Business
>  	Card Exchange.
>  C.1: Mandatory to Support IF (TSPC_OPP_3_13) Business Card Pull is supported.
> +C.2: Mandatory to Support IF (TSPC_OPP_3_16) Business Card Exchange is
> +	supported.
>  C.3: vCard 2.1 support is required for devices containing phonebook
>  	applications. vCard 2.1 support optional for other devices.
>  C.4: Mandatory to support one of TSPC_OPP_3_8a or TSPC_OPP_3_8b if TSPC_OPP_3_8
>  	is supported. Otherwise, both items are excluded.
> +C.5: Mandatory if TSPC_OPP_2b_2 supported.
> +C.6: Optional to support if TSPC_OPP_2b_2 supported, else excluded.
> +C.7: Mandatory if TSPC_OPP_3_19 and TSPC_OPP_3_23 supported else excluded.
>  -------------------------------------------------------------------------------
>  
>  
> @@ -171,16 +175,13 @@ C.4: Mandatory to support one of TSPC_OPP_3_8a or TSPC_OPP_3_8b if TSPC_OPP_3_8
>  -------------------------------------------------------------------------------
>  Parameter Name	Selected	Description
>  -------------------------------------------------------------------------------
> -TSPC_OPP_4_1	False		Abort-Push Operation is supported. (O)
> -TSPC_OPP_4_2	False		Disconnect of OBEX session should be tested.
> +TSPC_OPP_4_1	False		Abort-Push Operation (O)
> +TSPC_OPP_4_2	False		Intentionally Left Blank (N/A)
>  TSPC_OPP_4_3	False		Multiple vCards transferred as a single vObject
> -					is supported. (C.1)
> -TSPC_OPP_4_4	False		Multiple vCards transfer is supported. (C.1)
> -TSPC_OPP_4_5	False		vCards with multiple Phone Number Fields is
> -					supported. (C.1)
> -TSPC_OPP_4_6	False		Server supports Push vCal to Different Time
> -					Zone. (C.1)
> -TSPC_ALL	False		Turn on all test cases.
> +					(C.1)
> +TSPC_OPP_4_4	False		Multiple vCards transfer (C.1)
> +TSPC_OPP_4_5	False		vCards with multiple Phone Number Fields (C.1)
> +TSPC_OPP_4_6	False		Push vCal to Different Time Zone Server (C.1)
>  -------------------------------------------------------------------------------
>  C.1: Optional if TSPC_OPP_1_2 is supported, otherwise excluded.
>  -------------------------------------------------------------------------------
> diff --git a/android/pixit-opp.txt b/android/pixit-opp.txt
> index 93f6a29..7b0f4f2 100644
> --- a/android/pixit-opp.txt
> +++ b/android/pixit-opp.txt
> @@ -1,6 +1,6 @@
>  OPP PIXIT for the PTS tool.
>  
> -PTS version: 5.0
> +PTS version: 5.1
>  
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> @@ -9,19 +9,19 @@ PTS version: 5.0
>  -------------------------------------------------------------------------------
>  Parameter Name						Value
>  -------------------------------------------------------------------------------
> -TSPX_unsupported_extension				dat
> -TSPX_supported_extension				jpg
> -TSPX_security_enabled					False
> -TSPX_bd_addr_iut					112233445566 (*&)
> +TSPX_supported_extension				jpg (*)
> +TSPX_unsupported_extension				pts
>  TSPX_client_class_of_device				100104
>  TSPX_server_class_of_device				100104
> +TSPX_auth_password					0000
> +TSPX_auth_user_id					PTS
> +TSPX_l2cap_psm						1003
>  TSPX_rfcomm_channel					8
> +TSPX_no_confirmations					FALSE
> +TSPX_bd_addr_iut					112233445566 (*&)
> +TSPX_delete_link_key					FALSE
>  TSPX_pin_code						0000
> -TSPX_reply_reject_push					True
> -TSPX_delete_link_key					False
> -TSPX_time_guard						180000
> -TSPX_use_implicit_send					True
> -TSPX_secure_simple_pairing_pass_key_confirmation	False
> -TSPX_PTS_sends_real_jpg_data				True
> -TSPX_confirm_received_objects				True
> +TSPX_security_enabled					FALSE
> +TSPX_time_guard						300000
> +TSPX_use_implicit_send					TRUE
>  -------------------------------------------------------------------------------
> 

-- 
Best regards, 
Szymon Janc
