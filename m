Return-Path: <SRS0=dIIZ=R6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF44BC10F00
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Mar 2019 13:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC82B2082F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Mar 2019 13:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfC0NjJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:39:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:21720 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728530AbfC0NjI (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Mar 2019 09:39:08 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 06:39:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,277,1549958400"; 
   d="scan'208";a="129101397"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 27 Mar 2019 06:39:06 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1h98lm-000ERP-EB; Wed, 27 Mar 2019 21:39:06 +0800
Date:   Wed, 27 Mar 2019 21:38:58 +0800
From:   kbuild test robot <lkp@intel.com>
To:     SpoorthiX K <spoorthix.k@intel.com>
Cc:     kbuild-all@01.org, linux-bluetooth@vger.kernel.org,
        linux-bluetooth-owner@vger.kernel.org
Subject: Re: [PATCH] Add Support for LE Ping feature
Message-ID: <201903272159.3Y6RkM6w%lkp@intel.com>
References: <1553661793-10304-1-git-send-email-spoorthix.k@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553661793-10304-1-git-send-email-spoorthix.k@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi SpoorthiX,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on v5.1-rc2 next-20190327]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/SpoorthiX-K/Add-Support-for-LE-Ping-feature/20190327-182038
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'


sparse warnings: (new ones prefixed by >>)

>> net/bluetooth/hci_event.c:3010:28: sparse: incorrect type in assignment (different base types) @@    expected unsigned short [unsigned] [assigned] [usertype] timeout @@    got igned] [assigned] [usertype] timeout @@
   net/bluetooth/hci_event.c:3010:28:    expected unsigned short [unsigned] [assigned] [usertype] timeout
   net/bluetooth/hci_event.c:3010:28:    got restricted __le16 [usertype] <noident>
   include/linux/overflow.h:285:13: sparse: undefined identifier '__builtin_mul_overflow'
   include/linux/overflow.h:285:13: sparse: incorrect type in conditional
   include/linux/overflow.h:285:13:    got void
   include/linux/overflow.h:287:13: sparse: undefined identifier '__builtin_add_overflow'
   include/linux/overflow.h:287:13: sparse: incorrect type in conditional
   include/linux/overflow.h:287:13:    got void
   include/linux/overflow.h:285:13: sparse: not a function <noident>
   include/linux/overflow.h:285:13: sparse: incorrect type in conditional
   include/linux/overflow.h:285:13:    got void
   include/linux/overflow.h:287:13: sparse: not a function <noident>
   include/linux/overflow.h:287:13: sparse: incorrect type in conditional
   include/linux/overflow.h:287:13:    got void
   include/linux/overflow.h:285:13: sparse: call with no type!
   include/linux/overflow.h:287:13: sparse: call with no type!

vim +3010 net/bluetooth/hci_event.c

  2904	
  2905	static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
  2906	{
  2907		struct hci_ev_encrypt_change *ev = (void *) skb->data;
  2908		struct hci_conn *conn;
  2909	
  2910		BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
  2911	
  2912		hci_dev_lock(hdev);
  2913	
  2914		conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
  2915		if (!conn)
  2916			goto unlock;
  2917	
  2918		if (!ev->status) {
  2919			if (ev->encrypt) {
  2920				/* Encryption implies authentication */
  2921				set_bit(HCI_CONN_AUTH, &conn->flags);
  2922				set_bit(HCI_CONN_ENCRYPT, &conn->flags);
  2923				conn->sec_level = conn->pending_sec_level;
  2924	
  2925				/* P-256 authentication key implies FIPS */
  2926				if (conn->key_type == HCI_LK_AUTH_COMBINATION_P256)
  2927					set_bit(HCI_CONN_FIPS, &conn->flags);
  2928	
  2929				if ((conn->type == ACL_LINK && ev->encrypt == 0x02) ||
  2930				    conn->type == LE_LINK)
  2931					set_bit(HCI_CONN_AES_CCM, &conn->flags);
  2932			} else {
  2933				clear_bit(HCI_CONN_ENCRYPT, &conn->flags);
  2934				clear_bit(HCI_CONN_AES_CCM, &conn->flags);
  2935			}
  2936		}
  2937	
  2938		/* We should disregard the current RPA and generate a new one
  2939		 * whenever the encryption procedure fails.
  2940		 */
  2941		if (ev->status && conn->type == LE_LINK) {
  2942			hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
  2943			hci_adv_instances_set_rpa_expired(hdev, true);
  2944		}
  2945	
  2946		clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
  2947	
  2948		if (ev->status && conn->state == BT_CONNECTED) {
  2949			if (ev->status == HCI_ERROR_PIN_OR_KEY_MISSING)
  2950				set_bit(HCI_CONN_AUTH_FAILURE, &conn->flags);
  2951	
  2952			hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
  2953			hci_conn_drop(conn);
  2954			goto unlock;
  2955		}
  2956	
  2957		/* In Secure Connections Only mode, do not allow any connections
  2958		 * that are not encrypted with AES-CCM using a P-256 authenticated
  2959		 * combination key.
  2960		 */
  2961		if (hci_dev_test_flag(hdev, HCI_SC_ONLY) &&
  2962		    (!test_bit(HCI_CONN_AES_CCM, &conn->flags) ||
  2963		     conn->key_type != HCI_LK_AUTH_COMBINATION_P256)) {
  2964			hci_connect_cfm(conn, HCI_ERROR_AUTH_FAILURE);
  2965			hci_conn_drop(conn);
  2966			goto unlock;
  2967		}
  2968	
  2969		/* Try reading the encryption key size for encrypted ACL links */
  2970		if (!ev->status && ev->encrypt && conn->type == ACL_LINK) {
  2971			struct hci_cp_read_enc_key_size cp;
  2972			struct hci_request req;
  2973	
  2974			/* Only send HCI_Read_Encryption_Key_Size if the
  2975			 * controller really supports it. If it doesn't, assume
  2976			 * the default size (16).
  2977			 */
  2978			if (!(hdev->commands[20] & 0x10)) {
  2979				conn->enc_key_size = HCI_LINK_KEY_SIZE;
  2980				goto notify;
  2981			}
  2982	
  2983			hci_req_init(&req, hdev);
  2984	
  2985			cp.handle = cpu_to_le16(conn->handle);
  2986			hci_req_add(&req, HCI_OP_READ_ENC_KEY_SIZE, sizeof(cp), &cp);
  2987	
  2988			if (hci_req_run_skb(&req, read_enc_key_size_complete)) {
  2989				bt_dev_err(hdev, "sending read key size failed");
  2990				conn->enc_key_size = HCI_LINK_KEY_SIZE;
  2991				goto notify;
  2992			}
  2993	
  2994			goto unlock;
  2995		}
  2996		/* Set the default Authenticated Payload Timeout after
  2997		 * an LE Link is established. As per Core Spec v5.0, Vol 2, Part B
  2998		 * Section 3.3, the HCI command WRITE_AUTH_PAYLOAD_TIMEOUT should be
  2999		 * sent when the link is active and Encryption is enabled, the conn
  3000		 * type can be either LE or ACL and controller must support LMP Ping.
  3001		 * Ensure for AES-CCM encryption as well.
  3002		 */
  3003		if ((conn->type == LE_LINK || conn->type == ACL_LINK) &
  3004			lmp_ping_capable(hdev) &&
  3005			test_bit(HCI_CONN_ENCRYPT, &conn->flags) &&
  3006			test_bit(HCI_CONN_AES_CCM, &conn->flags)) {
  3007			struct hci_cp_write_auth_payload_to cp;
  3008	
  3009			cp.handle = cpu_to_le16(conn->handle);
> 3010			cp.timeout = cpu_to_le16(hdev->auth_payload_timeout);
  3011			hci_send_cmd(conn->hdev, HCI_OP_WRITE_AUTH_PAYLOAD_TO,
  3012				     sizeof(cp), &cp);
  3013		} else {
  3014			conn->state = BT_CONNECTED;
  3015			hci_connect_cfm(conn, ev->status);
  3016		}
  3017	
  3018	notify:
  3019		if (conn->state == BT_CONFIG) {
  3020			if (!ev->status)
  3021				conn->state = BT_CONNECTED;
  3022	
  3023			hci_connect_cfm(conn, ev->status);
  3024			hci_conn_drop(conn);
  3025		} else
  3026			hci_encrypt_cfm(conn, ev->status, ev->encrypt);
  3027	
  3028	unlock:
  3029		hci_dev_unlock(hdev);
  3030	}
  3031	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
