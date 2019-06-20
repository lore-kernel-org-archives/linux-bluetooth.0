Return-Path: <SRS0=XOEH=UT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D792C43613
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Jun 2019 23:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160FC2070B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Jun 2019 23:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ufw/PJFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfFTXsj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Jun 2019 19:48:39 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34313 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfFTXsi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Jun 2019 19:48:38 -0400
Received: by mail-pg1-f195.google.com with SMTP id p10so2414773pgn.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jun 2019 16:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WDSF4/5gIVl0q/Y5kiKBD3WGHCnc11W4/O/uCS0I/xg=;
        b=Ufw/PJFbsYXI8fOZsVIqLo22TA9EiF422kbGLdL+GtmV9GYxEMoZLsgBfUehldafHK
         DwlaqrKbEXctGNF14IKuHKmEzHZ3V0fLle49ySPaYpo7lRjNPmU6WeGIcLiRE4H2Z5LA
         MTn66GPaJo9t12paeyfP7xC+C43MElFRknKdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WDSF4/5gIVl0q/Y5kiKBD3WGHCnc11W4/O/uCS0I/xg=;
        b=o5uJXJnNgGmrkyhvEdtyf4xe2jJtStkxDrO71R9QoPSq1qjAdDEDfhl1F09dlv/pg9
         B0GhxJ3ZGJWdaeLPMLC6kn0IAsFIJyAaDCWfIvRmVGH8OuLY3DfiavxmqeoANXB+EoQo
         Rgv6uo2ehmFZtx4lm9ockzBZVUwHGOKhEX+Mr8M+A1k/qEwCgu93q1e5wETdo5VV1Y9G
         TUwsoS79p+4NCsngADIxv7nZ3gnFDHp54sK8AskFkZV+ISEf6UYsxuufxaSCcJs9ZpOX
         jfPQdToAsju/zSmRm95eqNYG0HU2TGXLnq+znWMGoyjP4hNF6ooC4LO8AZ8slVMlYDSm
         Givw==
X-Gm-Message-State: APjAAAVylz/MmVuBlYwwy9RtvFNtR4IMaVg+oz/bFKj1enkdskX7+Ubz
        +dbxnoHzDgSMsiU20KsRoLUcyw==
X-Google-Smtp-Source: APXvYqzIk9C3mS84uBO304CxiZE9GF2WsdzLUO9sky2JMwefoEHmlCFHyQZmwBXXx3F2T8RaRqV8tg==
X-Received: by 2002:a17:90a:fa18:: with SMTP id cm24mr2312229pjb.120.1561074518183;
        Thu, 20 Jun 2019 16:48:38 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id d123sm577407pfc.144.2019.06.20.16.48.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 16:48:37 -0700 (PDT)
Date:   Thu, 20 Jun 2019 16:48:35 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Harish Bandi <c-hbandi@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>
Subject: Re: [PATCH v4] Bluetooth: hci_qca: wcn3990: Drop baudrate change
 vendor event
Message-ID: <20190620234835.GZ137143@google.com>
References: <20190521195307.23874-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190521195307.23874-1-mka@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, May 21, 2019 at 12:53:07PM -0700, Matthias Kaehlcke wrote:
> Firmware download to the WCN3990 often fails with a 'TLV response size
> mismatch' error:
> 
> [  133.064659] Bluetooth: hci0: setting up wcn3990
> [  133.489150] Bluetooth: hci0: QCA controller version 0x02140201
> [  133.495245] Bluetooth: hci0: QCA Downloading qca/crbtfw21.tlv
> [  133.507214] Bluetooth: hci0: QCA TLV response size mismatch
> [  133.513265] Bluetooth: hci0: QCA Failed to download patch (-84)
> 
> This is caused by a vendor event that corresponds to an earlier command
> to change the baudrate. The event is not processed in the context of the
> baudrate change and is later interpreted as response to the firmware
> download command (which is also a vendor command), but the driver detects
> that the event doesn't have the expected amount of associated data.
> 
> More details:
> 
> For the WCN3990 the vendor command for a baudrate change isn't sent as
> synchronous HCI command, because the controller sends the corresponding
> vendor event with the new baudrate. The event is received and decoded
> after the baudrate change of the host port.
> 
> Identify the 'unused' event when it is received and don't add it to
> the queue of RX frames.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

ping

Firmware download on WCN3990 is know to be broken for about 6
months. Can we please either apply this patch or discuss possible
alternatives? Doing nothing isn't really a great option :/ As
mentioned earlier one alternative could be a delay at the right place
with a comment why it is needed.

Thanks

Matthias
