Return-Path: <SRS0=u1pM=5S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F49C43331
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Apr 2020 14:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E72F2074D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Apr 2020 14:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="O1KDYcf8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388311AbgDBOem (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:34:42 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:40260 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732263AbgDBOem (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Apr 2020 10:34:42 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200402143439epoutp03ed229c2e5857ef6c996ba62e9cbbd514~CB1SubHeM2220222202epoutp03h
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2020 14:34:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200402143439epoutp03ed229c2e5857ef6c996ba62e9cbbd514~CB1SubHeM2220222202epoutp03h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585838079;
        bh=WExTX8kD1lKHc/v4dUEqekJHkyQidjP7eYgtzj/tJ0A=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=O1KDYcf8EbJXl01XVIljmfbNSErc3smutId6YdVKj9m+3TGwFUeML2U52o9YU9CoF
         b0lZ19W9a2C9Eq9f5PGqrhkLHPEGmXJVrEueKdFK+GIXlh5QdG72p4znHVZbkxkZe3
         UjCX60r9Yr02Wbf66ToHMGPVx7b65141e9b4YvCw=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20200402143438epcas5p36755bcf3a64d2127685efaa623adc6fd~CB1RyqRjJ2668226682epcas5p37;
        Thu,  2 Apr 2020 14:34:38 +0000 (GMT)
X-AuditID: b6c32a49-89bff700000012ae-1d-5e85f7fe747d
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        72.7F.04782.EF7F58E5; Thu,  2 Apr 2020 23:34:38 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH BlueZ] mesh: Add check for valid netkey index
Reply-To: anupam.r@samsung.com
From:   Anupam Roy <anupam.r@samsung.com>
To:     "Gix, Brian" <brian.gix@intel.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Semun Lee <semun.lee@samsung.com>,
        Dohyun Pyun <dh79.pyun@samsung.com>,
        Nitin Jhanwar <nitin.j@samsung.com>,
        AMIT KUMAR JAISWAL <amit.jaiswal@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <82b707704e1863c43748adce03057d2252fea59a.camel@intel.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20200402140519epcms5p3608d451804bf03eefc34ce77b04ab0aa@epcms5p3>
Date:   Thu, 02 Apr 2020 19:35:19 +0530
X-CMS-MailID: 20200402140519epcms5p3608d451804bf03eefc34ce77b04ab0aa
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42LZdlhTS/ff99Y4gzWtzBbvuqazWayYsZrN
        Ysn3j2wWc671MVtsW9fObHFs01MmBzaPxXteMnn0bVnF6PF5k1wAcxSXTUpqTmZZapG+XQJX
        Rm/XUfaC7xIV379OY25gvC/cxcjJISFgIvH37W+WLkYuDiGB3YwSW35/Ye1i5ODgFRCU+LsD
        rEZYwFVi+qQ2FhBbSEBOYvHUtWwgJcICmhI3N6aAhNkE1CV+PdwBViIioCZx8foBZpCRzAIv
        GSUm7DjHBLGLV2JG+1MWCFtaYvvyrYwgNqeAu8TRH3uYIeKiEjdXv2WHsd8fm88IYYtItN47
        C1UjKPHg525GmDlbFzwFWyYh0M0o8XrHeiYIZwqjxMeLb6E2m0v8734L1sEr4Cvx41UHK4jN
        IqAq8XDiR6ipLhL9ncfYQGxmAXmJ7W/nMIN8yQz05fpd+hAlshJTT61jgijhk+j9/QTusR3z
        YGwlia3X57NC2BISfZt3QcU9JE5u+cUECegTjBKH9m1lnsCoMAsR1rOQbJ6FsHkBI/MqRsnU
        guLc9NRi0wLDvNRyveLE3OLSvHS95PzcTYzgZKLluYNx1jmfQ4wCHIxKPLwMB1vjhFgTy4or
        cw8xSnAwK4nwOs4ACvGmJFZWpRblxxeV5qQWH2KU5mBREuedxHo1RkggPbEkNTs1tSC1CCbL
        xMEp1cB48OX3ZyIGW15M/XSWs7BS9aeY185TnVKfnzBcm+f7cqN8cbzmFsHlxn4aK/+fvDPH
        dpUf659K5UO/VlnqJZldVZDu+pzRubbqxPQZhcWHOg4sub17l5r7+a/5Zcfdm5c1T96/6L1M
        2sRA6ew8HsVI1/g6lurU0NJbc4RSyvwz8rYwf2dTkzNVYinOSDTUYi4qTgQAgiE0+yIDAAA=
X-CMS-RootMailID: 20200401112015epcas5p10545143f69c22449f559818476845cc5
References: <82b707704e1863c43748adce03057d2252fea59a.camel@intel.com>
        <1585740006-9569-1-git-send-email-anupam.r@samsung.com>
        <CGME20200401112015epcas5p10545143f69c22449f559818476845cc5@epcms5p3>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

>Hi Anupam,
>On Wed, 2020-04-01 at 16:50 +0530, Anupam Roy wrote:
>> This patch adds validation of net key index, which will be
>> used to send message to nodes. Return error in case net key index
>> is not valid. This avoids message encryption using device key
>> and further processing of the message.
>> ---
>>  mesh/model.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>> 
>> diff --git a/mesh/model.c b/mesh/model.c
>> index 9455833..6cc1dc5 100644
>> --- a/mesh/model.c
>> +++ b/mesh/model.c
>> @@ -546,6 +546,7 @@ static bool msg_send(struct mesh_node *node, bool credential, uint16_t src,
>>  	uint8_t dev_key[16];
>>  	uint32_t iv_index, seq_num;
>>  	const uint8_t *key;
>> +	struct keyring_net_key net_key;
>>  	uint8_t *out;
>>  	uint8_t key_aid = APP_AID_DEV;
>>  	bool szmic = false;
>> @@ -578,8 +579,16 @@ static bool msg_send(struct mesh_node *node, bool credential, uint16_t src,
>>  		}
>>  
>>  		net_idx = appkey_net_idx(node_get_net(node), app_idx);
>> +		if (net_idx == NET_IDX_INVALID) {
>> +			l_debug("no net key for (%x)", net_idx);
>> +			return false;
>> +		}
>
>This *might* be a valid "sanity" test...  Although an App Key should never be allowed to be added, or exist
>unless the bound netkey already exists.  I think the only way an App Key might exist without it's bound netkey
>is if the daemon private node.json file was hand edited, which is not technically allowed.
>
>>  	}
>>  
>> +	if (!keyring_get_net_key(node, net_idx, &net_key)) {
>> +		l_debug("no net key for (%x)", net_idx);
>> +		return false;
>> +	}
>
>This check is invalid. Only an authorized Config Clients / Provisioners have Key Rings, which is used to send
>AddKey, UpdateKey and Provisioning data to remote nodes.  The keyring is restricted to nodes which have full
>network configuration privleges....  Adding this would require *all* nodes in the network to be privleged
>nodes, which would then allow them to make changes outside the Provisioner/ Config Client control.
>
 Thanks you for your input. The intention was to validate 'Net Key Index' for DevKeySend messages, sent by *Config client/Provisioner* app specifically.
 Actually, one observation I had is that, even though, Config client supplies the 'Net Key Index', & daemon passes it all the way to msg_send(), eventually, it seems, it is ignored & encryption key is picked up from the primary subnet. Also, I noticed that Config client seems to allow deleting a created subnet (subnet-delete <net key index>) at present, at any point of time.

 I am not sure if *Not using* the 'Net Key Index' by the daemon is by design.

Anyways, I got what you explained about *authorized apps having Keyring access*. In such case, I think, the keyring check would make sense only in the following condition. Please share your opinion. Thanks.
	} else if (app_idx == APP_IDX_DEV_REMOTE) {
        if (!keyring_get_remote_dev_key(node, dst, dev_key))
            return false;
			
        key = dev_key;
			
		/** Add Key Ring Check for valid Net Key Index **/
        }

>>  	l_debug("(%x) %p", app_idx, key);
>>  	l_debug("net_idx %x", net_idx);
>>  
