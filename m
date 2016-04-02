Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Sat, 2 Apr 2016 23:05:15 +0800
From: kbuild test robot <lkp@intel.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Cc: kbuild-all@01.org, linux-bluetooth@vger.kernel.org,
	Cathy Luo <cluo@marvell.com>, linux-kernel@vger.kernel.org,
	Nishant Sarmukadam <nishants@marvell.com>,
	Ganapathi Bhat <gbhat@marvell.com>,
	Amitkumar Karwar <akarwar@marvell.com>
Subject: Re: [PATCH v6] Bluetooth: hci_uart: Support firmware download for
 Marvell
Message-ID: <201604022311.Sz2CeBkU%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
In-Reply-To: <1459425491-19282-1-git-send-email-akarwar@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ganapathi,

[auto build test ERROR on v4.6-rc1]
[also build test ERROR on next-20160401]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Amitkumar-Karwar/Bluetooth-hci_uart-Support-firmware-download-for-Marvell/20160331-200638
config: x86_64-randconfig-s0-04022220 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

>> drivers/bluetooth/hci_mrvl.c:136:33: error: array type has incomplete element type 'struct h4_recv_pkt'
    static const struct h4_recv_pkt mrvl_recv_pkts[] = {
                                    ^
>> drivers/bluetooth/hci_mrvl.c:137:4: error: 'H4_RECV_ACL' undeclared here (not in a function)
     { H4_RECV_ACL,   .recv = hci_recv_frame },
       ^
>> drivers/bluetooth/hci_mrvl.c:137:19: error: field name not in record or union initializer
     { H4_RECV_ACL,   .recv = hci_recv_frame },
                      ^
   drivers/bluetooth/hci_mrvl.c:137:19: note: (near initialization for 'mrvl_recv_pkts')
>> drivers/bluetooth/hci_mrvl.c:138:4: error: 'H4_RECV_SCO' undeclared here (not in a function)
     { H4_RECV_SCO,   .recv = hci_recv_frame },
       ^
   drivers/bluetooth/hci_mrvl.c:138:19: error: field name not in record or union initializer
     { H4_RECV_SCO,   .recv = hci_recv_frame },
                      ^
   drivers/bluetooth/hci_mrvl.c:138:19: note: (near initialization for 'mrvl_recv_pkts')
>> drivers/bluetooth/hci_mrvl.c:139:4: error: 'H4_RECV_EVENT' undeclared here (not in a function)
     { H4_RECV_EVENT, .recv = hci_recv_frame },
       ^
   drivers/bluetooth/hci_mrvl.c:139:19: error: field name not in record or union initializer
     { H4_RECV_EVENT, .recv = hci_recv_frame },
                      ^
   drivers/bluetooth/hci_mrvl.c:139:19: note: (near initialization for 'mrvl_recv_pkts')
   drivers/bluetooth/hci_mrvl.c: In function 'mrvl_recv':
>> drivers/bluetooth/hci_mrvl.c:244:17: error: implicit declaration of function 'h4_recv_buf' [-Werror=implicit-function-declaration]
     mrvl->rx_skb = h4_recv_buf(hu->hdev, mrvl->rx_skb, data, count,
                    ^
   In file included from include/linux/thread_info.h:11:0,
                    from arch/x86/include/asm/preempt.h:6,
                    from include/linux/preempt.h:59,
                    from include/linux/spinlock.h:50,
                    from include/linux/seqlock.h:35,
                    from include/linux/time.h:5,
                    from include/linux/stat.h:18,
                    from include/linux/module.h:10,
                    from drivers/bluetooth/hci_mrvl.c:22:
>> include/linux/bug.h:34:45: error: bit-field '<anonymous>' width not an integer constant
    #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
                                                ^
   include/linux/compiler-gcc.h:64:28: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
    #define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
                               ^
   include/linux/kernel.h:54:59: note: in expansion of macro '__must_be_array'
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                                                              ^
>> drivers/bluetooth/hci_mrvl.c:245:24: note: in expansion of macro 'ARRAY_SIZE'
           mrvl_recv_pkts, ARRAY_SIZE(mrvl_recv_pkts));
                           ^
   drivers/bluetooth/hci_mrvl.c: At top level:
>> drivers/bluetooth/hci_mrvl.c:136:33: warning: 'mrvl_recv_pkts' defined but not used [-Wunused-variable]
    static const struct h4_recv_pkt mrvl_recv_pkts[] = {
                                    ^
   cc1: some warnings being treated as errors

vim +136 drivers/bluetooth/hci_mrvl.c

   130		memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
   131		skb_queue_tail(&mrvl->txq, skb);
   132	
   133		return 0;
   134	}
   135	
 > 136	static const struct h4_recv_pkt mrvl_recv_pkts[] = {
 > 137		{ H4_RECV_ACL,   .recv = hci_recv_frame },
 > 138		{ H4_RECV_SCO,   .recv = hci_recv_frame },
 > 139		{ H4_RECV_EVENT, .recv = hci_recv_frame },
   140	};
   141	
   142	/* Send ACK/NAK to the device */
   143	static void mrvl_send_ack(struct hci_uart *hu, unsigned char ack)
   144	{
   145		struct tty_struct *tty = hu->tty;
   146	
   147		tty->ops->write(tty, &ack, sizeof(ack));
   148	}
   149	
   150	/* Validate the feedback data from device */
   151	static void mrvl_pkt_complete(struct hci_uart *hu, struct sk_buff *skb)
   152	{
   153		struct mrvl_data *mrvl = hu->priv;
   154		struct fw_data *fw_data = mrvl->fwdata;
   155		u8 buf[MRVL_FW_HDR_LEN];
   156		u16 lhs, rhs;
   157	
   158		memcpy(buf, skb->data, skb->len);
   159	
   160		lhs = le16_to_cpu(*((__le16 *)(&buf[1])));
   161		rhs = le16_to_cpu(*((__le16 *)(&buf[3])));
   162		if ((lhs ^ rhs) == 0xffff) {
   163			mrvl_send_ack(hu, MRVL_ACK);
   164			fw_data->wait_fw = 1;
   165			fw_data->next_len = lhs;
   166			/*firmware download is done, send the last ack*/
   167			if (!lhs)
   168				fw_data->last_ack = 1;
   169	
   170			if (unlikely(fw_data->expected_ack == MRVL_HDR_CHIP_VER)) {
   171				fw_data->chip_id = *((u8 *)(&buf[1]));
   172				fw_data->chip_rev = *((u8 *)(&buf[2]));
   173			}
   174			wake_up_interruptible(&fw_data->init_wait_q);
   175		} else {
   176			mrvl_send_ack(hu, MRVL_NAK);
   177		}
   178	}
   179	
   180	/* This function receives data from the uart device during firmware download.
   181	 * Driver expects 5 bytes of data as per the protocal in the below format:
   182	 * <HEADER><BYTE_1><BYTE_2><BYTE_3><BYTE_4>
   183	 * BYTE_3 and BYTE_4 are compliment of BYTE_1 an BYTE_2. Data can come in chunks
   184	 * of any length. If length received is < 5, accumulate the data in an array,
   185	 * until we have a sequence of 5 bytes, starting with the expected HEADER. If
   186	 * the length received is > 5  bytes, then get the first 5 bytes, starting with
   187	 * the HEADER and process the same, ignoring the rest of the bytes as per the
   188	 * protocal.
   189	 */
   190	static struct sk_buff *mrvl_process_fw_data(struct hci_uart *hu,
   191						    struct sk_buff *skb,
   192						    u8 *buf, int count)
   193	{
   194		struct mrvl_data *mrvl = hu->priv;
   195		struct fw_data *fw_data = mrvl->fwdata;
   196		int i = 0, len;
   197	
   198		if (!skb) {
   199			while (buf[i] != fw_data->expected_ack && i < count)
   200				i++;
   201			if (i == count)
   202				return ERR_PTR(-EILSEQ);
   203	
   204			skb = bt_skb_alloc(MRVL_FW_HDR_LEN, GFP_KERNEL);
   205		}
   206	
   207		if (!skb)
   208			return ERR_PTR(-ENOMEM);
   209	
   210		len = count - i;
   211		memcpy(skb_put(skb, len), &buf[i], len);
   212	
   213		if (skb->len == MRVL_FW_HDR_LEN) {
   214			mrvl_pkt_complete(hu, skb);
   215			kfree_skb(skb);
   216			skb = NULL;
   217		}
   218	
   219		return skb;
   220	}
   221	
   222	/* Receive data */
   223	static int mrvl_recv(struct hci_uart *hu, const void *data, int count)
   224	{
   225		struct mrvl_data *mrvl = hu->priv;
   226	
   227		if (test_bit(HCI_UART_DNLD_FW, &mrvl->flags)) {
   228			mrvl->fwdata->skb = mrvl_process_fw_data(hu, mrvl->fwdata->skb,
   229								 (u8 *)data, count);
   230			if (IS_ERR(mrvl->fwdata->skb)) {
   231				int err = PTR_ERR(mrvl->fwdata->skb);
   232	
   233				bt_dev_err(hu->hdev,
   234					   "Receive firmware data failed (%d)", err);
   235				mrvl->fwdata->skb = NULL;
   236				return err;
   237			}
   238			return 0;
   239		}
   240	
   241		if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
   242			return -EUNATCH;
   243	
 > 244		mrvl->rx_skb = h4_recv_buf(hu->hdev, mrvl->rx_skb, data, count,
 > 245					   mrvl_recv_pkts, ARRAY_SIZE(mrvl_recv_pkts));
   246		if (IS_ERR(mrvl->rx_skb)) {
   247			int err = PTR_ERR(mrvl->rx_skb);
   248	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--VS++wcV0S1rZb1Fb
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--VS++wcV0S1rZb1Fb--
