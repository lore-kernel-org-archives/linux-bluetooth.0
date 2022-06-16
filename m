Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7717BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jun 2022 19:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378481AbiFPT6T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jun 2022 15:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378469AbiFPT6N (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jun 2022 15:58:13 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31762A719
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jun 2022 12:58:11 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id r1so2083030plo.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jun 2022 12:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BYvMPzooqLhsj7GljNraofl+4iLwxPDzg6NSJeDYJCA=;
        b=NlSl/bknRQIumhPMB3WwbSvg+EyyddWI8p+FIs1PWQpTLF6yGJVVYKIztt/FOcKrI3
         QlhsN5EW4/8f8ZstRAEmeY8eYdXIbowF0Y4WJY/GGLunz8pgshYHmsdgLwVrpdk0XH/x
         PiWImXAkcfXp99A2aceAvOmwDWQpX1fbn5iisGmcV8ClcLfYlDt8Iw7p/kmEA5jaqdvz
         POM7Rw9ch6sAIr5NkuKSCkgISbJ7We0UMfc1CZS+uHSuDLY0hMzmsrkyNdJIdMARGld+
         c6kyjU3x4KouGlfkWh+v3guQft57soy1AjWbnXf4EnuUcS8nULhzMOrb/KdJir2siIYQ
         ErCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BYvMPzooqLhsj7GljNraofl+4iLwxPDzg6NSJeDYJCA=;
        b=u1nSWoM2WGIg4A5c+PNmxCcbRwpnvJkH1RgoA6i7Dk2E9neGAtvlHVRFXnOU+tXw+T
         D4CzkFnK58f4YN7WwSTD+YU9crkGkYQVyEYy9mt9p2xj2AUz4te5xsDB0B7U2j8QSF9t
         s48EVWMRCYPflnPvl8robM4AcbQ7K8stc9c/LLzhwF22bJomxtuD98gv+UZjeC3H57je
         cZVCq5dAibWX/GMUKwB5IsbKVy41Cuth/bZkHfir4f7/2JpXem5KmzlFd7yO/RLusSYP
         J/Rtf9/HRsHMgyvT12x+tRqjg4iHJLcdoQtKpI13CjG5H8jMZxQVpsx+wPIuDA/IIU8i
         UCCQ==
X-Gm-Message-State: AJIora/5o+wF2Ku2uDhy3l2Co2vmJfaTVabqRMxW/ny/ajw90Es+ppLt
        D5eFVvqmkfzd2JMeDcCrxDk8xXEnrDI=
X-Google-Smtp-Source: AGRyM1vWtCC9SSoHVOPaEJIfIbl8MNpl2xYEnFPTQ9rf2r6GzRtTQAf4mLb6iaIrKyswDOVKdUs6aA==
X-Received: by 2002:a17:902:f60c:b0:16a:239:bcf7 with SMTP id n12-20020a170902f60c00b0016a0239bcf7mr933405plg.130.1655409491172;
        Thu, 16 Jun 2022 12:58:11 -0700 (PDT)
Received: from han1-ubuntu-dev.. ([192.102.209.8])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902edd700b0016a034ae481sm89285plk.176.2022.06.16.12.58.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 12:58:10 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 3/3] tools/btmgmt: Add support Add Ext Adv command
Date:   Thu, 16 Jun 2022 12:58:03 -0700
Message-Id: <20220616195803.99346-3-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616195803.99346-1-hj.tedd.an@gmail.com>
References: <20220616195803.99346-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds new command to support the following MGMT API:
 Add Extended Advertising Parameters Command
 Add Extended Advertising Data Command
---
 tools/btmgmt.c | 377 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 377 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 8f63f12ba..3bf2c21c1 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -4891,6 +4891,377 @@ static void cmd_clr_adv(int argc, char **argv)
 	cmd_rm_adv(2, rm_argv);
 }
 
+static void add_ext_adv_params_rsp(uint8_t status, uint16_t len,
+					const void *param, void *user_data)
+{
+	const struct mgmt_rp_add_ext_adv_params *rp = param;
+
+	if (status != 0) {
+		error("Add Ext Adv Params failed status 0x%02x (%s)",
+						status, mgmt_errstr(status));
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (len != sizeof(*rp)) {
+		error("Invalid Add Ext Adv Params response length (%u)", len);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	print("Instance added: %u", rp->instance);
+	print("Tx Power: %u", rp->tx_power);
+	print("Max adv data len: %u", rp->max_adv_data_len);
+	print("Max scan resp len: %u", rp->max_scan_rsp_len);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void add_ext_adv_params_usage(void)
+{
+	bt_shell_usage();
+	print("Options:\n"
+		"\t -d, --duration <duration>  Duration in seconds\n"
+		"\t -t, --timeout <timeout>    Timeout in seconds\n"
+		"\t -r, --min-interval <valr>  Minimum interval\n"
+		"\t -x, --max-interval <valr>  Maximum interval\n"
+		"\t -w, --tx-power <power>     Tx power\n"
+		"\t -P, --phy <phy>            Phy type, Specify 1M/2M/CODED\n"
+		"\t -c, --connectable          \"connectable\" flag\n"
+		"\t -g, --general-discov       \"general-discoverable\" flag\n"
+		"\t -l, --limited-discov       \"limited-discoverable\" flag\n"
+		"\t -m, --managed-flags        \"managed-flags\" flag\n"
+		"\t -p, --add-tx-power         \"tx-power\" flag\n"
+		"\t -a, --scan-rsp-appearance  \"appearance\" flag\n"
+		"\t -n, --scan-rsp-local-name  \"local-name\" flag\n"
+		"\t -s, --adv-scan-rsp         \"scan resp in adv\" flag\n"
+		"\t -h, --help                 Show help\n"
+		"e.g.:\n"
+		"\tadd-ext-adv-params -r 0x801 -x 0x802 -P 2M -g 1");
+}
+
+static struct option add_ext_adv_params_options[] = {
+	{ "help",		0, 0, 'h' },
+	{ "duration",		1, 0, 'd' },
+	{ "timeout",		1, 0, 't' },
+	{ "min-internal",	1, 0, 'r' },
+	{ "max-interval",	1, 0, 'x' },
+	{ "tx-power",		1, 0, 'w' },
+	{ "phy",		1, 0, 'P' },
+	{ "connectable",	0, 0, 'c' },
+	{ "general-discov",	0, 0, 'g' },
+	{ "limited-discov",	0, 0, 'l' },
+	{ "scan-rsp-local-name", 0, 0, 'n' },
+	{ "scan-rsp-appearance", 0, 0, 'a' },
+	{ "managed-flags",	0, 0, 'm' },
+	{ "add-tx-power",	0, 0, 'p' },
+	{ "adv-scan-rsp",	0, 0, 's' },
+	{ 0, 0, 0, 0}
+};
+
+static void cmd_add_ext_adv_params(int argc, char **argv)
+{
+	struct mgmt_cp_add_ext_adv_params *cp = NULL;
+	int opt;
+	uint16_t timeout = 0, duration = 0;
+	uint8_t instance;
+	bool success = false;
+	bool quit = true;
+	uint32_t flags = 0;
+	uint32_t min_interval = 0;
+	uint32_t max_interval = 0;
+	uint8_t tx_power = 0;
+	uint16_t index;
+
+	while ((opt = getopt_long(argc, argv, "d:t:r:x:w:P:cglmpansh",
+				add_ext_adv_params_options, NULL)) != -1) {
+		switch (opt) {
+		case 'd':
+			duration = strtol(optarg, NULL, 0);
+			flags |= MGMT_ADV_PARAM_DURATION;
+			break;
+		case 't':
+			timeout = strtol(optarg, NULL, 0);
+			flags |= MGMT_ADV_PARAM_TIMEOUT;
+			break;
+		case 'r':
+			min_interval = strtol(optarg, NULL, 0);
+			break;
+		case 'x':
+			max_interval = strtol(optarg, NULL, 0);
+			break;
+		case 'w':
+			tx_power = strtol(optarg, NULL, 0);
+			flags |= MGMT_ADV_PARAM_TX_POWER;
+			break;
+		case 'P':
+			if (strcasecmp(optarg, "1M") == 0)
+				flags |= MGMT_ADV_FLAG_SEC_1M;
+			else if (strcasecmp(optarg, "2M") == 0)
+				flags |= MGMT_ADV_FLAG_SEC_2M;
+			else if (strcasecmp(optarg, "CODED") == 0)
+				flags |= MGMT_ADV_FLAG_SEC_CODED;
+			else
+				goto done;
+			break;
+		case 'c':
+			flags |= MGMT_ADV_FLAG_CONNECTABLE;
+			break;
+		case 'g':
+			flags |= MGMT_ADV_FLAG_DISCOV;
+			break;
+		case 'l':
+			flags |= MGMT_ADV_FLAG_LIMITED_DISCOV;
+			break;
+		case 'n':
+			flags |= MGMT_ADV_FLAG_LOCAL_NAME;
+			break;
+		case 'a':
+			flags |= MGMT_ADV_FLAG_APPEARANCE;
+			break;
+		case 'm':
+			flags |= MGMT_ADV_FLAG_MANAGED_FLAGS;
+			break;
+		case 'p':
+			flags |= MGMT_ADV_FLAG_TX_POWER;
+			break;
+		case 's':
+			flags |= MGMT_ADV_PARAM_SCAN_RSP;
+			break;
+		case 'h':
+			success = true;
+			/* fall through */
+		default:
+			add_ext_adv_params_usage();
+			optind = 0;
+			goto done;
+		}
+	}
+
+	argc -= optind;
+	argv += optind;
+	optind = 0;
+
+	if (argc != 1) {
+		add_ext_adv_params_usage();
+		goto done;
+	}
+
+	/* Only if both min_interval and max_interval are defined */
+	if (min_interval && max_interval)
+		flags |= MGMT_ADV_PARAM_INTERVALS;
+
+	instance = strtol(argv[0], NULL, 0);
+
+	index = mgmt_index;
+	if (index == MGMT_INDEX_NONE)
+		index = 0;
+
+	cp = malloc0(sizeof(*cp));
+	if (!cp)
+		goto done;
+
+	cp->instance = instance;
+	put_le32(flags, &cp->flags);
+	put_le16(timeout, &cp->timeout);
+	put_le16(duration, &cp->duration);
+	put_le32(min_interval, &cp->min_interval);
+	put_le32(max_interval, &cp->max_interval);
+	cp->tx_power = tx_power;
+
+	if (!mgmt_send(mgmt, MGMT_OP_ADD_EXT_ADV_PARAMS, index, sizeof(*cp), cp,
+					add_ext_adv_params_rsp, NULL, NULL)) {
+		error("Unable to send \"Add Ext Advertising Params\" command");
+		goto done;
+	}
+
+	quit = false;
+
+done:
+	free(cp);
+
+	if (quit)
+		bt_shell_noninteractive_quit(success ?
+						EXIT_SUCCESS : EXIT_FAILURE);
+}
+
+static void add_ext_adv_data_rsp(uint8_t status, uint16_t len,
+					const void *param, void *user_data)
+{
+	const struct mgmt_rp_add_ext_adv_data *rp = param;
+
+	if (status != 0) {
+		error("Add Ext Advertising Data failed with status 0x%02x (%s)",
+						status, mgmt_errstr(status));
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (len != sizeof(*rp)) {
+		error("Invalid Add Ext Advertising Data response length (%u)",
+									len);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	print("Instance added: %u", rp->instance);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void add_ext_adv_data_usage(void)
+{
+	bt_shell_usage();
+	print("Options:\n"
+		"\t -u, --uuid <uuid>         Service UUID\n"
+		"\t -d, --adv-data <data>     Advertising Data bytes\n"
+		"\t -s, --scan-rsp <data>     Scan Response Data bytes\n"
+		"e.g.:\n"
+		"\tadd-ext-adv-data -u 180d -u 180f -d 080954657374204C45 1");
+}
+
+static struct option add_ext_adv_data_options[] = {
+	{ "help",		0, 0, 'h' },
+	{ "uuid",		1, 0, 'u' },
+	{ "adv-data",		1, 0, 'd' },
+	{ "scan-rsp",		1, 0, 's' },
+	{ 0, 0, 0, 0}
+};
+
+static void cmd_add_ext_adv_data(int argc, char **argv)
+{
+	struct mgmt_cp_add_ext_adv_data *cp = NULL;
+	int opt;
+	uint8_t *adv_data = NULL, *scan_rsp = NULL;
+	size_t adv_len = 0, scan_rsp_len = 0;
+	size_t cp_len;
+	uint8_t uuids[MAX_AD_UUID_BYTES];
+	size_t uuid_bytes = 0;
+	uint8_t uuid_type = 0;
+	uint8_t instance;
+	uuid_t uuid;
+	bool success = false;
+	bool quit = true;
+	uint16_t index;
+
+	while ((opt = getopt_long(argc, argv, "+u:d:s:h",
+				add_ext_adv_data_options, NULL)) != -1) {
+		switch (opt) {
+		case 'u':
+			if (bt_string2uuid(&uuid, optarg) < 0) {
+				print("Invalid UUID: %s", optarg);
+				goto done;
+			}
+
+			if (uuid_type && uuid_type != uuid.type) {
+				print("UUID types must be consistent");
+				goto done;
+			}
+
+			if (uuid.type == SDP_UUID16) {
+				if (uuid_bytes + 2 >= MAX_AD_UUID_BYTES) {
+					print("Too many UUIDs");
+					goto done;
+				}
+
+				put_le16(uuid.value.uuid16, uuids + uuid_bytes);
+				uuid_bytes += 2;
+			} else if (uuid.type == SDP_UUID128) {
+				if (uuid_bytes + 16 >= MAX_AD_UUID_BYTES) {
+					print("Too many UUIDs");
+					goto done;
+				}
+
+				bswap_128(uuid.value.uuid128.data,
+							uuids + uuid_bytes);
+				uuid_bytes += 16;
+			} else {
+				printf("Unsupported UUID type");
+				goto done;
+			}
+
+			if (!uuid_type)
+				uuid_type = uuid.type;
+
+			break;
+		case 'd':
+			if (adv_len) {
+				print("Only one adv-data option allowed");
+				goto done;
+			}
+
+			if (!parse_bytes(optarg, &adv_data, &adv_len))
+				goto done;
+			break;
+		case 's':
+			if (scan_rsp_len) {
+				print("Only one scan-rsp option allowed");
+				goto done;
+			}
+
+			if (!parse_bytes(optarg, &scan_rsp, &scan_rsp_len))
+				goto done;
+			break;
+		case 'h':
+			success = true;
+			/* fall through */
+		default:
+			add_ext_adv_data_usage();
+			optind = 0;
+			goto done;
+		}
+	}
+
+	argc -= optind;
+	argv += optind;
+	optind = 0;
+
+	if (argc != 1) {
+		add_ext_adv_data_usage();
+		goto done;
+	}
+
+	if (uuid_bytes)
+		uuid_bytes += 2;
+
+	instance = strtol(argv[0], NULL, 0);
+
+	index = mgmt_index;
+	if (index == MGMT_INDEX_NONE)
+		index = 0;
+
+	cp_len = sizeof(*cp) + uuid_bytes + adv_len + scan_rsp_len;
+	cp = malloc0(cp_len);
+	if (!cp)
+		goto done;
+
+	cp->instance = instance;
+	cp->adv_data_len = adv_len + uuid_bytes;
+	cp->scan_rsp_len = scan_rsp_len;
+
+	if (uuid_bytes) {
+		cp->data[0] = uuid_bytes - 1;
+		cp->data[1] = uuid_type == SDP_UUID16 ? 0x03 : 0x07;
+		memcpy(cp->data + 2, uuids, uuid_bytes - 2);
+	}
+
+	memcpy(cp->data + uuid_bytes, adv_data, adv_len);
+	memcpy(cp->data + uuid_bytes + adv_len, scan_rsp, scan_rsp_len);
+
+	if (!mgmt_send(mgmt, MGMT_OP_ADD_EXT_ADV_DATA, index, cp_len, cp,
+					add_ext_adv_data_rsp, NULL, NULL)) {
+		error("Unable to send \"Add Ext Advertising Data\" command");
+		goto done;
+	}
+
+	quit = false;
+
+done:
+	free(adv_data);
+	free(scan_rsp);
+	free(cp);
+
+	if (quit)
+		bt_shell_noninteractive_quit(success ?
+						EXIT_SUCCESS : EXIT_FAILURE);
+}
+
 static void appearance_rsp(uint8_t status, uint16_t len, const void *param,
 							void *user_data)
 {
@@ -5618,6 +5989,12 @@ static const struct bt_shell_menu main_menu = {
 		cmd_rm_adv,		"Remove advertising instance"	},
 	{ "clr-adv",		NULL,
 		cmd_clr_adv,		"Clear advertising instances"	},
+	{ "add-ext-adv-params",	"[options] <instance_id>",
+		cmd_add_ext_adv_params,
+				"Add extended advertising params"	},
+	{ "add-ext-adv-data",	"[options] <instance_id>",
+		cmd_add_ext_adv_data,
+				"Add extended advertising data"		},
 	{ "appearance",		"<appearance>",
 		cmd_appearance,		"Set appearance"		},
 	{ "phy",		"[LE1MTX] [LE1MRX] [LE2MTX] [LE2MRX] "
-- 
2.34.1

