Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011002.outbound.protection.outlook.com [52.101.65.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E757E212168
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866550; cv=fail; b=A6EHKYpn3U20xe2G96eZxW787rwLBXhfTf0RgS71QEio45bmHo0eoU5tY+4fkiTtXLYJrwRwXvofZft1R3sfgxsCv1SYri/UxUW31U76I4inAcQF123HLEHmlzwUumFq5j/HRCL9Z+5e1cREVRUganWq62r9tkXfcJKTKLRi8u0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866550; c=relaxed/simple;
	bh=uNGHJfk0Im/KlhpMqmyZU7fjythUo4s3DU7QpXMRvCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qvX/V9yv2Y4RmQOgadfLezvKduRrKhYaVOpa9gd/I6BLmN5AO8IIj9xYZ9mPwU8kfteZwFNZ9l6rLQBck1EGyQKiyrNzey+fioN/ZPMqCjPAb4j4dnN7A1jm1W+q4OGrm9yDXCtfYX1TY8uODa5C2AcZ6e12uEn9fnKKzZzCFw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PU8chZVG; arc=fail smtp.client-ip=52.101.65.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PU8chZVG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VjxlduNsfbfnZnVbSuKG4OoXRtOJfD1MjBF4iBszy2V/emdzOaeM/wH4Vu6hfrE0+0npE06vFcwyjIRVwSQ5eHHAHI+k6F8cC8wuW8MGgSNbrzxsewNME/w4g9rQWVwmLItRwag4W2kZTcLtXGwy9gKSHsiXtp4fYbSorciQoLMbQeRmgW1Ffj2UMW7B6/76Iw/AUB3h4qFYch6f5qXEdHB1pdaZuJhLT7YlWJ5wxwEQrrdnMrvuZEnhAL0VIlXIjpYrudJNcUq+JCXokTbPVfmHA1JzydgkFH7SOqljndOB1kToRDfc/EFMWFhlmy1DTHu1Y/V69ZqZpF6FJNIceQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIWdNEytyQiLaUQSFA54wTadMX2WebXCnbRloWdg6jY=;
 b=X0wdUGyHgUwQ/KmMN7+dXd9ci+BBbg/xJ2S2zKeNvKHqqS8QwvWerb/W1ez6Ev/TQY5emcjVZT9MqoduucVTl7iDzZjovWIr2RHsT/l3evqb8W40t47a9MHuZPr/yNd+IeVcrPVIyJ65clmXTlXQKsOo3o1c2/jZPcqGkFlvlIBXy3c6muOSHDmZn5NOStaZyxesj0BZbVN7S+Vo+3WjJcVMGJ8WjiGJWLWwzHtSmDnrz560/+MH5atlnNFZLD7MglkCE1SnbUNsMGJgN4hdZroZhAGrpM19VzJokhxlYwBeMqZyoi0x8Tw9FSpQ2DbwOU/1x88o8gqBAMArPvXWqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIWdNEytyQiLaUQSFA54wTadMX2WebXCnbRloWdg6jY=;
 b=PU8chZVGW1vlDcsGkagNf72ir51Rfv2X9kpzBouw1jGH20PhGmVcLPy10QIv/cswfbL/HS4moTwn3b8DzE6XsEjYVbi9t1R0s9B4VuYpJuVZrkhM8hFER99YVVpKi1twKNxitznAESAs83H+tuCm3JrwUT8JpKPd8fZ/KzzVcnsmzDLTiXrDj3/TKdacSsi+JHuGTHr5zrBi7hy0XtE5fE7wD7OxNncpObsJsruzHoDUgTGMIBqeUE6Xc13trm5IhE1i1LomFICZ030o23KQumxm1P5bPPGNgtXwwDqNSc8sK+apEcCdG5NiQJkZxaM+kxTmCmHFg4Ypgptm/BIbNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBAPR04MB7254.eurprd04.prod.outlook.com (2603:10a6:10:1a4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 14:29:05 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 14:29:05 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/2] transport: Send reply to select/unselect
Date: Fri, 25 Oct 2024 17:28:41 +0300
Message-ID: <20241025142842.46566-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241025142842.46566-1-iulia.tanasescu@nxp.com>
References: <20241025142842.46566-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P191CA0020.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::25) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBAPR04MB7254:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd225ab-9aa4-4c1e-3a0c-08dcf50160f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fjreo8MXQR4btC+2McnrlyJO872IhjWH5EDl0wOdLDBqIP2Rgn2XcD/3C/VD?=
 =?us-ascii?Q?9KVWjPbYBZLswxrwv3O8OzMiWrWyFTVMxEkuCv7YbfUK48fqBENYycspumPn?=
 =?us-ascii?Q?2XSEaTGhe7adJ9Z8/MseZjgwOHf8dHb76DLQrpHqg2Qwu0VJS33C+jgRuEeV?=
 =?us-ascii?Q?edhbruFfFJjtcmRGeXhaldtd8O/JXiZwLfaf0hC6Lk6bpSEUC26RrfhPiCzL?=
 =?us-ascii?Q?JJXDaMT8gRMNLRsb63mr4zTF1KqbD3TBHjiISSDcN1AY+ogyQ5dz921+sSyf?=
 =?us-ascii?Q?KBwd4CbZST1OdIgmoUG6KWLr51G37wvVza/NflIdP8gJtIrxQB+HXOPmNoGQ?=
 =?us-ascii?Q?4KsGr/OLtIc0rKDkHXiAlm3KmySewGD7yUM9IIoPNki4ev7AtaYRsZUzSc19?=
 =?us-ascii?Q?cg6QSLdnrN7XVzriDHqRCMlUZFfcd8RkyG/Sb7I/MC88CkDohB8zl0smkI+I?=
 =?us-ascii?Q?uau5ZT/3cjPTKVu2VhAfFP0IQMV+/ZFD9YVw4+kZZ1WxYwz0Y1AuMo+0V4xF?=
 =?us-ascii?Q?2Z37HyUMa8bPU9zao6NmWpQLw7YHve97yzHOjz7/w8PR8rUJrzFgj6PVmV9t?=
 =?us-ascii?Q?Tv32szbR7rvG9u5O2YFmOuEBMP/GPAUDyN2bn7CXJcT/JoRgoLBAxDSo2n5t?=
 =?us-ascii?Q?b1GJ/g3QutqHmYsh6t4p5luX/uzwQuX1CrnJjO+ZhDm++ZnAe3nclACABjjT?=
 =?us-ascii?Q?/maqixmxdmcu6GuTFDW4r24MBO/89nWQ+Fwb0j+U9Gz3+PznpYeGI5/6qlx7?=
 =?us-ascii?Q?XHDMv8BqsOjRQlDwODrQ84a0TbWYFEwwujCM4jscbDwwD1TK/mgShuUbHGG2?=
 =?us-ascii?Q?/Se6yTIOrSs9XnTEYGwnJFAdg6LnnzVOkKwCKpH3SOpg5e6zZ9GW+GhoI/Gd?=
 =?us-ascii?Q?ZXH1CCSdaKywgqTuxn9E1/r5oWV7pf6WAr9o38oGjgUDpIOLBstbi3nDpePm?=
 =?us-ascii?Q?TB7NZ7wfxEIuCpqK+4YUYuZmnAC86vECy5U+SQFxcLBa/P16TfNHXnqW+8tO?=
 =?us-ascii?Q?eKjbNbKLJoVBdvzCNseUKVTntYAhmpz+az7AkcYe59JG763OQu4bm7N15rfg?=
 =?us-ascii?Q?3yvqoPrkENVNKVsPI3MpbN4nsqSj5qm/+InvpIdlUSBjoU1mpaF8KtfUeJBJ?=
 =?us-ascii?Q?1nPHI8fd01z4ctIQpbmLk7peXRml+X8+0vs52azxdeUCeLvoc+04ubXgsYz3?=
 =?us-ascii?Q?cIz7e6krrLsVP0kX9iW3wuXfm24HY8saQ+a1RDzPXylQcwAwGspk4lS0QlP5?=
 =?us-ascii?Q?xjdcI3h6AyiIOYebZg/O0WlhS+PwdD0j+yi2DmTyTTKt/tw7fQTPH66zbfLd?=
 =?us-ascii?Q?JrbU5vrRIKGK3E9baX+I/s9JG2ujY0PwZ6kJDtDmzoRL8luZgiejktFGPm4A?=
 =?us-ascii?Q?4IcQO1Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KCkFUTiH2hBmzOFnRQbZJx3T0QFzZSXp3F878n7/4/Xef8FcBz5vKXe6LxVW?=
 =?us-ascii?Q?LVSWBJcoJP46mw73mvBKi8Fipmpj2pgoL7qAbcXm7fMVamDm9eabNC9JswPM?=
 =?us-ascii?Q?XEiVercfRHZqS/nOiq6Kj8uCP2RHPSBQ+/Vxqp0a2xgMoKJM1syBTiBoESgJ?=
 =?us-ascii?Q?14CeoZ69YlCB58sDJcPEjgZq/4/m2kIhDxrEOxu3G5tZmlASRVHV6xmeQb/Q?=
 =?us-ascii?Q?6FQps6VRPJYLeRzlOrGhsZOssemBj2+9EwKV+lwlxc3EsvSG38G+4sPU8OAq?=
 =?us-ascii?Q?6kzm2E/AVdsHnoD6Sh4KfJpBsEio1OJitNvo0hq8GNU4NRpqtAybppC+URQj?=
 =?us-ascii?Q?f2AHjOUXTG81eQWyeoIhSiro/Yv2zl7xxwsfM2w6hRGQ+dlF5kWvc4NoblN6?=
 =?us-ascii?Q?5wEcb0M23vldIFSPzrMMJLrKTUJ3FoQPIPF9ZjEthkqTLzSF8FcV0v/z1GO0?=
 =?us-ascii?Q?JD9q9C8zRmnDk2mlL3Z4Cq2nBX1xLEysI56iUZY9tYFO3Lv914SENmO6A1ok?=
 =?us-ascii?Q?DQHi+bm7iE3+8RaHcN4j3DUN52EfAwMIWuGYm0IpX9vceO1quiQgLGVvRL4L?=
 =?us-ascii?Q?GQ3idUUI9c4gdKfF0ikHGa/R1CLsEmlXGkyHLAUx2OOImmEx8IdH7qUTgWi6?=
 =?us-ascii?Q?nSBskd8Dxtl44W4wbueQln5iB0LWbMR5TgkQjcYTFztHadmTwO08x62L0MQM?=
 =?us-ascii?Q?Mm/r6QkaHKWgD6PgLv0Z7dFufgthMVNXoEUEISSAsxiKAgTD+Zp80PjVr4xJ?=
 =?us-ascii?Q?CcofjYejUBvT0NMxzUV38+bBq3LRaDwbpXp/CrrmHzkfLx/YNT0fbMUL2MEv?=
 =?us-ascii?Q?mwHi8zPmfbIf18CjNpK7FyMroFVSMRfgKAxVrhhKOvQFn0Ltr1ifAfe88Dl2?=
 =?us-ascii?Q?23b3Z1OC17Awmoo+Uj+kMpo2BC7nz9aLHftE2r85rHY6eJUvBNU2hSEWvYH+?=
 =?us-ascii?Q?UB4nLyUbtRZt0DwV65Ulmi/2JOhYGUvFpA1L7Oc2ZFv5AXY/aPFG0CHtY7Xj?=
 =?us-ascii?Q?dQF5SiXTFIGhp5mXvm/3Rg9zJBM5QFt3BSBE4ZY/VryUmZC4Dd4CDQzod2np?=
 =?us-ascii?Q?p6MsNhbFZ/jWFrIz2ep7LzGtiZWZcbRktpCWDDrU3vfj703rEUDKCuE5iiov?=
 =?us-ascii?Q?pokaP+jrApyDmNUj0YqFYBpeDNQi0yNDFIHVRgblu6zC84mD0fH1SF8MzNYe?=
 =?us-ascii?Q?e7yVSWZ2Yo5xRYQU7pz72KDAr1TydfnXYqkRQORrEmgfuUq3OmizzE8AgfTM?=
 =?us-ascii?Q?oRPwumZQ2kIh3ZSETPDFHFQSwwxySrliwJTm4ZVUkBDZgUioQVdTceiGpSOz?=
 =?us-ascii?Q?ZG5pqzBp75cVDT0XQYCA/47UdwMABoub8jCg/cHjhJoK+OKoPxTXWizM10In?=
 =?us-ascii?Q?Ng+1XZesoTnytIFSWKr1aVHgfjbKyHZCSfsM9pTUDO95X2iI/SQjK0WE8rbV?=
 =?us-ascii?Q?EUpvKPx0MHKSdq1YoOjTzZjxDU44wie00tmggcve58KNLhf+NnU9q/cbroUv?=
 =?us-ascii?Q?2P8F0pHc6r251Pl9JS9M28SeHqQm2RyiiZVrAObnnwebChWs5Ib1XmBH2Z/Q?=
 =?us-ascii?Q?wlDbULe3qMR37dCm0r/1UqfI3sm1WY4HWhkeAfFsj/SFdoe0lIAuOtUNHcub?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd225ab-9aa4-4c1e-3a0c-08dcf50160f4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 14:29:05.2223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AkhkmIuHdsmsGKkHybDYlX/cXS+RIetoDBn0UGP5PjX8C1YmSwFkaqZY/lxLWXIW3fzYCl0Gm+Nt/OaKx56HXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7254

When a transport is selected from bluetoothctl, a reply is expected.
Currently, if the method call is successful, no reply is sent, causing
the following error message in bluetoothctl:

transport.Failed to select: org.freedesktop.DBus.Error.NoReply

The same error can be reproduced for the unselect method.

This commit updates the select and unselect methods to send reply
messages.
---
 profiles/audio/transport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 68192bae6..bc63772a6 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1423,7 +1423,7 @@ static DBusMessage *select_transport(DBusConnection *conn, DBusMessage *msg,
 		transport_update_playing(transport, TRUE);
 	}
 
-	return NULL;
+	return dbus_message_new_method_return(msg);
 }
 
 static DBusMessage *unselect_transport(DBusConnection *conn, DBusMessage *msg,
@@ -1436,7 +1436,7 @@ static DBusMessage *unselect_transport(DBusConnection *conn, DBusMessage *msg,
 		transport_update_playing(transport, FALSE);
 	}
 
-	return NULL;
+	return dbus_message_new_method_return(msg);
 }
 
 static void sink_state_changed(struct btd_service *service,
-- 
2.43.0

