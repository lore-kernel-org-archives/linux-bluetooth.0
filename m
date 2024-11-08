Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2083.outbound.protection.outlook.com [40.107.241.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31092139D0B
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Nov 2024 16:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731082061; cv=fail; b=YdOq0dBb7Xjth+oXUCqdRl56MmtKv/oSoAjsnBM+DOTiAysvgpKEDPdI4KLeiuKAs565tqImbzwP/HVQcmj9sUV50oi7XyEdNm+23w7QVlAhOackeVvOfQ6MfoPoQrEn25wF/XAcDsVs1KqRbMONAt9S1owtU+CKTFQ2BRnCSfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731082061; c=relaxed/simple;
	bh=cUyZWJN4X/RJSVfw1qYZWBU/iQbW1+ZqKx8J9MdzERo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ovIjryqC/qwBx8DY5X3zhTorGnvtJLGq7TYD0N5Na/iEDqA/5Kdu6qTd6KRzcyLRD5DRaGr9SxjDlhChb1tLKSfoZAT9V63ppR1qwoHl+IAUxVOZWe+IQXJVs7oM0s6GvhEaSFt1lS46tStR6cQkRL6U+txW72SaMAZe9Bz8qz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q9ZmfTFv; arc=fail smtp.client-ip=40.107.241.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q9ZmfTFv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XM38v7APt+lqeGyZsAN/hRzornNSXRt69YY3boJFYy8fNrxYiSPBzAsYLyYte4pYcgJNFOflZAGqmyahIkypSPw6qKXbc2aHuc5yoqyP+0bMARDbrIKL/1UWq/1Pui3B3ZNprpwnTGNm/S9zPmSf/cifn+Lnk7AuV+NrVSN5/7SvfH5HbqiDbcJoAkYMnr9bWoKgn/QfDr02zOA3OkW+95GuJvoFlZyB+GLTmufbdt/nl9JZvOQ2Jlc8sJvJk1LX9N6077xA3E1F9bRRxTrt61DnW9cae3G1iKzkHpR5tokSR+8wwHhp1fe+oIjjrMMaKu54qn0gkV2G5l+AL4/EhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ffrsM3VWLv5zJis/UXp1KKN3h6RPRl+BOVjhcltSwM=;
 b=SS/AQU7hBrWbT9rfCvkOBZu/SNocINu6Q6iSji20RjQcf/OehAvTd6oONDwWVhiT5XdUFNJLwEaSUWrthNQFIizDJcwh1LnTQgaP/niYi3xOyTX1ZRaIJYmXkWOmk50bh6Vbu5iFzH7jaIAng+/p+zmAAZDdg1WYOvmKjEDMP5X1J+pin6sIUSrJSxiE13uf5fpwh08d7cWaBYLm4MrCtiqeABE+igtw9XGTDq8DWNBmp75rUaqTvWrmvSRUdoEiH8XQ4t1GsZp4dsXc8pAYT64L+W4FtRML8preyNObQFFHz2kPKV9VXkuKQyHfgjOX/0Z6MeD6epmKEeIOEAkj9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ffrsM3VWLv5zJis/UXp1KKN3h6RPRl+BOVjhcltSwM=;
 b=Q9ZmfTFvC+MGHAtoZZbSHJ8jjJgKM47+77RDYCjeZfpVmYpp6uURPukjQhkZE/yGFqNFk52ENseKHx8x6SD6gqeJptHeGL6n/rJzAtGZdydarO1c+v/XLRsju/kmUk3hMD5nKRHEC49/Fb+eGeTTK0UlvZom9zQr29ptqKbwLI1vm/7paOjtSLaO+G/OKY1LdrqAkDbkD9kvpi9WiFx1zdBmdUCUX16daf7RIbW/XdAXeGhbTTVvs+jPernH6Has3nGHLc4sRA4SqlDAkw+l2EZZ5KmMOIa78R0piAQnQCMTWoVzynJanl9gDoY39F6BrVnLQFIc5VKrn5ksTzgtkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI1PR04MB6829.eurprd04.prod.outlook.com (2603:10a6:803:13b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 16:07:36 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 16:07:36 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 2/2] Bluetooth: ISO: Send BIG Create Sync via hci_sync
Date: Fri,  8 Nov 2024 18:07:22 +0200
Message-ID: <20241108160723.3399-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241108160723.3399-1-iulia.tanasescu@nxp.com>
References: <20241108160723.3399-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR03CA0045.eurprd03.prod.outlook.com
 (2603:10a6:803:50::16) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VI1PR04MB6829:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fff5602-0d37-41ee-7a9d-08dd000f7648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h3zxSA1Aa5J/wIZ24hk3CDfIsjPKKmOzKN3IammnQozLAEXPd3YIl7TfOuVI?=
 =?us-ascii?Q?XZ+GYna+e93XyY7vS+Fn8DkPqebjW055XcOQwtGuB/CHbsdVQqSNRfk/h9PP?=
 =?us-ascii?Q?dgWHd9Z7r8JSHf3ySOuYKR8bSXPsojHSSi7mcAFoPua2r8ESAgRKw/jIfmBd?=
 =?us-ascii?Q?2AbrQ49X1TOm7wRkK7H9X1a7VwfeIjMA06y9ASfyE1V/ItepzPjwqhqZbXvY?=
 =?us-ascii?Q?4ra7IcZ7AhLTup06+weuF4NhurQJ6dJDgG3PQiEf+f+lr+rMrCCjmnFE9QHg?=
 =?us-ascii?Q?VBdtZZfXXcQFttWO4YYDfzv1xIrLY/D6RRZzYjxGTIdrTfH3Ivm8zmrnbcAz?=
 =?us-ascii?Q?4Mhmq3AroVxY/XnNFduuSpvjt+0Qg0JNsiU4cPA304hx4koQ0lNGHcR622Ek?=
 =?us-ascii?Q?7HNJdCs8ygcXsZ1mSQ9VHZlpKpiCCqEZiR7H5CVLuQtLpg8uR4btxq0O1pNv?=
 =?us-ascii?Q?eyHYPOQq2CW+k4tWkv4sK5pmb8cB++DREvbHtrax5teMWv9gHaVS2XCiX6sO?=
 =?us-ascii?Q?Gc8iw6SWh2F3nV5a7asH9eHWZ+nfQ9i7tFSlqV0spgQHEfmU6xOScEc61EHW?=
 =?us-ascii?Q?NWOsHMV/bZc9F7zb6Zbk5sdRytVpbe/3h8bxFH3OQlcURXmDOa9xE7rskR53?=
 =?us-ascii?Q?m7J5QEfDXixUqTt8QUKg6fJq3F2L4l8o2cBNmvQUqlhw/lKWhlsLftHjTeqb?=
 =?us-ascii?Q?s/MaqMjL6D1eC2A8sP8N8IyIp99MDaZ+ZDfwl4uoetzhucFEXdu38rl1YJLV?=
 =?us-ascii?Q?RD5bzt6AUG5LljOg1zZix/2jlmld7bZMT3x/PcaOwfbW8hHvGyBFTRUYs9OK?=
 =?us-ascii?Q?7bj5fyoJw4OI1412k0GxCoLaHjnINX1W9kS0YG8W7HJFve3Mjh3aGcir83HH?=
 =?us-ascii?Q?WgOE9JmvsxZJWZAWrUYWPDR5M2ggQYM1hPnniPNlcyRoJcNXg1BXjAUDQ602?=
 =?us-ascii?Q?LJ/1MUy/CDbkf+6LvIRdRdPhGt9jEFM+oVXTDLt4XyGucl+VhhEmJ6MtAOP2?=
 =?us-ascii?Q?8uKtMuuO/AIG6zlYAgmX1NurGzCPe2+zQsntnL+Mk4mNzYucfMlAFgffwQ8l?=
 =?us-ascii?Q?Ee4oFtgYuysV2kN1MPJm9OEr7f6W4bVvP4U3Yoh8ZXnJKKViYPqbhawma8Yo?=
 =?us-ascii?Q?CXNBR+Y/JK8PvOqV7YvtxppPw+2z48aIOSnHCv1Uhzezkb7u6z3HcNHeZ3QM?=
 =?us-ascii?Q?J2MI2n3YMhTZS79AOkXZ39varp5sqb8OF805Q1BbLEqqNpFSwvxhl4FrpMsm?=
 =?us-ascii?Q?lpceSkleDZ6860+wSwcPq4KhUPvIt37QeUnQVPphvX59zSnWUVsk6gH2+FFN?=
 =?us-ascii?Q?9wc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UQf/dGvgsz1xtb51QHYidiQqfDnLVLfErnV6RvufWd70i59onVHrwipm0392?=
 =?us-ascii?Q?GC6cK9Kw94nb1MtEIO5vAohVD0SFHszg8u4ccP1kFjz42xjbF1Yf/E8kp+Sq?=
 =?us-ascii?Q?Jt3VW4pcP8I87WPUvGtNWI53rbvIYLLEJcId5TY3AIRdSzUpC6um/1LIZSg1?=
 =?us-ascii?Q?qeLfKC6mGHdrlumlALzk3f2STMbWxiAWbO0OyzVnqkqqVSBCRS1j6vBau5J/?=
 =?us-ascii?Q?ECvxHnIaB31eM5aD5/Cn9ioBvfQpVNmBPDRgljmy/b0ocUHJNoOqSTG2JXEK?=
 =?us-ascii?Q?TUTFj0OIefZACPrzl15h/29fBY0qy+frNBx3Ty8pQubKC6XTZ0Y/9Wv7+6xF?=
 =?us-ascii?Q?WJT5orDAg/4hhGYyntjeivyF6aDWE/7f5fT9jSMdVnxT437haliXPmL2MSmS?=
 =?us-ascii?Q?1BqA26iNV70PhOvHnZhXxprnrl8w5rek88YVSmcd+P0nK3FkIn3vfw1ViWEs?=
 =?us-ascii?Q?bYbCoRYBFLlPx5VpC+UovOAyWa30yCZD65Eh78EoaqSMKrG5+7b2I92djLqM?=
 =?us-ascii?Q?m3KayWPEhkS+JIAtiTA7qYGUcuUBFxysTXXvSqDRkXBZVgFcrwsW5xSpKiVO?=
 =?us-ascii?Q?E1RVMMzsYQbHP/FPZvOIDgklUt+/P9z0QCNYxRVSiVZN8WLfiv9QSQ4bcwsD?=
 =?us-ascii?Q?r7nAJ5nQaSm4dLFVsuuHsdjoBeYj1wo4Y5ETEXTrxepftIHbSyjVxAOEvAa3?=
 =?us-ascii?Q?t89Iv8WgE90nVxen6DabTmO9FCMTYszsIU0nu80zxITHl6SL8aq26+jHZ83W?=
 =?us-ascii?Q?FpsupthWNm/JHevleBeWHnaeF3TEitUlG8Wabhg90hK/x+WZbvWTTDbD3hR5?=
 =?us-ascii?Q?O7g173SF0QJflYqQmIMRy2EJo5BQvg7zpJA2bAO5hdwnlQzfpwaNkXDKCufd?=
 =?us-ascii?Q?pVPU0F7qcFMvutEmWsHksW/7yt4KsY5DvdOD8r0VP1SJWD/I+c9nck2dPRi3?=
 =?us-ascii?Q?0lqqvH6d0p1MYb2wjXxhnpCoRkR7mkzfL/TpKvBH7kSooJICWiBHK95JW1CM?=
 =?us-ascii?Q?RKKX7Hlj1d6CltAoMPSVB8FDouXRZBa+5F9aaTU0cCv5W3q5mWoInZGscrM4?=
 =?us-ascii?Q?p2wZ9PEzR1765/iqBfhvhqXV3eiFkdsaEWWo6iPf2FP1LUvDv8gdJgy65LJ7?=
 =?us-ascii?Q?VNAVkuk0xSAoHKzc+BZc65uRxF1g2u8knD+EYnt55IQJJdF7bzTJ1Z7zJ/V7?=
 =?us-ascii?Q?zoiYr4z/YWTTSMtxWcC4HgiGKvzQ6Rcw2j0s6hRHD5XW1IqG2v9jroBopXk9?=
 =?us-ascii?Q?7+44BsvkZ2PBRrFlmiXC7vAqi0uxHHw57MVL+OGjDJxDACdIeIUw/lz78j/C?=
 =?us-ascii?Q?bW3gZEW3Gw8CGyEFfGOxZnFiLPdsX44dlLrxeBNR4hIHjsUGDjxwAipVbsii?=
 =?us-ascii?Q?DPpobR/mi/X+auxoNpgYMnCFInHe5LCRZ8TM2lbjRbEQG0njI3jn1zX9f4Bk?=
 =?us-ascii?Q?ODWxdIn4p2sTQjgiNEQ9iSahvSZwKYHlyVLmBsOgZbnEsUz2k+rli4UR2ibb?=
 =?us-ascii?Q?u3RdPOc3tpW78mj6+Ytk+thOxF8k6T6NfzkiCfOhxelXVHthObOVJmjgFEG0?=
 =?us-ascii?Q?0qm9asPLv9KiSGx64BGok+SNJ+0pV+gnd1DPwetMMtvaavNGgaug08znw1SN?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fff5602-0d37-41ee-7a9d-08dd000f7648
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 16:07:36.6775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WOZhUwXQBiOe6r0Yn7ajPCemrLCpy3IFSnHyOjRb47r/RxmzV/yVWzC7IHYYZ4An4P/Xn2A5Kbq/on1ioWfOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6829

Before issuing the LE BIG Create Sync command, an available BIG handle
is chosen by iterating through the conn_hash list and finding the first
unused value.

If a BIG is terminated, the associated hcons are removed from the list
and the LE BIG Terminate Sync command is sent via hci_sync queue.
However, a new LE BIG Create sync command might be issued via
hci_send_cmd, before the previous BIG sync was terminated. This
can cause the same BIG handle to be reused and the LE BIG Create Sync
to fail with Command Disallowed.

< HCI Command: LE Broadcast Isochronous Group Create Sync (0x08|0x006b)
        BIG Handle: 0x00
        BIG Sync Handle: 0x0002
        Encryption: Unencrypted (0x00)
        Broadcast Code[16]: 00000000000000000000000000000000
        Maximum Number Subevents: 0x00
        Timeout: 20000 ms (0x07d0)
        Number of BIS: 1
        BIS ID: 0x01
> HCI Event: Command Status (0x0f) plen 4
      LE Broadcast Isochronous Group Create Sync (0x08|0x006b) ncmd 1
        Status: Command Disallowed (0x0c)
< HCI Command: LE Broadcast Isochronous Group Terminate Sync (0x08|0x006c)
        BIG Handle: 0x00

This commit fixes the ordering of the LE BIG Create Sync/LE BIG Terminate
Sync commands, to make sure that either the previous BIG sync is
terminated before reusing the handle, or that a new handle is chosen
for a new sync.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 net/bluetooth/hci_conn.c | 19 ++++++++++++++++++-
 net/bluetooth/iso.c      |  4 ++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b5b78d469d54..ba74fac823c5 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2180,11 +2180,20 @@ static bool hci_conn_check_create_big_sync(struct hci_conn *conn)
 	return true;
 }
 
-int hci_le_big_create_sync_pending(struct hci_dev *hdev)
+static void big_create_sync_complete(struct hci_dev *hdev, void *data, int err)
+{
+	bt_dev_dbg(hdev, "");
+
+	if (err)
+		bt_dev_err(hdev, "Unable to create BIG sync: %d", err);
+}
+
+static int big_create_sync(struct hci_dev *hdev, void *data)
 {
 	DEFINE_FLEX(struct hci_cp_le_big_create_sync, pdu, bis, num_bis, 0x11);
 	struct hci_conn *conn;
 
+	hci_dev_lock(hdev);
 	rcu_read_lock();
 
 	pdu->num_bis = 0;
@@ -2229,6 +2238,7 @@ int hci_le_big_create_sync_pending(struct hci_dev *hdev)
 
 unlock:
 	rcu_read_unlock();
+	hci_dev_unlock(hdev);
 
 	if (!pdu->num_bis)
 		return 0;
@@ -2237,6 +2247,13 @@ int hci_le_big_create_sync_pending(struct hci_dev *hdev)
 			    struct_size(pdu, bis, pdu->num_bis), pdu);
 }
 
+int hci_le_big_create_sync_pending(struct hci_dev *hdev)
+{
+	/* Queue big_create_sync */
+	return hci_cmd_sync_queue(hdev, big_create_sync,
+				  NULL, big_create_sync_complete);
+}
+
 int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
 			   struct bt_iso_qos *qos,
 			   __u16 sync_handle, __u8 num_bis, __u8 bis[])
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 9e119da43147..ac1598b1e1b6 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1338,6 +1338,8 @@ static void iso_conn_big_sync(struct sock *sk)
 	if (!hdev)
 		return;
 
+	hci_dev_lock(hdev);
+
 	if (!test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
 		err = hci_le_big_create_sync(hdev, iso_pi(sk)->conn->hcon,
 					     &iso_pi(sk)->qos,
@@ -1348,6 +1350,8 @@ static void iso_conn_big_sync(struct sock *sk)
 			bt_dev_err(hdev, "hci_le_big_create_sync: %d",
 				   err);
 	}
+
+	hci_dev_unlock(hdev);
 }
 
 static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
-- 
2.43.0

