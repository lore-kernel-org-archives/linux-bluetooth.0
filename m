Return-Path: <SRS0=EsMn=TA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D02FC43219
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Apr 2019 07:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C30820835
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Apr 2019 07:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="Zoh4p+tu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbfD3HiQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Apr 2019 03:38:16 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38558 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfD3HiP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Apr 2019 03:38:15 -0400
Received: by mail-lf1-f65.google.com with SMTP id v1so10050914lfg.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Apr 2019 00:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=b0WBcFGdrAwVa6ZwQ6bFQaDwqVFhYv2Kw0Rw422lFJw=;
        b=Zoh4p+tuakIdNNMry0vdndEt256dtAIweyeni/pm7LOzXytw+wE9j2DdOf5XFB5Fbb
         4lfOiq0Y8j71IsAgZMflRbKAoPFZe9ayRquMx65suBw0leH1bjXUrIXYU/azqsKaKbig
         RtfS1kL8vB8rSid5/00KHZ+ZEKOVcbpLZEeAwqf/I4gAvCt63b9P3CAophmoDTbMVrSU
         9XZIJIeDlWx5M/O4shR/1OC3vMtmPwtHHhuwDSpoWxm86Xvd7x7bTdGzNCMGRoTIQN34
         J6rkUuLppPRrC6AZeY9hi7x2ql5umj35sXPCDNMUSh4o3xBNU7It77js7YCe2XyJk8Sb
         FFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=b0WBcFGdrAwVa6ZwQ6bFQaDwqVFhYv2Kw0Rw422lFJw=;
        b=fZlx4tobGJOwfPN6vT6ct5o1INvDg/FnZeGiBgbhi9ZS0VA04Vu2tSYsaHb0fysKiH
         YiMARXuNKyH+sXoSfniVfflLjV/zX67NdTyzaQsqPJUBxdd5eD0T3QDWpkHcKNZf4Srg
         wCKOAqvewFRw47B0NbTp7JPzYouOUhsxul8nPA1b66WQTaiO2kLR+LHXm5LlclSfMKo/
         uQYxiSZVURwRJq9YCeBx4CjEou95w+9meNZ/CDtNnVroFpMHIKDZdnBE7zxfF6tE1OhS
         6T19tsIv+ARQVPa+4sxC35nHZ4hzm9TrObi9f1JobhMKrIaiGb7iqZVOqNV9liS/7J57
         u7Wg==
X-Gm-Message-State: APjAAAWPAnxvvFMjT8JT89wFFwgkyQXOLb7Ck9S79lIPQV/l9tkJucWZ
        VN1g3p0t5DzUo0lzHk1d2gswug==
X-Google-Smtp-Source: APXvYqwgo2ai74AVEmZuYk3E3Pu8LPy9Ng4euPiASqWjhjnTaI8z3EmnVcphH/TAzeZx6/4SPeyYDg==
X-Received: by 2002:ac2:5495:: with SMTP id t21mr34693113lfk.3.1556609892990;
        Tue, 30 Apr 2019 00:38:12 -0700 (PDT)
Received: from scytale ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id q11sm7825573lfc.51.2019.04.30.00.38.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 00:38:11 -0700 (PDT)
Date:   Tue, 30 Apr 2019 09:38:09 +0200
From:   Michal Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Add remote dev key support and cleanup
Message-ID: <20190430073809.wdbhglfaiqsvscmc@scytale>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
References: <20190423231624.19302-1-brian.gix@intel.com>
 <20190424085945.zmniib4vpy2uiyql@kynes>
 <DEBB0CAA2616974FAE35E4B560B9A4376CB05944@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DEBB0CAA2616974FAE35E4B560B9A4376CB05944@ORSMSX103.amr.corp.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On 04/24, Gix, Brian wrote:
> > From: Michał Lowas-Rzechonek [mailto:michal.lowas-rzechonek@silvair.com]
> > > +try_remote:
> > > +	/* Try remote device key if available */
> > > +	dev_key = node_get_remote_device_key(node, src);
> > > +	if (!dev_key)
> > > +		return -1;
> > > +
> > > +	if (mesh_crypto_payload_decrypt(NULL, 0, data, size, szmict, src,
> > > +					dst, key_id, seq, iv_idx, out,
> > dev_key))
> > > +		return APP_IDX_DEV_RMT;
> > > +
> > What's the purpose of APP_IDX_DEV_RMT?
> 
> App Index is an internal way to track which credentials were used to
> decrypt a message.  In theory, if the incoming message used the local
> device key, then the message is addressed to one of the local servers,
> and if the incoming message was decrypted by a *remote* device key it
> should be addressed to a local Client (as a response from a remote
> server).
>
> To enable that, we need to differentiate between the two possible
> device keys.
>
> However, also importantly, if a message that requires a response is
> received on *any* key (local dev, remote dev, or App Key) the response
> is supposed to be sent with the same key.
Right, but I think this is covered by the server/client model behaviour,
so I don't think we need to care if the message was encrypted using a
known remote device key, or our local device key.

This is indeed not explicitly mentioned in the spec, but I think the
consensus is that a server model shall always send responses using a
local device key.

I think this means that the API needs to allow using either local or
remote device key when *sending* a message (i.e. use remote key for
requests and local key for responses), but API for receiving messages
needs only to differentiate between device and application keys.

> When *sending* Dev Key message
> from the Application, we will try the remote nodes device key first,
> and if it does not exist we fall back to the local key.
I'm not sure the key selection should happen automaticall. I'd rather
have an explicit option to use local device key or remote one.

> In any case, these "Magic Numbers" are internal use only, and do not
> show up on the external interface.
Well, at the moment they are visible in Send() call: key_index argument
accepts 0x7fff as a way to indicate that local device key should be
used.

I guess you're refering to the updated doc/mesh-api.txt, so the plain Send()
method will accept only *real* app key indexes?

> > >  #define DEFAULT_CRPL 10
> > > +#define REMOTE_CACHE_LEN 5
> > By the way: why the limits here are set so low (and there doesn't seem to be
> > a way to change them...)?
> When being used as a Config Client, we are just trying to avoid
> reopening the file to fetch the device key to decode the expected
> response.
> (...)
> All the device keys are always available...  they
> just may need to be read into RAM from storage.
Ok, got it.

I was more concerned about the CRPL size. At the moment the limit means
that a node cannot simultaneously talk to more than 10 remote nodes
because of this (mesh/appkey.c:227):

	/* Replay Cache is fixed sized */
	if (l_queue_length(key->replay_cache) >= crpl) {
		int ret = l_queue_foreach_remove(key->replay_cache,
				clean_old_iv_index, L_UINT_TO_PTR(iv_index));

		if (!ret)
			return true;
	}

> > I don't see why the remote key storage should be kept separately (and in
> > binary files?) from the main node json. It makes the implementation much
> > more complicated, as you need to worry about directories etc.
> Again, this creates an open-ended RAM requirement that depends on the
> existence of external resources...
Not necessarily.

I understand that in the current implementation, the storage JSON is
kept in memory as a whole (mesh_node.jconfig), so adding stuff there
indeed increases the memory footprint of a node, but it doesn't need to
be like that.

What are your thoughts on replacing the JSON storage with something
more granular? The main bluetoothd seems to use a directory structure
and INI files, but a key-value store like gdbm might also be an option,
especially for frequently changing values like the sequence number.
A database would allow us to avoid explicit caching and rely on mmap().

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
