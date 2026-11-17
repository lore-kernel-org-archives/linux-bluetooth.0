Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794913608;
	b=nKXGQW/abMV6wKhpMsIIq5YngivMVQRHcZ1t8l1vZV90+Hp/6ke48dnuFjYJemi9+T2R
	 xDgFv+stOL29dean1NFMySFtB/g3ormGi832xWPTZC4/NyGxKMKJKsJnwnyiBn2P/cvbV
	 Fg3m+vvLBjnh9NKStzg8a7R+iO4l4VD+7iAEW/K9ZY16ZrGiNMnACNcqkb2Rk4QxKT8Zf
	 KZzeRfgkivH4gbft9+kilt2T3uaMfk+WQGFk2c57wu8TtmL1eh834+9AfrryGhtNbh3o3
	 EAJA/SocNHsVPrLSD+bfL9O/Ek8N9OTxI/E8XbUD8C6VKcAErA2nI8BGIgsuBDTCM1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794913608;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ZohoMailClient;
	bh=CsI9g7i7VP4IDWYrq0pqU/ZqtTY3zp1I9TrjX5+rTt0=;
	b=FQlBEElFcvqPIhOQNfo+CtVkgLDAHqgNPXW6mKvjcbNz3MkNSUQOv66toOrPUH6U4EjZ
	 ENBAWq+NgxZa1UkS+RiAHzE8v10N/c9YZch1kfmh6McYL0BgW/OBhJWhr/3vwhfhOTsCo
	 Taz7CimGTSQasQsNpsahq70ZbNUrABYeEzMR/+M0DrR5zVLuzou7GwyacE2f8ST9GJOjv
	 0Y73Ox+rE3E9RgyzQpMqpIm4OdyhxvU1ROy9YEKWuW/oUGRqQVMQONUo4tSGGHFbvksFH
	 kWBbdbQUZDLHO2fDwM51CygUCeBhZtQioi8UtztCgFN3PocYyurkuOO4ipngl1xDpuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=dcbBuoEo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AAA606A31C
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 11:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03AAA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=dcbBuoEo
ARC-Seal: i=1; a=rsa-sha256; t=1794913603; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Dd+fCH7/GDwvZx89hE3L27r8S8SvW10XDA9ixGGgUvbRzzdCK6+Aa26hOnT11CgJ4b+3Q7BmaB4L9OdCh2AGUN2Cc+lULDoiZQVjr0zze7hRIrJf43FWAtGD17KF/gP2dHmuCHjq4aKjrFG/gO4vj5MbN5S0ik5/0JMtPi9C72M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794913603; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CsI9g7i7VP4IDWYrq0pqU/ZqtTY3zp1I9TrjX5+rTt0=; 
	b=Ip5zDZD54ShcES6QQmJOD21vr6RnlzBereWF3WpRZuzm8SNMbGMXPb9Qcq9lJUhi3R0lmPT4toV10q0goqyJvZiCHEfcBi7XdA0zTfBNzVFyYGfa5Ozj9lH/26rJlcVB1LCDIqOzWGna39qoP6+CKqv2tA+kBHeBJtrx69kpclI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=frederic.danis@collabora.com;
	dmarc=pass header.from=<frederic.danis@collabora.com>
DKIM-Signature: a=rsa-sha256; b=dcbBuoEoWFcgk6OwSctzvCxMqKmiy1EhLQHMxoS1kbj+3UM1yQLiZDW0ZYaA0ubxI5Bsd/mlYYWjrCM1Z0x7VrPGBK8sPvnDFm6h1LqdZovj4pCm6/DL80k3wjyY9o6Lp8y9BEAMQH+Mh66+1bSYNnWhYhVQ8LGIEKUAhEpsr88=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=CsI9g7i7VP4IDWYrq0pqU/ZqtTY3zp1I9TrjX5+rTt0=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794913600835830.1244184640149;
	Tue, 17 Nov 2026 03:06:40 -0800 (PST)
Message-ID: <eb9bb2b2-b806-4650-970e-84b182966448@collabora.com>
Date: Tue, 17 Nov 2026 12:06:36 +0100
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/14] doc/qualification: Add RAP/RAS PTS qualification
 results
To: Cheng Jiang <cheng.jiang@oss.qualcomm.com>,
 linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
 xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com
References: <20261009092532.3600749-1-cheng.jiang@oss.qualcomm.com>
 <20261009092532.3600749-15-cheng.jiang@oss.qualcomm.com>
Content-Language: en-US
From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
In-Reply-To: <20261009092532.3600749-15-cheng.jiang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Cheng Jiang,

On 09/10/2026 11:25, Cheng Jiang wrote:
> Record the PTS results for the Ranging Profile and the Ranging Service.
> Both are split per case prefix, as the other qualification documents are:
> rap-pts.rst keeps the 19 RAP Requester and Responder cases, and the new
> ras-pts.rst carries the 31 RAS Server cases.
>
> Every case is listed on its own row rather than collapsed into a range, so
> the file states which cases were actually run. RAS/SR/SPE/BI-02-C is
> listed as not applicable: RAS.TS Table 5.1 selects it only when Abort
> Operation is unsupported (NOT RAS 3/4), and the IUT supports it, so
> RAS/SR/RCP/BV-03-C and RAS/SR/SPE/BI-05-C cover that path instead.
>
> ras-pts.rst also records which transport the server must pick when a
> client enables both notifications and indications, since the rule differs
> per characteristic and each variant has its own case.
>
> Assisted-by: Claude:claude-opus-4.8
> ---
>   doc/qualification/rap-pts.rst | 180 ++++++++++++++++++++++++++++++++++
>   doc/qualification/ras-pts.rst | 135 +++++++++++++++++++++++++
>   2 files changed, 315 insertions(+)
>   create mode 100644 doc/qualification/rap-pts.rst
>   create mode 100644 doc/qualification/ras-pts.rst
>
> diff --git a/doc/qualification/rap-pts.rst b/doc/qualification/rap-pts.rst
> new file mode 100644
> index 000000000..a2647f701
> --- /dev/null
> +++ b/doc/qualification/rap-pts.rst
> @@ -0,0 +1,180 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +.. Copyright © 2026 Qualcomm Technologies, Inc.
> +
> +================
> +RAP test results
> +================
> +
> +:PTS version: 8.14.0.4
> +:BlueZ: 5.87 with Channel Sounding support
> +
> +RAS Server test results are in ``ras-pts.rst``.
> +
> +Setup
> +=====
> +
> +- Enable ``Experimental = true`` in ``/etc/bluetooth/main.conf``.
> +- Use a ``NoInputNoOutput`` bluetoothctl agent and make it the default agent.
> +- Before cases that establish a new encrypted link, delete the DUT bond and the
> +  corresponding PTS LTK/bond. Removing only one side causes authentication
> +  failure.
> +- Do not use the bluetoothctl ``gatt`` menu to write RAS CCCDs. Use the
> +  ``cs ranging-data-mode`` command so RAP owns subscription lifetime.
> +
> +Requester results
> +=================
> +
> ++----------------------------+----------+--------------------------------------------------------------------------+
> +| Test name                  | Result   | Notes                                                                    |
> ++============================+==========+==========================================================================+
> +| RAP/REQ/RRD/BV-01-C        | PASS     | Configure the requested Real-time notification or indication transport.  |
> ++----------------------------+----------+--------------------------------------------------------------------------+
> +| RAP/REQ/RRD/BI-01-C        | PASS     | The Requester disables the Real-time CCCD after 5 seconds without a      |
> +|                            |          | first segment.                                                           |
> ++----------------------------+----------+--------------------------------------------------------------------------+
> +| RAP/REQ/RRD/BI-02-C        | PASS     | The Requester disables the Real-time CCCD after 1 second without a       |
> +|                            |          | continuation segment.                                                    |
> ++----------------------------+----------+--------------------------------------------------------------------------+
> +| RAP/REQ/CGGIT/SER/BV-01-C  | PASS     | Discover the remote primary Ranging Service.                             |
> ++----------------------------+----------+--------------------------------------------------------------------------+
> +| RAP/REQ/CGGIT/CHA/BV-01-C  | PASS     | Discover the RAS Features characteristic.                                |
> ++----------------------------+----------+--------------------------------------------------------------------------+
> +| RAP/REQ/CGGIT/CHA/BV-02-C  | PASS     | Discover the Real-time Ranging Data characteristic.                      |
> ++----------------------------+----------+--------------------------------------------------------------------------+
> +| RAP/REQ/CGGIT/CHA/BV-03-C  | PASS     | Discover the On-demand Ranging Data characteristic.                      |
> ++----------------------------+----------+--------------------------------------------------------------------------+
> +| RAP/REQ/CGGIT/CHA/BV-04-C  | PASS     | Discover the RAS Control Point characteristic.                           |
> ++----------------------------+----------+--------------------------------------------------------------------------+
> +| RAP/REQ/CGGIT/CHA/BV-05-C  | PASS     | Discover the Ranging Data Ready characteristic.                          |
> ++----------------------------+----------+--------------------------------------------------------------------------+
> +| RAP/REQ/CGGIT/CHA/BV-06-C  | PASS     | Discover the Ranging Data Overwritten characteristic.                    |
> ++----------------------------+----------+--------------------------------------------------------------------------+
> +| RAP/REQ/ORD/BV-01-C        | PASS     | See the On-demand ranging data procedures below.                         |
> ++----------------------------+----------+--------------------------------------------------------------------------+
> +| RAP/REQ/ORD/BI-01-C        | PASS     | The Requester sends Abort Operation after 5 seconds without the first    |
> +|                            |          | On-demand segment.                                                       |
> ++----------------------------+----------+--------------------------------------------------------------------------+
> +| RAP/REQ/ORD/BI-02-C        | PASS     | The Requester sends Abort Operation when a continuation segment is       |
> +|                            |          | missing for more than one second.                                        |
> ++----------------------------+----------+--------------------------------------------------------------------------+
> +| RAP/REQ/ORD/BI-03-C        | PASS     | Ignore Complete Lost and RFU Control Point responses; receive normal     |
> +|                            |          | data and ACK the subsequent Complete response.                           |
> ++----------------------------+----------+--------------------------------------------------------------------------+
> +| RAP/REQ/ORD/BV-05-C        | PASS     | Configure On-demand notification transport; PTS validates Ranging Data   |
> +|                            |          | Ready notification handling.                                             |
> ++----------------------------+----------+--------------------------------------------------------------------------+
> +| RAP/REQ/ORD/BV-06-C        | PASS     | On the PTS MMI, promptly read Ranging Data Ready after PTS suppresses    |
> +|                            |          | its notification.                                                        |
> ++----------------------------+----------+--------------------------------------------------------------------------+
> +| RAP/REQ/ORD/BV-07-C        | PASS     | Configure On-demand indication transport; PTS validates Ranging Data     |
> +|                            |          | Overwritten indication reception.                                        |
> ++----------------------------+----------+--------------------------------------------------------------------------+
> +| RAP/REQ/ORD/BV-08-C        | PASS     | Configure On-demand notification transport; PTS validates Ranging Data   |
> +|                            |          | Overwritten notification reception.                                      |
> ++----------------------------+----------+--------------------------------------------------------------------------+
> +
> +Responder results
> +=================
> +
> ++----------------------------+----------+--------------------------------------------------------------------------+
> +| Test name                  | Result   | Notes                                                                    |
> ++============================+==========+==========================================================================+
> +| RAP/RES/RSPF/BV-01-C       | PASS     | Discoverable advertising includes the Ranging Service UUID (0x185B).     |
> ++----------------------------+----------+--------------------------------------------------------------------------+
> +
> +
> +Before ``RAP/RES/RSPF/BV-01-C``, advertise the Ranging Service UUID so PTS can
> +discover the Responder::
> +
> +    menu advertise
> +    uuids 0000185b-0000-1000-8000-00805f9b34fb
> +    back
> +    advertise peripheral
> +
> +Stop it after the case with ``advertise off``.
> +
> +On-demand ranging data procedures
> +=================================
> +
> +Some RAS Requester cases are exercised against PTS's SIG pre-generated ranging
> +data (``TSPX_test_method``) when the PTS controller does not support Channel
> +Sounding. The procedures below use the ``ranging-data-mode`` command to select
> +the transport PTS expects for each case.
> +
> +For ``RAP/REQ/ORD/BV-01-C``, set ``TSPX_test_method`` to ``pre-generated
> +ranging data`` and select the ``2_procedures`` input.
> +
> +After connection, pairing, and encryption complete, run the following in the
> +same bluetoothctl session::
> +
> +    menu cs
> +    ranging-data-mode <pts_addr> ondemand indicate
> +
> +This configures indications for Ranging Data Ready, RAS Control Point, and
> +Ranging Data Overwritten. Segmented On-demand Ranging Data remains configured
> +for notifications so large pre-generated streams are not stalled by
> +per-indication confirmation pacing.
> +
> +The Requester reads the Ranging Data Ready characteristic, waits for the PTS
> +Ready indication, writes ``Get Ranging Data``, reassembles the data, and writes
> +``ACK Ranging Data`` after the PTS Complete response.
> +
> +For ``RAP/REQ/ORD/BI-01-C``, use the same setup but configure PTS not to send
> +the first On-demand segment after ``Get Ranging Data``. The Requester writes
> +``Abort Operation`` after five seconds. For ``RAP/REQ/ORD/BI-02-C``, have PTS
> +send only First Segment; the Requester's one-second continuation watchdog
> +sends Abort within the PTS assertion window.
> +
> +For ``RAP/REQ/ORD/BI-03-C``, use the same setup and allow PTS to inject
> +Complete Lost Ranging Data Segments and RFU Control Point responses during the
> +transfer. No additional DUT action is required: the Requester ignores them,
> +then ACKs the normal Complete Ranging Data response.
> +
> +For ``RAP/REQ/ORD/BV-05-C``, select notification transport after security is
> +complete::
> +
> +    menu cs
> +    ranging-data-mode <pts_addr> ondemand notify
> +
> +This configures the Ranging Data Ready path for the PTS notification round.
> +
> +For ``RAP/REQ/ORD/BV-07-C``, select indication transport to receive the
> +Ranging Data Overwritten indication::
> +
> +    menu cs
> +    ranging-data-mode <pts_addr> ondemand indicate
> +
> +PTS can log failed attempts to send an indication during this case even though
> +its final verdict is PASS; record the final PTS verdict rather than treating
> +that server-side diagnostic alone as a DUT failure.
> +
> +For ``RAP/REQ/ORD/BV-08-C``, select notification transport to receive the
> +Ranging Data Overwritten notification::
> +
> +    menu cs
> +    ranging-data-mode <pts_addr> ondemand notify
> +
> +For ``RAP/REQ/ORD/BV-06-C``, after connection and security complete, first use
> +indication transport to enter the PTS On-demand flow, then switch to the
> +notification transport used by the lost-Ready round::
> +
> +    menu cs
> +    ranging-data-mode <pts_addr> ondemand indicate
> +    ranging-data-mode <pts_addr> ondemand notify
> +
> +Wait for ``Ranging Data mode updated`` after each command. PTS does not advance
> +to the lost-Ready MMI until both transitions have been completed. It then
> +suppresses the Ranging Data Ready notification and presents an MMI asking for a
> +read of the Ranging Data Ready characteristic. Complete the MMI promptly, before
> +its short timeout, from the bluetoothctl GATT menu::
> +
> +    back
> +    menu gatt
> +    select-attribute 00002c18-0000-1000-8000-00805f9b34fb
> +    read
> +
> +Selecting the characteristic by UUID avoids depending on the handles PTS
> +happens to assign; ``select-attribute`` matches characteristics before
> +descriptors, so this selects the value attribute and not its CCCD. Use
> +``list-attributes`` if the remote database needs to be inspected first. Return
> +to PTS and continue the MMI after the read request is sent.
> diff --git a/doc/qualification/ras-pts.rst b/doc/qualification/ras-pts.rst
> new file mode 100644
> index 000000000..3b9bfd0d0
> --- /dev/null
> +++ b/doc/qualification/ras-pts.rst
> @@ -0,0 +1,135 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +.. Copyright © 2026 Qualcomm Technologies, Inc.
> +
> +================
> +RAS test results
> +================
> +
> +:PTS version: 8.14.0.4
> +:BlueZ: 5.87 with Channel Sounding support
> +
> +RAP Requester and Responder test results are in ``rap-pts.rst``.
> +
> +Setup
> +=====
> +
> +- Enable ``Experimental = true`` in ``/etc/bluetooth/main.conf``.
> +- Use a ``NoInputNoOutput`` bluetoothctl agent and make it the default agent.
> +- Before cases that establish a new encrypted link, delete the DUT bond and the
> +  corresponding PTS LTK/bond. Removing only one side causes authentication
> +  failure.
> +- The DUT acts as the CS Reflector. Set the role from the bluetoothctl Channel
> +  Sounding menu before the first case::
> +
> +      menu cs
> +      role 0x02
> +
> +Tests
> +=====
> +
> ++------------------------------+----------+----------------------------------------------------------------+
> +| Test name                    | Result   | Notes                                                          |
> ++==============================+==========+================================================================+
> +| IOPT/RAS/SR/GATTDB/BV-01-I   | PASS     | RAS database validation.                                       |
> ++------------------------------+----------+----------------------------------------------------------------+
> +| RAS/SR/SGGIT/SER/BV-01-C     | PASS     | Primary, unique Ranging Service discovery.                     |
> ++------------------------------+----------+----------------------------------------------------------------+
> +| RAS/SR/SGGIT/CHA/BV-01-C     | PASS     | RAS Features characteristic declaration.                       |
> ++------------------------------+----------+----------------------------------------------------------------+
> +| RAS/SR/SGGIT/CHA/BV-02-C     | PASS     | Real-time Ranging Data characteristic declaration.             |
> ++------------------------------+----------+----------------------------------------------------------------+
> +| RAS/SR/SGGIT/CHA/BV-03-C     | PASS     | On-demand Ranging Data characteristic declaration.             |
> ++------------------------------+----------+----------------------------------------------------------------+
> +| RAS/SR/SGGIT/CHA/BV-04-C     | PASS     | RAS Control Point characteristic declaration.                  |
> ++------------------------------+----------+----------------------------------------------------------------+
> +| RAS/SR/SGGIT/CHA/BV-08-C     | PASS     | Ranging Data Ready characteristic declaration.                 |
> ++------------------------------+----------+----------------------------------------------------------------+
> +| RAS/SR/SGGIT/CHA/BV-12-C     | PASS     | Ranging Data Overwritten characteristic declaration.           |
> ++------------------------------+----------+----------------------------------------------------------------+
> +| RAS/SR/RCO/BV-01-C           | PASS     | RAS Features read.                                             |
> ++------------------------------+----------+----------------------------------------------------------------+
> +| RAS/SR/RCO/BV-02-C           | PASS     | Ranging Data Ready notification or indication.                 |
> ++------------------------------+----------+----------------------------------------------------------------+
> +| RAS/SR/RCO/BV-03-C           | PASS     | Ranging Data Ready read.                                       |
> ++------------------------------+----------+----------------------------------------------------------------+
> +| RAS/SR/RCO/BV-04-C           | PASS     | Ranging Data Overwritten read.                                 |
> ++------------------------------+----------+----------------------------------------------------------------+
> +| RAS/SR/RCO/BV-05-C           | PASS     | Ranging Data Ready, Indication transport.                      |
> ++------------------------------+----------+----------------------------------------------------------------+
> +| RAS/SR/RCO/BV-06-C           | PASS     | Ranging Data Ready, Notification transport.                    |
> ++------------------------------+----------+----------------------------------------------------------------+
> +| RAS/SR/RCO/BV-07-C           | PASS     | Ranging Data Ready, Indication and Read.                       |
> ++------------------------------+----------+----------------------------------------------------------------+
> +| RAS/SR/RCO/BV-08-C           | PASS     | Ranging Data Overwritten is indicated when the client enabled  |
> +|                              |          | both transports.                                               |
> ++------------------------------+----------+----------------------------------------------------------------+
> +| RAS/SR/RCO/BV-09-C           | PASS     | Ranging Data Ready is indicated when the client enabled both   |
> +|                              |          | transports.                                                    |
> ++------------------------------+----------+----------------------------------------------------------------+
> +| RAS/SR/RRD/BV-01-C           | PASS     | Real-time Ranging Data delivery.                               |
> ++------------------------------+----------+----------------------------------------------------------------+
> +| RAS/SR/RRD/BV-03-C           | PASS     | Real-time Ranging Data is notified when the client enabled     |
> +|                              |          | both transports.                                               |
> ++------------------------------+----------+----------------------------------------------------------------+
> +| RAS/SR/RRD/BV-04-C           | PASS     | Overwritten Real-time data restarts on the new Ranging         |
> +|                              |          | Counter.                                                       |
> ++------------------------------+----------+----------------------------------------------------------------+
> +| RAS/SR/RRD/BV-05-C           | PASS     | Real-time subscription is dropped on disconnection.            |
> ++------------------------------+----------+----------------------------------------------------------------+
> +| RAS/SR/RCP/BV-01-C           | PASS     | Get Ranging Data, segmented transfer and ACK.                  |
> ++------------------------------+----------+----------------------------------------------------------------+
> +| RAS/SR/RCP/BV-03-C           | PASS     | Abort Operation stops an in-progress transfer.                 |
> ++------------------------------+----------+----------------------------------------------------------------+
> +| RAS/SR/RCP/BV-05-C           | PASS     | Control Point state is reset on disconnection.                 |
> ++------------------------------+----------+----------------------------------------------------------------+
> +| RAS/SR/SPE/BI-01-C           | PASS     | Op Code Not Supported, Retrieve Lost Ranging Data Segments.    |
> ++------------------------------+----------+----------------------------------------------------------------+
> +| RAS/SR/SPE/BI-03-C           | PASS     | Op Code Not Supported, Set Filter.                             |
> ++------------------------------+----------+----------------------------------------------------------------+
> +| RAS/SR/SPE/BI-04-C           | PASS     | Op Code Not Supported, RFU.                                    |
> ++------------------------------+----------+----------------------------------------------------------------+
> +| RAS/SR/SPE/BI-05-C           | PASS     | Invalid Parameter, Abort Operation.                            |
> ++------------------------------+----------+----------------------------------------------------------------+
> +| RAS/SR/SPE/BI-06-C           | PASS     | Get Ranging Data and ACK Ranging Data errors.                  |
> ++------------------------------+----------+----------------------------------------------------------------+
> +| RAS/SR/SPE/BI-07-C           | PASS     | Server Busy.                                                   |
> ++------------------------------+----------+----------------------------------------------------------------+
> +| RAS/SR/SPE/BI-11-C           | PASS     | Real-time and On-demand CCCDs are mutually exclusive.          |
> ++------------------------------+----------+----------------------------------------------------------------+
> +
> +Not applicable
> +==============
> +
> ++------------------------------+-----------------------------------------------+
> +| Test name                    | Reason                                        |
> ++==============================+===============================================+
> +| RAS/SR/SPE/BI-02-C           | Applies when Abort Operation is not supported |
> +|                              | (NOT RAS 3/4 in RAS.TS Table 5.1). The IUT    |
> +|                              | supports it, so RAS/SR/RCP/BV-03-C and        |
> +|                              | RAS/SR/SPE/BI-05-C are run instead.           |
> ++------------------------------+-----------------------------------------------+
> +
> +Pre-generated ranging data
> +==========================
> +
> +With ``TSPX_test_method`` set to pre-generated CS data, the whole ranging data
> +arrives in one go rather than one CS subevent at a time, so the On-demand
> +notification path sends its segments back to back with no air time between
> +them. ``RAS/SR/SPE/BI-05-C`` writes an invalid Abort Operation mid-transfer
> +and needs the transfer to still be running when it does, so the per-segment
> +delay has to leave the peer a window: it fails at 0 ms and passes at the 5 ms
> +``RAS_SEGMENT_NFY_PACE_MS`` uses. Feeding the test data one subevent at a
> +time rather than in one go does not change that, since the segments of a
> +subevent still go out back to back. Raise the delay if PTS reports Complete
> +Ranging Data where it expected Invalid Parameter.
> +
> +Transport selection
> +===================
> +
> +When a client enables both notifications and indications on a characteristic,
> +the transport the server must use differs per characteristic:
> +
> +- Ranging Data Ready and Ranging Data Overwritten are indicated (RAS 3.4.2 and
> +  3.5.2), covered by ``RAS/SR/RCO/BV-08-C`` and ``RAS/SR/RCO/BV-09-C``.
> +- On-demand and Real-time Ranging Data are notified (RAS 3.2.2 and 3.2.3.1),
> +  covered by ``RAS/SR/RCO/BV-05..07-C`` and ``RAS/SR/RRD/BV-03-C``.

Could you please share the ICS used to select the tests, similar to 
doc/qualification/rfcomm-pics.rst?

Fred

-- 
Frédéric Danis
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United Kingdom
Registered in England & Wales, no. 5513718

