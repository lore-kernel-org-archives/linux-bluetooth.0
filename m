Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: PTS test results for PAN
Date: Fri, 21 Feb 2014 11:44:30 +0100
Message-ID: <8496957.RDOJq6S1LN@uw000953>
In-Reply-To: <1392819038-19608-1-git-send-email-sebastian.chlad@tieto.com>
References: <1392819038-19608-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Wednesday 19 of February 2014 15:10:38 Sebastian Chlad wrote:
> This adds initial PTS test results for PAN profile.
> ---
>  android/pts-pan.txt | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 android/pts-pan.txt
> 
> diff --git a/android/pts-pan.txt b/android/pts-pan.txt
> new file mode 100644
> index 0000000..8e8ae41
> --- /dev/null
> +++ b/android/pts-pan.txt
> @@ -0,0 +1,70 @@
> +PTS test results for PAN
> +
> +PTS version: 5.0
> +Tested: 19.02.2014
> +Android version: 4.4.2
> +
> +Results:
> +PASS	test passed
> +FAIL	test failed
> +INC	test is inconclusive
> +N/A	test is disabled due to PICS setup
> +
> +-------------------------------------------------------------------------------
> +Test Name				Result	Notes
> +-------------------------------------------------------------------------------
> +TC_BNEP_GN_BROADCAST_0_BV_03_C		N/A
> +TC_GN_Ipv4_Autonet_BV_01_I		N/A
> +TC_GN_Ipv6_Autonet_BV_02_I		N/A
> +TC_GN_IP_DHCP_BV_03_I			N/A
> +TC_GN_IP_LLMNR_BV_01_I			N/A
> +TC_GN_IP_LLMNR_BV_02_I			N/A
> +TC_GN_IP_DNS_BV_01_I			N/A
> +TC_GN_IP_APP_BV_01_I			N/A
> +TC_GN_IP_APP_BV_02_I			N/A
> +TC_GN_IP_APP_BV_03_I			N/A
> +TC_GN_IP_APP_BV_04_I			N/A
> +TC_GN_IP_APP_BV_05_I			N/A
> +TC_SDP_GN_BV_02_C			N/A
> +TC_MISC_GN_UUID_BV_01_C			N/A
> +TC_MISC_GN_UUID_BV_02_C			N/A
> +TC_BNEP_NAP_BROADCAST_0_BV_01_C		N/A
> +TC_BNEP_NAP_BROADCAST_0_BV_02_C		N/A
> +TC_BNEP_NAP_FORWARD_UNICAST_BV_05_C	N/A
> +TC_BNEP_NAP_FORWARD_UNICAST_BV_06_C	N/A
> +TC_BNEP_NAP_MULTICAST_0_BV_03_C		N/A
> +TC_BNEP_NAP_MULTICAST_0_BV_04_C		N/A
> +TC_BNEP_BRIDGE_RX_BV_02_I		INC
> +TC_BNEP_BRIDGE_TX_BV_01_I		PASS
> +TC_NAP_Ipv4_Autonet_BV_01_I		N/A
> +TC_NAP_Ipv6_Autonet_BV_02_I		N/A
> +TC_NAP_IP_DHCP_BV_03_I			N/A
> +TC_NAP_IP_LLMNR_BV_01_I			INC
> +TC_NAP_IP_LLMNR_BV_02_I			N/A
> +TC_NAP_IP_DNS_BV_01_I			N/A
> +TC_NAP_IP_APP_BV_01_I			N/A
> +TC_NAP_IP_APP_BV_02_I			N/A
> +TC_NAP_IP_APP_BV_03_I			N/A
> +TC_NAP_IP_APP_BV_04_I			N/A
> +TC_NAP_IP_APP_BV_05_I			PASS
> +TC_SDP_NAP_BV_01_C			PASS
> +TC_MISC_NAP_UUID_BV_01_C		PASS
> +TC_MISC_NAP_UUID_BV_02_C		PASS
> +TC_BNEP_PANU_BROADCAST_0_BV_04_C	N/A
> +TC_PANU_Ipv4_Autonet_BV_01_I		INC
> +TC_PANU_Ipv6_Autonet_BV_02_I		N/A
> +TC_PANU_IP_LLMNR_BV_01_I		INC
> +TC_PANU_IP_LLMNR_BV_02_I		N/A
> +TC_PANU_IP_DHCP_BV_03_I			PASS
> +TC_PANU_IP_DNS_BV_01_I			N/A
> +TC_PANU_IP_APP_BV_01_I			N/A
> +TC_PANU_IP_APP_BV_02_I			N/A
> +TC_PANU_IP_APP_BV_03_I			INC
> +TC_PANU_IP_APP_BV_04_I			INC
> +TC_PANU_IP_APP_BV_05_I			PASS
> +TC_SDP_PANU_BV_01_C			N/A
> +TC_MISC_PANU_UUID_BV_01_C		N/A
> +TC_MISC_PANU_UUID_BV_02_C		N/A
> +TC_MISC_ROLE_BV_01_C			N/A
> +TC_MISC_ROLE_BV_BV_02_C			N/A
> +-------------------------------------------------------------------------------
> 

Pushed, thanks.

-- 
Best regards, 
Szymon Janc
