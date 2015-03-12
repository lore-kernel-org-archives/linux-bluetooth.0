Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 10/10] android/pts: Add BNEP PTS 6.0 results for android 5.0
Date: Thu, 12 Mar 2015 11:04:36 +0100
Message-ID: <6575527.cKVHveLcYa@uw000953>
In-Reply-To: <1425918295-21976-10-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1425918295-21976-1-git-send-email-grzegorz.kolodziejczyk@tieto.com> <1425918295-21976-10-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Monday 09 of March 2015 17:24:55 Grzegorz Kolodziejczyk wrote:
> This patch adds test case list and results for BNEP profile against
> android 5.0
> ---
>  android/pics-bnep.txt  | 26 ++++++++++++++
>  android/pixit-bnep.txt | 30 ++++++++++++++++
>  android/pts-bnep.txt   | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 148 insertions(+)
>  create mode 100644 android/pics-bnep.txt
>  create mode 100644 android/pixit-bnep.txt
>  create mode 100644 android/pts-bnep.txt
> 
> diff --git a/android/pics-bnep.txt b/android/pics-bnep.txt
> new file mode 100644
> index 0000000..2279c9a
> --- /dev/null
> +++ b/android/pics-bnep.txt
> @@ -0,0 +1,26 @@
> +BNEP PICS for the PTS tool.
> +
> +PTS version: 6.0
> +
> +* - different than PTS defaults
> +# - not yet implemented/supported
> +
> +M - mandatory if such role selected
> +O - optional
> +
> +		Profile Version
> +-------------------------------------------------------------------------------
> +Parameter Name	Selected	Description
> +-------------------------------------------------------------------------------
> +TSPC_BNEP_1_1	True		BNEP Connection Setup (M)
> +TSPC_BNEP_1_2	False		BNEP Data Packet Reception (M)
> +TSPC_BNEP_1_3	False		BNEP Data Packet Transmission (M)
> +TSPC_BNEP_1_3a	False		BNEP Compressed Packet Transmission (O)

1_2 1_3 and 1_3a should be True.

> +TSPC_BNEP_1_3b	False		BNEP Compressed Packet Transmission Source Only
> +				(O)
> +TSPC_BNEP_1_4	True		BNEP Control Message Processing (M)
> +TSPC_BNEP_1_5	True		BNEP Extension Header Processing (M)
> +TSPC_BNEP_1_6	True		Network Protocol Filter Message Transmission (O)
> +TSPC_BNEP_1_7	True		Multicast Address Filter Message Transmission
> +				(O)
> +-------------------------------------------------------------------------------
> diff --git a/android/pixit-bnep.txt b/android/pixit-bnep.txt
> new file mode 100644
> index 0000000..9a26cd2
> --- /dev/null
> +++ b/android/pixit-bnep.txt
> @@ -0,0 +1,30 @@
> +BNEP PIXIT for the PTS tool.
> +
> +PTS version: 6.0
> +
> +* - different than PTS defaults
> +& - should be set to IUT Bluetooth address
> +# - should be set to PTS's bin/audio folder
> +
> +Required PIXIT settings
> +-------------------------------------------------------------------------------
> +Parameter Name			Value
> +-------------------------------------------------------------------------------
> +TSPX_class_of_device		04041C
> +TSPX_security_control_data
> +TSPX_content_protection_data
> +TSPX_bd_addr_iut		112233445566 (*&)
> +TSPX_delete_link_key		FALSE
> +TSPX_pin_code			1234
> +TSPX_security_enabled		FALSE
> +TSPX_time_guard			300000
> +TSPX_use_implicit_send		TRUE
> +TSPX_auth_password		0000
> +TSPX_auth_user_id		PTS
> +TSPX_l2cap_psm			000F
> +TSPX_rfcomm_channel		8
> +TSPX_no_confirmations		FALSE
> +TSPX_UUID_dest_address		1116
> +TSPX_UUID_source_address	1115
> +TSPX_MAC_dest_address		000000000000 (*&)
> +TSPX_MAC_source_address		000000000000 (*&)
> diff --git a/android/pts-bnep.txt b/android/pts-bnep.txt
> new file mode 100644
> index 0000000..7945385
> --- /dev/null
> +++ b/android/pts-bnep.txt
> @@ -0,0 +1,92 @@
> +PTS test results for BNEP
> +
> +PTS version: 6.0
> +Tested: 03-March-2015
> +Android version: 5.0
> +Kernel version: 3.20
> +
> +Results:
> +PASS	test passed
> +FAIL	test failed
> +INC	test is inconclusive
> +N/A	test is disabled due to PICS setup
> +
> +--------------------------------------------------------------------------------
> +Test Name		Result	Notes
> +--------------------------------------------------------------------------------
> +TC_CTRL_BV_01_C		PASS	bneptest -s
> +TC_CTRL_BV_02_C		PASS	bneptest -c <PTS addr>
> +TC_CTRL_BV_03_C		PASS	bneptest -s
> +				Note: could be necessary setting approperiate
> +					naming of interface using option
> +					-n <iface name>, eg. -n enp0s29u1u7
> +TC_CTRL_BV_04_C		INC	PTS issue #13169
> +				bneptest -s
> +				Note: could be necessary setting approperiate
> +					naming of interface using option
> +					-n <iface name>, eg. -n enp0s29u1u7
> +TC_CTRL_BV_05_C		INC	PTS issue #13169
> +				bneptest -s
> +				Note: could be necessary setting approperiate
> +					naming of interface using option
> +					-n <iface name>, eg. -n enp0s29u1u7
> +TC_CTRL_BV_06_C		INC	PTS issue #13169
> +				bneptest -s
> +				Note: could be necessary setting approperiate
> +					naming of interface using option
> +					-n <iface name>, eg. -n enp0s29u1u7
> +TC_CTRL_BV_07_C		INC	PTS issue #13170
> +				bneptest -c <PTS addr> -t 3 -d 0 -e 1500
> +				Note: could be necessary setting approperiate
> +					naming of interface using option
> +					-n <iface name>, eg. -n enp0s29u1u7
> +TC_CTRL_BV_08_C		INC	PTS issue #13169
> +				bneptest -s
> +				Note: could be necessary setting approperiate
> +					naming of interface using option
> +					-n <iface name>, eg. -n enp0s29u1u7
> +TC_CTRL_BV_09_C		INC	PTS issue #13170
> +				bneptest -c 00:1b:dc:06:06:ca -n enp0s29u1u7
> +					-t 5 -g 00:00:00:00:00:00
> +					-j ff:ff:ff:ff:ff:ff
> +				Note: could be necessary setting approperiate
> +					naming of interface using option
> +					-n <iface name>, eg. -n enp0s29u1u7
> +TC_CTRL_BV_10_C		INC	PTS issue #13169
> +				bneptest -s
> +				Note: could be necessary setting approperiate
> +					naming of interface using option
> +					-n <iface name>, eg. -n enp0s29u1u7
> +TC_CTRL_BV_19_C		INC	PTS issue #13169
> +				bneptest -s
> +				Note: could be necessary setting approperiate
> +					naming of interface using option
> +					-n <iface name>, eg. -n enp0s29u1u7
> +TC_RX_TYPE_0_BV_11_C	N/A
> +TC_RX_C_BV_12_C		N/A
> +TC_RX_C_S_BV_13_C	N/A
> +TC_RX_C_S_BV_14_C	N/A
> +TC_RX_TYPE_0_BV_15_C	INC	PTS issue #13169
> +				bneptest -s
> +				Note: could be necessary setting approperiate
> +					naming of interface using option
> +					-n <iface name>, eg. -n enp0s29u1u7
> +TC_RX_TYPE_0_BV_16_C	INC	PTS issue #13171
> +				bneptest -s
> +				Note: could be necessary setting approperiate
> +					naming of interface using option
> +					-n <iface name>, eg. -n enp0s29u1u7
> +TC_RX_TYPE_0_BV_17_C	INC	PTS issue #13169
> +				bneptest -s
> +				Note: could be necessary setting approperiate
> +					naming of interface using option
> +					-n <iface name>, eg. -n enp0s29u1u7
> +TC_RX_TYPE_0_BV_18_C	INC	PTS issue #13171
> +				bneptest -s
> +				Note: could be necessary setting approperiate
> +					naming of interface using option
> +					-n <iface name>, eg. -n enp0s29u1u7
> +TC_TX_TYPE_0_BV_20_C	N/A
> +TC_TX_C_BV_21_C		N/A
> +TC_TX_C_S_BV_22_C	N/A
> +TC_TX_C_D_BV_23_C	N/A
> 

-- 
Best regards, 
Szymon Janc
