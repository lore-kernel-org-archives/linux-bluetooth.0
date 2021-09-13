Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE88FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Sep 2021 20:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96C2C6103B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Sep 2021 20:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244673AbhIMU66 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Sep 2021 16:58:58 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:39026 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243745AbhIMU65 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Sep 2021 16:58:57 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id DA5EBCECCB;
        Mon, 13 Sep 2021 22:57:39 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [Bluez PATCH v3 05/12] tools: Inclusive language changes
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210902184744.Bluez.v3.5.I700d72f935b48346f2e74088152eeef41dc5b938@changeid>
Date:   Mon, 13 Sep 2021 22:57:39 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <423AB893-D603-4CE0-8059-18308EF7914E@holtmann.org>
References: <20210902104938.824737-1-apusaka@google.com>
 <20210902184744.Bluez.v3.5.I700d72f935b48346f2e74088152eeef41dc5b938@changeid>
To:     Archie Pusaka <apusaka@google.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

> BT core spec 5.3 promotes the usage of inclusive languages.
> This CL replaces some terms with the more appropriate counterparts,
> such as "central", "peripheral", "accept list", "reject list", and
> "temporary link key". Note that some suggestions come from
> https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> * Merging several patches from the same directory into one
> 
> tools/3dsp.c               |  33 +++++-----
> tools/bdaddr.rst           |   2 +-
> tools/btiotest.c           |  22 +++----
> tools/btpclientctl.c       |   2 +-
> tools/hci-tester.c         |  12 ++--
> tools/hciconfig.c          |  26 ++++----
> tools/hciconfig.rst        |  24 ++++----
> tools/hcitool.c            | 102 +++++++++++++++----------------
> tools/hcitool.rst          |  30 +++++-----
> tools/l2cap-tester.c       |  24 ++++----
> tools/l2test.c             |  18 +++---
> tools/mesh-cfgclient.c     |   4 +-
> tools/mesh-gatt/mesh-net.h |   4 +-
> tools/mesh-gatt/net.c      |  60 +++++++++----------
> tools/mesh/mesh-db.c       |  28 ++++-----
> tools/mesh/mesh-db.h       |   4 +-
> tools/mesh/remote.c        |  53 ++++++++--------
> tools/mesh/remote.h        |   5 +-
> tools/meshctl.c            |   6 +-
> tools/mgmt-tester.c        | 120 +++++++++++++++++++------------------
> tools/oobtest.c            |   8 +--
> tools/parser/avdtp.c       |   4 +-
> tools/parser/csr.c         |  17 +++---
> tools/parser/ericsson.c    |   2 +-
> tools/parser/hci.c         |  35 +++++------
> tools/parser/lmp.c         | 112 +++++++++++++++++-----------------
> tools/parser/parser.h      |   2 +-
> tools/parser/smp.c         |  12 ++--
> tools/rctest.c             |  18 +++---
> tools/rctest.rst           |   4 +-
> tools/rfcomm-tester.c      |  14 ++---
> tools/rfcomm.c             |  14 ++---
> tools/rfcomm.rst           |   2 +-
> tools/sco-tester.c         |  10 ++--
> tools/smp-tester.c         |  12 ++--
> 35 files changed, 423 insertions(+), 422 deletions(-)
> 
> diff --git a/tools/3dsp.c b/tools/3dsp.c
> index 5227c30b63..267a39e904 100644
> --- a/tools/3dsp.c
> +++ b/tools/3dsp.c
> @@ -112,10 +112,10 @@ static void start_inquiry(void)
> 						inquiry_started, NULL, NULL);
> }
> 
> -static void set_slave_broadcast_receive(const void *data, uint8_t size,
> +static void set_peripheral_broadcast_receive(const void *data, uint8_t size,
> 							void *user_data)
> {
> -	printf("Slave broadcast receiption enabled\n");
> +	printf("Peripheral broadcast reception enabled\n");
> }
> 
> static void sync_train_received(const void *data, uint8_t size,
> @@ -149,7 +149,7 @@ static void sync_train_received(const void *data, uint8_t size,
> 
> 	bt_hci_send(hci_dev, BT_HCI_CMD_SET_PERIPHERAL_BROADCAST_RECEIVE,
> 				&cmd, sizeof(cmd),
> -				set_slave_broadcast_receive, NULL, NULL);
> +				set_peripheral_broadcast_receive, NULL, NULL);
> }
> 
> static void brcm_sync_train_received(const void *data, uint8_t size,
> @@ -183,7 +183,7 @@ static void brcm_sync_train_received(const void *data, uint8_t size,
> 
> 	bt_hci_send(hci_dev, BT_HCI_CMD_SET_PERIPHERAL_BROADCAST_RECEIVE,
> 				&cmd, sizeof(cmd),
> -				set_slave_broadcast_receive, NULL, NULL);
> +				set_peripheral_broadcast_receive, NULL, NULL);
> }
> 
> static void truncated_page_complete(const void *data, uint8_t size,
> @@ -209,7 +209,7 @@ static void truncated_page_complete(const void *data, uint8_t size,
> 							NULL, NULL, NULL);
> }
> 
> -static void slave_broadcast_timeout(const void *data, uint8_t size,
> +static void peripheral_broadcast_timeout(const void *data, uint8_t size,
> 							void *user_data)
> {
> 	const struct bt_hci_evt_peripheral_broadcast_timeout *evt = data;
> @@ -226,7 +226,7 @@ static void slave_broadcast_timeout(const void *data, uint8_t size,
> 							NULL, NULL, NULL);
> }
> 
> -static void slave_broadcast_receive(const void *data, uint8_t size,
> +static void peripheral_broadcast_receive(const void *data, uint8_t size,
> 							void *user_data)
> {
> 	const struct bt_hci_evt_peripheral_broadcast_receive *evt = data;
> @@ -327,9 +327,9 @@ static void start_glasses(void)
> 	bt_hci_register(hci_dev, BT_HCI_EVT_TRUNCATED_PAGE_COMPLETE,
> 					truncated_page_complete, NULL, NULL);
> 	bt_hci_register(hci_dev, BT_HCI_EVT_PERIPHERAL_BROADCAST_TIMEOUT,
> -					slave_broadcast_timeout, NULL, NULL);
> +				peripheral_broadcast_timeout, NULL, NULL);
> 	bt_hci_register(hci_dev, BT_HCI_EVT_PERIPHERAL_BROADCAST_RECEIVE,
> -					slave_broadcast_receive, NULL, NULL);
> +				peripheral_broadcast_receive, NULL, NULL);
> 
> 	start_inquiry();
> }
> @@ -381,7 +381,7 @@ static void conn_request(const void *data, uint8_t size, void *user_data)
> 	start_sync_train();
> }
> 
> -static void slave_page_response_timeout(const void *data, uint8_t size,
> +static void peripheral_page_response_timeout(const void *data, uint8_t size,
> 							void *user_data)
> {
> 	printf("Incoming truncated page received\n");
> @@ -389,8 +389,8 @@ static void slave_page_response_timeout(const void *data, uint8_t size,
> 	start_sync_train();
> }
> 
> -static void slave_broadcast_channel_map_change(const void *data, uint8_t size,
> -								void *user_data)
> +static void peripheral_broadcast_channel_map_change(const void *data,
> +						uint8_t size, void *user_data)
> {
> 	printf("Broadcast channel map changed\n");
> 
> @@ -447,13 +447,14 @@ static void read_clock(const void *data, uint8_t size, void *user_data)
> 			bcastdata, sizeof(bcastdata), NULL, NULL, NULL);
> }
> 
> -static void set_slave_broadcast(const void *data, uint8_t size, void *user_data)
> +static void set_peripheral_broadcast(const void *data, uint8_t size,
> +								void *user_data)
> {
> 	const struct bt_hci_rsp_set_peripheral_broadcast *rsp = data;
> 	struct bt_hci_cmd_read_clock cmd;
> 
> 	if (rsp->status) {
> -		printf("Failed to set slave broadcast transmission\n");
> +		printf("Failed to set peripheral broadcast transmission\n");
> 		shutdown_device();
> 		return;
> 	}
> @@ -493,10 +494,10 @@ static void start_display(void)
> 						conn_request, NULL, NULL);
> 
> 	bt_hci_register(hci_dev, BT_HCI_EVT_PERIPHERAL_PAGE_RESPONSE_TIMEOUT,
> -				slave_page_response_timeout, NULL, NULL);
> +				peripheral_page_response_timeout, NULL, NULL);
> 	bt_hci_register(hci_dev,
> 			BT_HCI_EVT_PERIPHERAL_BROADCAST_CHANNEL_MAP_CHANGE,
> -			slave_broadcast_channel_map_change, NULL, NULL);
> +			peripheral_broadcast_channel_map_change, NULL, NULL);
> 	bt_hci_register(hci_dev, BT_HCI_EVT_SYNC_TRAIN_COMPLETE,
> 					sync_train_complete, NULL, NULL);
> 
> @@ -512,7 +513,7 @@ static void start_display(void)
> 	cmd.timeout = cpu_to_le16(0xfffe);
> 
> 	bt_hci_send(hci_dev, BT_HCI_CMD_SET_PERIPHERAL_BROADCAST, &cmd,
> -			sizeof(cmd), set_slave_broadcast, NULL, NULL);
> +			sizeof(cmd), set_peripheral_broadcast, NULL, NULL);
> }
> 
> static void signal_callback(int signum, void *user_data)
> diff --git a/tools/bdaddr.rst b/tools/bdaddr.rst
> index 1d21e2ca39..a84950bc35 100644
> --- a/tools/bdaddr.rst
> +++ b/tools/bdaddr.rst
> @@ -61,7 +61,7 @@ FILES
> =====
> 
> /usr/share/misc/oui.txt
> -    IEEE Organizationally Unique Identifier master file.
> +    IEEE Organizationally Unique Identifier consolidated file.
>     Manually update from: http://standards.ieee.org/regauth/oui/oui.txt
> 
> 
> diff --git a/tools/btiotest.c b/tools/btiotest.c
> index 3f4900a5a5..1da8c20caf 100644
> --- a/tools/btiotest.c
> +++ b/tools/btiotest.c
> @@ -310,7 +310,7 @@ static void l2cap_connect(const char *src, const char *dst, uint8_t addr_type,
> static void l2cap_listen(const char *src, uint8_t addr_type, uint16_t psm,
> 				uint16_t cid, int defer, int reject,
> 				int disconn, int accept, int sec,
> -				gboolean master)
> +				gboolean central)
> {
> 	struct io_data *data;
> 	BtIOConnect conn;
> @@ -343,7 +343,7 @@ static void l2cap_listen(const char *src, uint8_t addr_type, uint16_t psm,
> 					BT_IO_OPT_PSM, psm,
> 					BT_IO_OPT_CID, cid,
> 					BT_IO_OPT_SEC_LEVEL, sec,
> -					BT_IO_OPT_CENTRAL, master,
> +					BT_IO_OPT_CENTRAL, central,
> 					BT_IO_OPT_INVALID);
> 	else
> 		l2_srv = bt_io_listen(conn, cfm, data,
> @@ -353,7 +353,7 @@ static void l2cap_listen(const char *src, uint8_t addr_type, uint16_t psm,
> 					BT_IO_OPT_PSM, psm,
> 					BT_IO_OPT_CID, cid,
> 					BT_IO_OPT_SEC_LEVEL, sec,
> -					BT_IO_OPT_CENTRAL, master,
> +					BT_IO_OPT_CENTRAL, central,
> 					BT_IO_OPT_INVALID);
> 
> 	if (!l2_srv) {
> @@ -402,7 +402,7 @@ static void rfcomm_connect(const char *src, const char *dst, uint8_t ch,
> 
> static void rfcomm_listen(const char *src, uint8_t ch, gboolean defer,
> 				int reject, int disconn, int accept,
> -				int sec, gboolean master)
> +				int sec, gboolean central)
> {
> 	struct io_data *data;
> 	BtIOConnect conn;
> @@ -427,7 +427,7 @@ static void rfcomm_listen(const char *src, uint8_t ch, gboolean defer,
> 					BT_IO_OPT_SOURCE, src,
> 					BT_IO_OPT_CHANNEL, ch,
> 					BT_IO_OPT_SEC_LEVEL, sec,
> -					BT_IO_OPT_CENTRAL, master,
> +					BT_IO_OPT_CENTRAL, central,
> 					BT_IO_OPT_INVALID);
> 	else
> 		rc_srv = bt_io_listen(conn, cfm,
> @@ -435,7 +435,7 @@ static void rfcomm_listen(const char *src, uint8_t ch, gboolean defer,
> 					&err,
> 					BT_IO_OPT_CHANNEL, ch,
> 					BT_IO_OPT_SEC_LEVEL, sec,
> -					BT_IO_OPT_CENTRAL, master,
> +					BT_IO_OPT_CENTRAL, central,
> 					BT_IO_OPT_INVALID);
> 
> 	if (!rc_srv) {
> @@ -540,7 +540,7 @@ static int opt_reject = -1;
> static int opt_disconn = -1;
> static int opt_accept = DEFAULT_ACCEPT_TIMEOUT;
> static int opt_sec = 0;
> -static gboolean opt_master = FALSE;
> +static gboolean opt_central = FALSE;
> static int opt_priority = 0;
> static int opt_cid = 0;
> static guint8 opt_addr_type = 0;
> @@ -576,8 +576,8 @@ static GOptionEntry options[] = {
> 				"Disconnect connection after N seconds" },
> 	{ "accept", 'a', 0, G_OPTION_ARG_INT, &opt_accept,
> 				"Accept connection after N seconds" },
> -	{ "master", 'm', 0, G_OPTION_ARG_NONE, &opt_master,
> -				"Master role switch (incoming connections)" },
> +	{ "central", 'C', 0, G_OPTION_ARG_NONE, &opt_central,
> +				"Central role switch (incoming connections)" },
> 	{ "priority", 'P', 0, G_OPTION_ARG_INT, &opt_priority,
> 				"Transmission priority: Setting a priority "
> 				"outside the range 0 to 6 requires the"
> @@ -614,7 +614,7 @@ int main(int argc, char *argv[])
> 		else
> 			l2cap_listen(opt_dev, opt_addr_type, opt_psm, opt_cid,
> 					opt_defer, opt_reject, opt_disconn,
> -					opt_accept, opt_sec, opt_master);
> +					opt_accept, opt_sec, opt_central);
> 	}
> 
> 	if (opt_channel != -1) {
> @@ -624,7 +624,7 @@ int main(int argc, char *argv[])
> 		else
> 			rfcomm_listen(opt_dev, opt_channel, opt_defer,
> 					opt_reject, opt_disconn, opt_accept,
> -					opt_sec, opt_master);
> +					opt_sec, opt_central);
> 	}
> 
> 	if (opt_sco) {
> diff --git a/tools/btpclientctl.c b/tools/btpclientctl.c
> index 6553f2f3a7..c30d5bd4e7 100644
> --- a/tools/btpclientctl.c
> +++ b/tools/btpclientctl.c
> @@ -676,7 +676,7 @@ const struct indexstr_data ad_type_table[] = {
> 	{ 0x10, "BT_AD_DEVICE_ID" },
> 	{ 0x10, "BT_AD_SMP_TK" },
> 	{ 0x11, "BT_AD_SMP_OOB_FLAGS" },
> -	{ 0x12, "BT_AD_SLAVE_CONN_INTERVAL" },
> +	{ 0x12, "BT_AD_PERIPHERAL_CONN_INTERVAL" },
> 	{ 0x14, "BT_AD_SOLICIT16" },
> 	{ 0x15, "BT_AD_SOLICIT128" },
> 	{ 0x16, "BT_AD_SERVICE_DATA16" },
> diff --git a/tools/hci-tester.c b/tools/hci-tester.c
> index 645d89e721..79193220fe 100644
> --- a/tools/hci-tester.c
> +++ b/tools/hci-tester.c
> @@ -335,12 +335,12 @@ static void test_read_local_supported_codecs(const void *test_data)
> 	test_command(BT_HCI_CMD_READ_LOCAL_CODECS);
> }
> 
> -static void test_le_read_white_list_size(const void *test_data)
> +static void test_le_read_accept_list_size(const void *test_data)
> {
> 	test_command(BT_HCI_CMD_LE_READ_ACCEPT_LIST_SIZE);
> }
> 
> -static void test_le_clear_white_list(const void *test_data)
> +static void test_le_clear_accept_list(const void *test_data)
> {
> 	test_command(BT_HCI_CMD_LE_CLEAR_ACCEPT_LIST);
> }
> @@ -944,10 +944,10 @@ int main(int argc, char *argv[])
> 	test_hci_local("Read Local Supported Codecs", NULL, NULL,
> 				test_read_local_supported_codecs);
> 
> -	test_hci_local("LE Read White List Size", NULL, NULL,
> -				test_le_read_white_list_size);
> -	test_hci_local("LE Clear White List", NULL, NULL,
> -				test_le_clear_white_list);
> +	test_hci_local("LE Read Accept List Size", NULL, NULL,
> +				test_le_read_accept_list_size);
> +	test_hci_local("LE Clear Accept List", NULL, NULL,
> +				test_le_clear_accept_list);
> 	test_hci_local("LE Encrypt", NULL, NULL,
> 				test_le_encrypt);
> 	test_hci_local("LE Rand", NULL, NULL,
> diff --git a/tools/hciconfig.c b/tools/hciconfig.c
> index 491f216135..2bc9fe84c3 100644
> --- a/tools/hciconfig.c
> +++ b/tools/hciconfig.c
> @@ -116,8 +116,8 @@ static void print_le_states(uint64_t states)
> 		"Directed Advertising State",
> 		"Passive Scanning State",
> 		"Active Scanning State",
> -		"Initiating State/Connection State in Master Role",
> -		"Connection State in the Slave Role",
> +		"Initiating State/Connection State in Central Role",
> +		"Connection State in the Peripheral Role",
> 		"Non-connectable Advertising State and Passive Scanning State combination",
> 		"Scannable Advertising State and Passive Scanning State combination",
> 		"Connectable Advertising State and Passive Scanning State combination",
> @@ -128,17 +128,17 @@ static void print_le_states(uint64_t states)
> 		"Directed Advertising State and Active Scanning State combination",
> 		"Non-connectable Advertising State and Initiating State combination",
> 		"Scannable Advertising State and Initiating State combination",
> -		"Non-connectable Advertising State and Master Role combination",
> -		"Scannable Advertising State and Master Role combination",
> -		"Non-connectable Advertising State and Slave Role combination",
> -		"Scannable Advertising State and Slave Role combination",
> +		"Non-connectable Advertising State and Central Role combination",
> +		"Scannable Advertising State and Central Role combination",
> +		"Non-connectable Advertising State and Peripheral Role combination",
> +		"Scannable Advertising State and Peripheral Role combination",
> 		"Passive Scanning State and Initiating State combination",
> 		"Active Scanning State and Initiating State combination",
> -		"Passive Scanning State and Master Role combination",
> -		"Active Scanning State and Master Role combination",
> -		"Passive Scanning State and Slave Role combination",
> -		"Active Scanning State and Slave Role combination",
> -		"Initiating State and Master Role combination/Master Role and Master Role combination",
> +		"Passive Scanning State and Central Role combination",
> +		"Active Scanning State and Central Role combination",
> +		"Passive Scanning State and Peripheral Role combination",
> +		"Active Scanning State and Peripheral Role combination",
> +		"Initiating State and Central Role combination/Central Role and Central Role combination",
> 		NULL
> 	};
> 
> @@ -1922,8 +1922,8 @@ static struct {
> 	{ "features",	cmd_features,	0,		"Display device features" },
> 	{ "version",	cmd_version,	0,		"Display version information" },
> 	{ "revision",	cmd_revision,	0,		"Display revision information" },
> -	{ "block",	cmd_block,	"<bdaddr>",	"Add a device to the blacklist" },
> -	{ "unblock",	cmd_unblock,	"<bdaddr>",	"Remove a device from the blacklist" },
> +	{ "block",	cmd_block,	"<bdaddr>",	"Add a device to the reject list" },
> +	{ "unblock",	cmd_unblock,	"<bdaddr>",	"Remove a device from the reject list" },
> 	{ "lerandaddr", cmd_le_addr,	"<bdaddr>",	"Set LE Random Address" },
> 	{ "leadv",	cmd_le_adv,	"[type]",	"Enable LE advertising"
> 		"\n\t\t\t0 - Connectable undirected advertising (default)"
> diff --git a/tools/hciconfig.rst b/tools/hciconfig.rst
> index 7d59b4046e..2d56eeb413 100644
> --- a/tools/hciconfig.rst
> +++ b/tools/hciconfig.rst
> @@ -216,24 +216,24 @@ revision
>     Display revision information.
> 
> lm [*mode*]
> -    With no *mode*, prints link mode. **MASTER** or **SLAVE** mean,
> -    respectively, to ask to become master or to remain slave when a connection
> -    request comes in. The additional keyword **ACCEPT** means that baseband
> -    connections will be accepted even if there are no listening *AF_BLUETOOTH*
> -    sockets. *mode* is **NONE** or a comma-separated list of keywords, where
> -    possible keywords are **MASTER** and **ACCEPT**. **NONE** sets link policy
> -    to the default behaviour of remaining slave and not accepting baseband
> -    connections when there are no listening *AF_BLUETOOTH* sockets.  If
> -    **MASTER** is  present, the device will ask to become master if a
> -    connection request comes in. If **ACCEPT** is present, the device will
> +    With no *mode*, prints link mode. **CENTRAL** or **PERIPHERAL** mean,
> +    respectively, to ask to become central or to remain peripheral when a
> +    connection request comes in. The additional keyword **ACCEPT** means that
> +    baseband connections will be accepted even if there are no listening
> +    *AF_BLUETOOTH* sockets. *mode* is **NONE** or a comma-separated list of
> +    keywords, where possible keywords are **CENTRAL** and **ACCEPT**. **NONE**
> +    sets link policy to the default behaviour of remaining peripheral and not
> +    accepting baseband connections when there are no listening *AF_BLUETOOTH*
> +    sockets.  If **CENTRAL** is  present, the device will ask to become central
> +    if a connection request comes in. If **ACCEPT** is present, the device will
>     accept baseband connections even when there are no listening *AF_BLUETOOTH*
>     sockets.
> 
> block <*bdaddr*>
> -    Add a device to the blacklist
> +    Add a device to the reject list
> 
> unblock <*bdaddr*>
> -    Remove a device from the blacklist
> +    Remove a device from the reject list
> 
> lerandaddr <*bdaddr*>
>     Set LE Random Address
> diff --git a/tools/hcitool.c b/tools/hcitool.c
> index c6a9093733..6e6a39ed2f 100644
> --- a/tools/hcitool.c
> +++ b/tools/hcitool.c
> @@ -1210,10 +1210,10 @@ static struct option cc_options[] = {
> 
> static const char *cc_help =
> 	"Usage:\n"
> -	"\tcc [--role=m|s] [--ptype=pkt_types] <bdaddr>\n"
> +	"\tcc [--role=c|p] [--ptype=pkt_types] <bdaddr>\n"
> 	"Example:\n"
> 	"\tcc --ptype=dm1,dh3,dh5 01:02:03:04:05:06\n"
> -	"\tcc --role=m 01:02:03:04:05:06\n";
> +	"\tcc --role=c 01:02:03:04:05:06\n";
> 
> static void cmd_cc(int dev_id, int argc, char **argv)
> {
> @@ -1360,10 +1360,10 @@ static void cmd_sr(int dev_id, int argc, char **argv)
> 
> 	str2ba(argv[0], &bdaddr);
> 	switch (argv[1][0]) {
> -	case 'm':
> +	case 'c':
> 		role = 0;
> 		break;
> -	case 's':
> +	case 'p':
> 		role = 1;
> 		break;

as I said before, I have an objection to a simple search and replace here. There is plenty of 20+ old docs out there that expect certain parameters to work. Not to mention all the external how-to-qualify BlueZ documentation.

So I am fine with changing the documentation and introducing the new parameters, but the old ones have to keep working. We can add a comment for them to be removed, but the brute force change here is potentially causing friction.

And I would put the changes that touch command line parameters into a separate patch. Since the internal changes look fine.

Regards

Marcel

