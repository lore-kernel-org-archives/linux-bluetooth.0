Return-Path: <SRS0=+pQP=5K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5D0C18E5B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 08:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A20B2073E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 08:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgCYIaq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:30:46 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48110 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgCYIaq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Mar 2020 04:30:46 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id E925CCECCA;
        Wed, 25 Mar 2020 09:40:16 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH v2] bluetooth: don't assume key size is 16 when the
 command fails.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200324195008.10822-1-alainm@chromium.org>
Date:   Wed, 25 Mar 2020 09:30:44 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <DA16546C-9D3B-42A6-A7C1-0342493A759D@holtmann.org>
References: <20200324195008.10822-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

can please prefix the subject with “Bluetooth: “ then I have to stop fixing it up after applying ;)

> With this change, the encryption key size is not assumed to be 16 if the
> read_encryption_key_size command fails for any reason.  This ensures
> that if the controller fails the command for any reason that the
> encryption key size isn't implicitely set to 16 and instead take a more
> concervative posture to assume it is 0.
> 
> Signed-off-by: Alain Michaud <alainm@chromium.org>
> 
> ---
> 
> net/bluetooth/hci_event.c | 6 +-----
> 1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index cd3d7d90029b..8a7a94e6f956 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2963,14 +2963,10 @@ static void read_enc_key_size_complete(struct hci_dev *hdev, u8 status,
> 	if (!conn)
> 		goto unlock;
> 
> -	/* If we fail to read the encryption key size, assume maximum
> -	 * (which is the same we do also when this HCI command isn't
> -	 * supported.
> -	 */

	/* When the command to read the encryption key size fails, then this
	 * normally indicates a bad handle or an invalid handle. However in
	 * this case we are pretty certain that the parameters provided have
	 * been correct. This means that if the command fails, something
	 * serious went wrong between the controller and the host. The best
	 * approach is to fail the connection now and for that the key size
	 * is set to 0 to force a disconnect.
	 */

> 	if (rp->status) {
> 		bt_dev_err(hdev, "failed to read key size for handle %u",
> 			   handle);
> -		conn->enc_key_size = HCI_LINK_KEY_SIZE;
> +		conn->enc_key_size = 0;
> 	} else {
> 		conn->enc_key_size = rp->key_size;
> 	}

So I wouldn’t scrap the comment. I would extend it to something like above. Feel free to copy it or reword or use your own words. I just want a comment there that when I read the code in 6 month from now, I remember why this is done.

Regards

Marcel

