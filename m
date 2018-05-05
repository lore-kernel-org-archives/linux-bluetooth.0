Return-Path: <fengguang.wu@intel.com>
Date: Sun, 6 May 2018 03:21:51 +0800
From: kbuild test robot <lkp@intel.com>
To: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc: kbuild-all@01.org, marcel@holtmann.org, johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
	hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
	Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: Re: [PATCH v4 2/3] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth chip wcn3990.
Message-ID: <201805060147.kINUg1XC%fengguang.wu@intel.com>
References: <1525448106-18616-3-git-send-email-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
In-Reply-To: <1525448106-18616-3-git-send-email-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Balakrishna,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on bluetooth-next/master]
[also build test ERROR on next-20180504]
[cannot apply to bluetooth/master v4.17-rc3]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Balakrishna-Godavarthi/dt-bindings-net-bluetooth-Add-device-tree-bindings-for-QTI-chip-wcn3990/20180506-004430
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
config: x86_64-randconfig-x014-201818 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

Note: the linux-review/Balakrishna-Godavarthi/dt-bindings-net-bluetooth-Add-device-tree-bindings-for-QTI-chip-wcn3990/20180506-004430 HEAD 8ea35b4e8656709a14f0170188ef9004ac96b4ac builds fine.
      It only hurts bisectibility.

All error/warnings (new ones prefixed by >>):

   drivers//bluetooth/hci_qca.c: In function 'qca_open':
>> drivers//bluetooth/hci_qca.c:512:4: error: implicit declaration of function 'btqca_power_setup'; did you mean 'ether_setup'? [-Werror=implicit-function-declaration]
       btqca_power_setup(true);
       ^~~~~~~~~~~~~~~~~
       ether_setup
   drivers//bluetooth/hci_qca.c: In function 'qca_close':
>> drivers//bluetooth/hci_qca.c:604:4: error: implicit declaration of function 'qca_btsoc_cleanup'; did you mean 'hci_sock_cleanup'? [-Werror=implicit-function-declaration]
       qca_btsoc_cleanup(hu->hdev);
       ^~~~~~~~~~~~~~~~~
       hci_sock_cleanup
   drivers//bluetooth/hci_qca.c: In function 'qca_send_poweron_cmd':
>> drivers//bluetooth/hci_qca.c:988:8: error: 'CHEROKEE_POWERON_PULSE' undeclared (first use in this function)
     cmd = CHEROKEE_POWERON_PULSE;
           ^~~~~~~~~~~~~~~~~~~~~~
   drivers//bluetooth/hci_qca.c:988:8: note: each undeclared identifier is reported only once for each function it appears in
   drivers//bluetooth/hci_qca.c: In function 'qca_send_poweroff_cmd':
>> drivers//bluetooth/hci_qca.c:1018:8: error: 'CHEROKEE_POWEROFF_PULSE' undeclared (first use in this function)
     cmd = CHEROKEE_POWEROFF_PULSE;
           ^~~~~~~~~~~~~~~~~~~~~~~
   drivers//bluetooth/hci_qca.c: In function 'qca_setup':
>> drivers//bluetooth/hci_qca.c:1144:9: error: implicit declaration of function 'rome_patch_ver_req'; did you mean 'blk_path_error'? [-Werror=implicit-function-declaration]
      ret = rome_patch_ver_req(hdev, &soc_ver);
            ^~~~~~~~~~~~~~~~~~
            blk_path_error
>> drivers//bluetooth/hci_qca.c:1182:9: error: implicit declaration of function 'qca_uart_setup_cherokee'; did you mean 'qca_uart_setup_rome'? [-Werror=implicit-function-declaration]
      ret = qca_uart_setup_cherokee(hdev, qca_baudrate, &soc_ver);
            ^~~~~~~~~~~~~~~~~~~~~~~
            qca_uart_setup_rome
   drivers//bluetooth/hci_qca.c: At top level:
>> drivers//bluetooth/hci_qca.c:1308:5: error: conflicting types for 'btqca_power_setup'
    int btqca_power_setup(bool on)
        ^~~~~~~~~~~~~~~~~
   drivers//bluetooth/hci_qca.c:1309:1: note: an argument type that has a default promotion can't match an empty parameter name list declaration
    {
    ^
   drivers//bluetooth/hci_qca.c:512:4: note: previous implicit declaration of 'btqca_power_setup' was here
       btqca_power_setup(true);
       ^~~~~~~~~~~~~~~~~
   drivers//bluetooth/hci_qca.c: In function 'btqca_power_setup':
>> drivers//bluetooth/hci_qca.c:1346:3: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
      if (vregs[i].load_ua)
      ^~
   drivers//bluetooth/hci_qca.c:1349:4: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
       btqca_disable_regulators(i+1, vregs);
       ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +512 drivers//bluetooth/hci_qca.c

   442	
   443	/* Initialize protocol */
   444	static int qca_open(struct hci_uart *hu)
   445	{
   446		struct qca_serdev *qcadev;
   447		struct qca_data *qca;
   448	
   449		BT_DBG("hu %p qca_open", hu);
   450	
   451		qca = kzalloc(sizeof(struct qca_data), GFP_ATOMIC);
   452		if (!qca)
   453			return -ENOMEM;
   454	
   455		skb_queue_head_init(&qca->txq);
   456		skb_queue_head_init(&qca->tx_wait_q);
   457		spin_lock_init(&qca->hci_ibs_lock);
   458		qca->workqueue = alloc_ordered_workqueue("qca_wq", 0);
   459		if (!qca->workqueue) {
   460			BT_ERR("QCA Workqueue not initialized properly");
   461			kfree(qca);
   462			return -ENOMEM;
   463		}
   464	
   465		INIT_WORK(&qca->ws_awake_rx, qca_wq_awake_rx);
   466		INIT_WORK(&qca->ws_awake_device, qca_wq_awake_device);
   467		INIT_WORK(&qca->ws_rx_vote_off, qca_wq_serial_rx_clock_vote_off);
   468		INIT_WORK(&qca->ws_tx_vote_off, qca_wq_serial_tx_clock_vote_off);
   469	
   470		qca->hu = hu;
   471	
   472		/* Assume we start with both sides asleep -- extra wakes OK */
   473		qca->tx_ibs_state = HCI_IBS_TX_ASLEEP;
   474		qca->rx_ibs_state = HCI_IBS_RX_ASLEEP;
   475	
   476		/* clocks actually on, but we start votes off */
   477		qca->tx_vote = false;
   478		qca->rx_vote = false;
   479		qca->flags = 0;
   480	
   481		qca->ibs_sent_wacks = 0;
   482		qca->ibs_sent_slps = 0;
   483		qca->ibs_sent_wakes = 0;
   484		qca->ibs_recv_wacks = 0;
   485		qca->ibs_recv_slps = 0;
   486		qca->ibs_recv_wakes = 0;
   487		qca->vote_last_jif = jiffies;
   488		qca->vote_on_ms = 0;
   489		qca->vote_off_ms = 0;
   490		qca->votes_on = 0;
   491		qca->votes_off = 0;
   492		qca->tx_votes_on = 0;
   493		qca->tx_votes_off = 0;
   494		qca->rx_votes_on = 0;
   495		qca->rx_votes_off = 0;
   496	
   497		hu->priv = qca;
   498	
   499		timer_setup(&qca->wake_retrans_timer, hci_ibs_wake_retrans_timeout, 0);
   500		qca->wake_retrans = IBS_WAKE_RETRANS_TIMEOUT_MS;
   501	
   502		timer_setup(&qca->tx_idle_timer, hci_ibs_tx_idle_timeout, 0);
   503		qca->tx_idle_delay = IBS_TX_IDLE_TIMEOUT_MS;
   504	
   505		if (hu->serdev) {
   506			serdev_device_open(hu->serdev);
   507	
   508			qcadev = serdev_device_get_drvdata(hu->serdev);
   509			if (qcadev->btsoc_type == BTQCA_CHEROKEE) {
   510				hu->init_speed = qcadev->init_speed;
   511				hu->oper_speed = qcadev->oper_speed;
 > 512				btqca_power_setup(true);
   513			} else
   514				gpiod_set_value_cansleep(qcadev->bt_en, 1);
   515		}
   516	
   517		BT_DBG("HCI_UART_QCA open, tx_idle_delay=%u, wake_retrans=%u",
   518		       qca->tx_idle_delay, qca->wake_retrans);
   519	
   520		return 0;
   521	}
   522	
   523	static void qca_debugfs_init(struct hci_dev *hdev)
   524	{
   525		struct hci_uart *hu = hci_get_drvdata(hdev);
   526		struct qca_data *qca = hu->priv;
   527		struct dentry *ibs_dir;
   528		umode_t mode;
   529	
   530		if (!hdev->debugfs)
   531			return;
   532	
   533		ibs_dir = debugfs_create_dir("ibs", hdev->debugfs);
   534	
   535		/* read only */
   536		mode = S_IRUGO;
   537		debugfs_create_u8("tx_ibs_state", mode, ibs_dir, &qca->tx_ibs_state);
   538		debugfs_create_u8("rx_ibs_state", mode, ibs_dir, &qca->rx_ibs_state);
   539		debugfs_create_u64("ibs_sent_sleeps", mode, ibs_dir,
   540				   &qca->ibs_sent_slps);
   541		debugfs_create_u64("ibs_sent_wakes", mode, ibs_dir,
   542				   &qca->ibs_sent_wakes);
   543		debugfs_create_u64("ibs_sent_wake_acks", mode, ibs_dir,
   544				   &qca->ibs_sent_wacks);
   545		debugfs_create_u64("ibs_recv_sleeps", mode, ibs_dir,
   546				   &qca->ibs_recv_slps);
   547		debugfs_create_u64("ibs_recv_wakes", mode, ibs_dir,
   548				   &qca->ibs_recv_wakes);
   549		debugfs_create_u64("ibs_recv_wake_acks", mode, ibs_dir,
   550				   &qca->ibs_recv_wacks);
   551		debugfs_create_bool("tx_vote", mode, ibs_dir, &qca->tx_vote);
   552		debugfs_create_u64("tx_votes_on", mode, ibs_dir, &qca->tx_votes_on);
   553		debugfs_create_u64("tx_votes_off", mode, ibs_dir, &qca->tx_votes_off);
   554		debugfs_create_bool("rx_vote", mode, ibs_dir, &qca->rx_vote);
   555		debugfs_create_u64("rx_votes_on", mode, ibs_dir, &qca->rx_votes_on);
   556		debugfs_create_u64("rx_votes_off", mode, ibs_dir, &qca->rx_votes_off);
   557		debugfs_create_u64("votes_on", mode, ibs_dir, &qca->votes_on);
   558		debugfs_create_u64("votes_off", mode, ibs_dir, &qca->votes_off);
   559		debugfs_create_u32("vote_on_ms", mode, ibs_dir, &qca->vote_on_ms);
   560		debugfs_create_u32("vote_off_ms", mode, ibs_dir, &qca->vote_off_ms);
   561	
   562		/* read/write */
   563		mode = S_IRUGO | S_IWUSR;
   564		debugfs_create_u32("wake_retrans", mode, ibs_dir, &qca->wake_retrans);
   565		debugfs_create_u32("tx_idle_delay", mode, ibs_dir,
   566				   &qca->tx_idle_delay);
   567	}
   568	
   569	/* Flush protocol data */
   570	static int qca_flush(struct hci_uart *hu)
   571	{
   572		struct qca_data *qca = hu->priv;
   573	
   574		BT_DBG("hu %p qca flush", hu);
   575	
   576		skb_queue_purge(&qca->tx_wait_q);
   577		skb_queue_purge(&qca->txq);
   578	
   579		return 0;
   580	}
   581	
   582	/* Close protocol */
   583	static int qca_close(struct hci_uart *hu)
   584	{
   585		struct qca_serdev *qcadev;
   586		struct qca_data *qca = hu->priv;
   587	
   588		BT_DBG("hu %p qca close", hu);
   589	
   590		serial_clock_vote(HCI_IBS_VOTE_STATS_UPDATE, hu);
   591	
   592		skb_queue_purge(&qca->tx_wait_q);
   593		skb_queue_purge(&qca->txq);
   594		del_timer(&qca->tx_idle_timer);
   595		del_timer(&qca->wake_retrans_timer);
   596		destroy_workqueue(qca->workqueue);
   597		qca->hu = NULL;
   598	
   599		if (hu->serdev) {
   600			serdev_device_close(hu->serdev);
   601	
   602			qcadev = serdev_device_get_drvdata(hu->serdev);
   603			if (qcadev->btsoc_type == BTQCA_CHEROKEE)
 > 604				qca_btsoc_cleanup(hu->hdev);
   605			else
   606				gpiod_set_value_cansleep(qcadev->bt_en, 0);
   607		}
   608	
   609		kfree_skb(qca->rx_skb);
   610	
   611		hu->priv = NULL;
   612	
   613		kfree(qca);
   614	
   615		return 0;
   616	}
   617	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--/04w6evG8XlLl3ft
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--/04w6evG8XlLl3ft--
