Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD7831714F
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784973242; cv=none; b=tIxrbNQLlGmF5xx/FjW0TR/SFpRTQP/8q8hLYIOWNKG6qBLsmqBsXBPI/rAyo0YMxrZx20LtIRhW+aFTKYtLZtS/XmcWwsDFVMjxc2NpNlOiZxdzw+DHe4v7XVPokLikaqmdqQ3+4xCwF06haGe7z1NTFwjoUozFrdwJIcZ0G/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784973242; c=relaxed/simple;
	bh=VWEunNI0KlzajewIvsdUHQ30+0kN5QhCPtYOoa5rhB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p50YuXQO17xDZf/MxOWA0CQ191rPWSP5qWvEOFqPFz1N1+o821bRhEy/DCfSufMFsY81KNEqIPM4FFX4jOcD3J3M7qDStEnVLWEA1CHsq1e+w2BiyujjMuR/7zDeDpNqF0LE3CXVA/vZB0q2g5RC6Dn0cHETYuloc8aOrZObvUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AQyHPwL+; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AQyHPwL+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=NLT5I73L0oilb/ExGbjJ3snomNermyh77ziD5ZXQYfk=;
	b=AQyHPwL+u/A9Au4W0gVkX1XhK1KrXeDgVMBcZZ10TMwR8bBaKgehCqMBGdkudi
	CxEXjJJhi66RStKrxOjOw7szD5uwOd2qcHWuLfhzIGMNSsdcGQv7U6ApMi9XfmhG
	jzBkvxDu5tvmE1+HQdQlyyJ5a1wK0IANcLavhXXlAAGac=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgBnkPdzh2RqVTQKIQ--.45326S2;
	Sat, 25 Jul 2026 17:52:53 +0800 (CST)
From: zhangchen200426@163.com
To: pmenzel@molgen.mpg.de
Cc: gustavoars@kernel.org,
	linux-bluetooth@vger.kernel.org,
	luiz.von.dentz@intel.com,
	naga.akella@oss.qualcomm.com,
	pav@iki.fi,
	tim.bird@sony.com,
	yang.li@amlogic.com,
	zhangchen01@kylinos.cn,
	zhangchen200426@163.com
Subject: Re: [PATCH v2] Bluetooth: hci_event: Add HCI_Write_Link_Supervision_Timeout command/event structures
Date: Sat, 25 Jul 2026 17:52:51 +0800
Message-Id: <20260725095251.2267431-1-zhangchen200426@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <a5980d04-4d39-4d3d-bbc8-738abd394fd6@molgen.mpg.de>
References: <a5980d04-4d39-4d3d-bbc8-738abd394fd6@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgBnkPdzh2RqVTQKIQ--.45326S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Wr1DurWUuw4DJr4DJr1kZrb_yoW3WF15pa
	yYka98Gr48Jr1fX3WfZ3ykuFs5Zws7XrW7Gr4qqa4Fyan0vrWkKr40y345Kry7CrWkGF1a
	vF42grW2kryDJ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUGjgwUUUUU=
X-CM-SenderInfo: x2kd0whfkh0jaqqujli6rwjhhfrp/xtbC6BWyT2pkh3WpzgAA3b

Dear Paul

Thank you for providing the comments.

On Fri, 24 Jul 2026 11:23:26 +0200, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Chen,
>
>
> Thank you for your patch.
>
> Am 24.07.26 um 10:54 schrieb zhangchen200426@163.com:
> > From: Chen Zhang <zhangchen01@kylinos.cn>
> > 
> > Some speakers do not actively initiate disconnection when power off. As
>
> … powering …
>
> > a result, the center can only wait for a timeout to disconnect, with the
>
> What does “the center” refer to?
In the scenario where a phone actively connects to a speaker, the phone acts as the central device and the speaker is the peripheral device. You can also say the phone is the master and the speaker is the slave. The center refers to the central device.
>
> > default timeout being 20s. In certain scenarios, this can significantly
> > impact user experience. For example, if a speaker is playing music and
> > is then turned off, it takes 20s before the music starts playing from
> > the center.
> > 
> > Define HCI_Write_Link_Supervision_Timeout command, event structure, and
> > corresponding event handler function, set the timeout to 5s after ACL
> > link is established.
>
> Why five seconds and not less? How do Chromium OS or Android do it?
In environments with significant interference, a larger timeout value should generally lead to better connection stability. The 5-second value was chosen based on a comprehensive evaluation and can be considered an empirical value. For reference, the Android system defaults to 8 seconds. You can find the corresponding logic in the on_acl_br_edr_connected and btm_acl_role_changed functions in the Android 17 source code at packages/modules/Bluetooth/system/stack/acl/btm_acl.cc.
>
> Please also document one test setup up, where you could reproduce it.
The local setup uses RTL8852BU and MT7922 modules.
After connecting the PC to the speaker via scanning, use the hcitool to query the link supervision timeout. The steps are as follows:
hcitool con
Connections:
        < ACL BE:EC:CC:19:7C:D9 handle 70 state 1 lm CENTRAL AUTH ENCRYPT

hcitool cmd 0x03 0x0036 0x46 0x00
< HCI Command: ogf 0x03, ocf 0x0036, plen 2
  46 00
> HCI Event: 0x0e plen 8
  01 36 0C 00 46 00 00 7D
Here, 00 7D represents the timeout value 0x7D00, which converts to the actual time: 32000*0.625ms = 20000ms.

Then, power off the speaker and observe how long it takes for btmon to print the HCI disconnection message.
The reason for the disconnection is Connection Timeout.
> HCI Event: Disconnect Complete (0x05) plen 4        #1 [hci0] 17:17:48.806247
        Status: Success (0x00)
        Handle: 70
        Reason: Connection Timeout (0x08)

Some devices actively initiate a disconnection when powered off. In this case, the link supervision timeout will not take effect, so the issue cannot be reproduced.
The reason for the disconnection is Remote User Terminated Connection.
> ACL Data RX: Handle 69 flags 0x02 dlen 12        #1158 [hci0] 17:22:17.418475
      L2CAP: Disconnection Request (0x06) ident 16 len 4
        Destination CID: 66
        Source CID: 68
< ACL Data TX: Handle 69 flags 0x00 dlen 12        #1159 [hci0] 17:22:17.418514
      L2CAP: Disconnection Response (0x07) ident 16 len 4
        Destination CID: 66
        Source CID: 68
> HCI Event: Disconnect Complete (0x05) plen 4     #1161 [hci0] 17:22:17.671651
        Status: Success (0x00)
        Handle: 69
        Reason: Remote User Terminated Connection (0x13)
>
> > Signed-off-by: Chen Zhang <zhangchen01@kylinos.cn>
> > ---
> >   include/net/bluetooth/hci.h      | 10 +++++++
> >   include/net/bluetooth/hci_core.h |  1 +
> >   net/bluetooth/hci_event.c        | 50 ++++++++++++++++++++++++++++++++
> >   3 files changed, 61 insertions(+)
> > 
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 50f0eef71fb1..18a5a17eb218 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -1239,6 +1239,16 @@ struct hci_cp_host_buffer_size {
> >   	__le16   sco_max_pkt;
> >   } __packed;
> >   
> > +#define HCI_OP_WRITE_LINK_SUPERVISION_TIMEOUT	0x0c37
> > +struct hci_cp_write_link_supervision_timeout {
> > +	__le16	 handle;
> > +	__le16	 timeout;
>
> How about appending the unit for the timeout: timeout_s.
If there are no other issues with this patch review, I'll upload a v3 version and update the 'timeout' to 'timeout_ms'.
>
> > +} __packed;
> > +struct hci_rp_write_link_supervision_timeout {
> > +	__u8	 status;
> > +	__le16	 handle;
> > +} __packed;
> > +
> >   #define HCI_OP_READ_NUM_SUPPORTED_IAC	0x0c38
> >   struct hci_rp_read_num_supported_iac {
> >   	__u8	status;
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > index e7133ff87fbf..866903a9b5c8 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -702,6 +702,7 @@ struct hci_conn {
> >   	__u8		le_features[248];
> >   	__u16		pkt_type;
> >   	__u16		link_policy;
> > +	__u16		link_supervision_timeout;
>
> Ditto.
>
> >   	__u8		key_type;
> >   	__u8		auth_type;
> >   	__u8		sec_level;
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 741d658e9630..653184d0dfc7 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -606,6 +606,44 @@ static u8 hci_cc_write_voice_setting(struct hci_dev *hdev, void *data,
> >   	return rp->status;
> >   }
> >   
> > +static u8 hci_cc_write_link_supervision_timeout(struct hci_dev *hdev, void *data,
> > +						struct sk_buff *skb)
> > +{
> > +	struct hci_ev_status *rp = data;
> > +	struct hci_cp_write_link_supervision_timeout *sent;
> > +	struct hci_conn *conn;
> > +	u16 handle;
> > +	u8 status = rp->status;
> > +
> > +	bt_dev_dbg(hdev, "status 0x%2.2x", status);
> > +
> > +	sent = hci_sent_cmd_data(hdev, HCI_OP_WRITE_LINK_SUPERVISION_TIMEOUT);
> > +	if (!sent)
> > +		return status;
> > +
> > +	handle = le16_to_cpu(sent->handle);
> > +
> > +	hci_dev_lock(hdev);
> > +
> > +	conn = hci_conn_hash_lookup_handle(hdev, handle);
> > +	if (!conn) {
> > +		status = 0xFF;
> > +		goto done;
> > +	}
> > +
> > +	if (!status) {
> > +		conn->link_supervision_timeout = __le16_to_cpu(sent->timeout);
> > +		bt_dev_dbg(hdev, "handle 0x%4.4x timeout set to 0x%4.4x (%u ms)",
> > +			   handle, conn->link_supervision_timeout,
> > +			   conn->link_supervision_timeout * 5 / 8);
> > +	}
> > +
> > +done:
> > +	hci_dev_unlock(hdev);
> > +
> > +	return status;
> > +}
> > +
> >   static u8 hci_cc_read_num_supported_iac(struct hci_dev *hdev, void *data,
> >   					struct sk_buff *skb)
> >   {
> > @@ -3240,6 +3278,16 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
> >   			hci_send_cmd(hdev, HCI_OP_CHANGE_CONN_PTYPE, sizeof(cp),
> >   				     &cp);
> >   		}
> > +
> > +		if (conn->type == ACL_LINK && conn->role == HCI_ROLE_MASTER) {
> > +			struct hci_cp_write_link_supervision_timeout cp;
> > +
> > +			cp.handle = ev->handle;
> > +			cp.timeout = 0x1F40;	/* 8000 * 0.625ms = 5000ms */
> > +			hci_send_cmd(hdev, HCI_OP_WRITE_LINK_SUPERVISION_TIMEOUT,
> > +				     sizeof(cp), &cp);
> > +		}
> > +
> >   	}
> >   
> >   	if (conn->type == ACL_LINK)
> > @@ -4097,6 +4145,8 @@ static const struct hci_cc {
> >   	HCI_CC_STATUS(HCI_OP_WRITE_CLASS_OF_DEV, hci_cc_write_class_of_dev),
> >   	HCI_CC(HCI_OP_READ_VOICE_SETTING, hci_cc_read_voice_setting,
> >   	       sizeof(struct hci_rp_read_voice_setting)),
> > +	HCI_CC(HCI_OP_WRITE_LINK_SUPERVISION_TIMEOUT, hci_cc_write_link_supervision_timeout,
> > +	       sizeof(struct hci_rp_write_link_supervision_timeout)),
> >   	HCI_CC_STATUS(HCI_OP_WRITE_VOICE_SETTING, hci_cc_write_voice_setting),
> >   	HCI_CC(HCI_OP_READ_NUM_SUPPORTED_IAC, hci_cc_read_num_supported_iac,
> >   	       sizeof(struct hci_rp_read_num_supported_iac)),
>
>


-- 
Regards,
    Chen Zhang

