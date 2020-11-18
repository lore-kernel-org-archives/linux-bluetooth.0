Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D88EC63777
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Nov 2020 14:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A49E62470D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Nov 2020 14:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jF+qgsgT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgKRO53 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Nov 2020 09:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbgKRO53 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Nov 2020 09:57:29 -0500
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998B8C061A48
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2020 06:57:28 -0800 (PST)
Received: by mail-oo1-xc41.google.com with SMTP id i13so478771oou.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2020 06:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yC56/5eovc0p2taLgfqDLm/bYdGb/IRzX62KgJk5SpM=;
        b=jF+qgsgTVlSYxXl/tWTgZSYUN97wQ2dUy7YOqb28eaxPgemF+rA0k8UMEKyJCoOYDA
         J8cKy2KKGPfAHU7+pAPLD1UySogMBxhwfePjp0t76OWc8/k323xSr7oA5lHcijarxDpK
         LN9xAIw6FykKwCO6DlGZhxyC86aY4gEimCm9QoGkTm2M7wsANTrcqHm4fU9EF+KWO8Bm
         8j2TiyH04trSxW9Ly6JvhNMZ2Mr88S4auHPFg+KosQt/6d9VkogruNP2/cKQtZbdQUgS
         Xkatd15v6Q4SNuMeaSQ3oS5FHpLD3sNxpOP3di4NTIxMcm46u4+yFqfT5HhBCWoP8h+s
         bdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yC56/5eovc0p2taLgfqDLm/bYdGb/IRzX62KgJk5SpM=;
        b=ixrV3IU9JQePaFZsS1ETHtcT0EHtLmFu/LFjtcXj+dt3Iznln8V1Uaqt09s8LSpZgR
         mgqtC6nAYH3NzKymsbb7ICc0FP3VAptCnnzM4zMwr7rDMlK6XUs5iZmjpUumYEgp+d+C
         stsOqctu/vITOVWRriapdmJD4FELzXbjojBEYFPI9Q7fg5J9WUhg7tSDr7Dvi16oFOCr
         IxPyLF5ZsCmAz8rNsUaIo0t2RMkXZhTcYIjg8P4W0XJa64b5boGWR9fOtqcV+YfFdSiA
         vHtyy8b9v8G0KohKNwCRy7agqAJ4/mQIH6bPkIxgk8/jygzXf74Ke6QWnClQCwg7Hlb0
         TQ8A==
X-Gm-Message-State: AOAM533SyOZtLXixRItbqZvCwJMiZRorpE5kpNnh4UngKuxA3xpESVHk
        HBkX277XzGKkQQ+occhrgHHNOA==
X-Google-Smtp-Source: ABdhPJwjzsi8JVKzP3O49BZ1na7F8ToQV6WP4vXzapBZNLXWhmysOVib3zmuwcQczH2gos1EtaMabA==
X-Received: by 2002:a4a:c4c7:: with SMTP id g7mr6558615ooq.50.1605711447885;
        Wed, 18 Nov 2020 06:57:27 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id x9sm6553416otk.9.2020.11.18.06.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 06:57:27 -0800 (PST)
Date:   Wed, 18 Nov 2020 08:57:25 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, rjliao@codeaurora.org,
        hbandi@codeaurora.org, abhishekpandit@chromium.org
Subject: Re: [PATCH v2] Bluetooth: btqca: Add support to read FW build
 version for WCN3991 BTSoC
Message-ID: <20201118145725.GI8532@builder.lan>
References: <1605703943-25980-1-git-send-email-gubbaven@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605703943-25980-1-git-send-email-gubbaven@codeaurora.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed 18 Nov 06:52 CST 2020, Venkata Lakshmi Narayana Gubba wrote:

> Add support to read FW build version for WCN3991 BTSoC

Your commit message doesn't describe why you need/want this? Is it
somehow required for BT to come up or is it simply 57 lines of code to
print a line of build info in the kernel log?



Note that most people reading the kernel log won't care about what
firmware version their BT chip is running, so if it's only for your own
debugging purpose I would prefer if you make this available in sysfs or
debugfs.

Regards,
Bjorn

> 
> Signed-off-by: Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
> ---
>  drivers/bluetooth/btqca.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/bluetooth/btqca.h |  3 +++
>  2 files changed, 60 insertions(+)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index ce9dcff..dfd7ff7 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -101,6 +101,56 @@ int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version,
>  }
>  EXPORT_SYMBOL_GPL(qca_read_soc_version);
>  
> +static int qca_read_fw_build_info(struct hci_dev *hdev)
> +{
> +	struct sk_buff *skb;
> +	struct edl_event_hdr *edl;
> +	char cmd;
> +	int err = 0;
> +	char build_label[QCA_FW_BUILD_VER_LEN];
> +	int build_lbl_len;
> +
> +	bt_dev_dbg(hdev, "QCA read fw build info");
> +
> +	cmd = EDL_GET_BUILD_INFO_CMD;
> +	skb = __hci_cmd_sync_ev(hdev, EDL_PATCH_CMD_OPCODE, EDL_PATCH_CMD_LEN,
> +				&cmd, HCI_EV_VENDOR, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		err = PTR_ERR(skb);
> +		bt_dev_err(hdev, "Reading QCA fw build info failed (%d)",
> +			   err);
> +		return err;
> +	}
> +
> +	edl = (struct edl_event_hdr *)(skb->data);
> +	if (!edl) {
> +		bt_dev_err(hdev, "QCA read fw build info with no header");
> +		err = -EILSEQ;
> +		goto out;
> +	}
> +
> +	if (edl->cresp != EDL_CMD_REQ_RES_EVT ||
> +	    edl->rtype != EDL_GET_BUILD_INFO_CMD) {
> +		bt_dev_err(hdev, "QCA Wrong packet received %d %d", edl->cresp,
> +			   edl->rtype);
> +		err = -EIO;
> +		goto out;
> +	}
> +
> +	build_lbl_len = edl->data[0];
> +	memcpy(build_label, &edl->data[1], build_lbl_len);
> +	*(build_label + build_lbl_len) = '\0';
> +
> +	bt_dev_info(hdev, "BT SoC FW Build info: %s", build_label);
> +
> +out:
> +	kfree_skb(skb);
> +	if (err)
> +		bt_dev_err(hdev, "QCA read fw build info failed (%d)", err);
> +
> +	return err;
> +}
> +
>  static int qca_send_reset(struct hci_dev *hdev)
>  {
>  	struct sk_buff *skb;
> @@ -520,6 +570,13 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  		return err;
>  	}
>  
> +	if (soc_type == QCA_WCN3991) {
> +		/* get fw build info */
> +		err = qca_read_fw_build_info(hdev);
> +		if (err < 0)
> +			return err;
> +	}
> +
>  	bt_dev_info(hdev, "QCA setup on UART is completed");
>  
>  	return 0;
> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
> index d81b74c..375c7fc 100644
> --- a/drivers/bluetooth/btqca.h
> +++ b/drivers/bluetooth/btqca.h
> @@ -11,6 +11,7 @@
>  #define EDL_PATCH_CMD_LEN		(1)
>  #define EDL_PATCH_VER_REQ_CMD		(0x19)
>  #define EDL_PATCH_TLV_REQ_CMD		(0x1E)
> +#define EDL_GET_BUILD_INFO_CMD		(0x20)
>  #define EDL_NVM_ACCESS_SET_REQ_CMD	(0x01)
>  #define MAX_SIZE_PER_TLV_SEGMENT	(243)
>  #define QCA_PRE_SHUTDOWN_CMD		(0xFC08)
> @@ -34,6 +35,8 @@
>  #define QCA_HCI_CC_OPCODE		0xFC00
>  #define QCA_HCI_CC_SUCCESS		0x00
>  
> +#define QCA_FW_BUILD_VER_LEN		255
> +
>  enum qca_baudrate {
>  	QCA_BAUDRATE_115200 	= 0,
>  	QCA_BAUDRATE_57600,
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
> of Code Aurora Forum, hosted by The Linux Foundation
> 
