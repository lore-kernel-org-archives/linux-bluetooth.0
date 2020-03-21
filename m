Return-Path: <SRS0=gowC=5G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085B5C4332D
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 Mar 2020 19:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF4F2072C
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 Mar 2020 19:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjsvqSU0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgCUTyJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 21 Mar 2020 15:54:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45296 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbgCUTyJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 21 Mar 2020 15:54:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id t7so6984544wrw.12
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Mar 2020 12:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YDOzb/EhDKRxsKcbtsw0Lrd2MCAMorr95XD0YJL7IwQ=;
        b=SjsvqSU0RROxSPtP9S4b8siZOJZa+f5UHPNbAWupq/2aPTKJNnd/6PRlI+c/XjTgFw
         v6/dQr7WAsOreI7i9BNxqlBeWX+8dJr6URPmrf47//7X85SYEReDXVLWkrYBCr6yzQN9
         oKDUjmLjgQvbplhSLeNCZcsKjOvOG9Lur2ROY7Nj8UIMj+EOuZYPzyMMzgyoYDh3v1T/
         DhAgOhNud5b81zcUyhyXdEAfAVuXL6OsqML+iMgo8P3mc2MsTuWr7lZUqpFHbsIDkuzB
         DWdljUa+eSOOnIxWQdnv0ciZ9LQ733+pI9jZF31NBevlDYzMLc6wvURWGIaHcfnHRnBm
         nAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YDOzb/EhDKRxsKcbtsw0Lrd2MCAMorr95XD0YJL7IwQ=;
        b=TVy97F/SowMdjUgE01/WwrXMpUTAhqculKuBY8ZjMQxkvAEHGEXyvffK2KGwMi8lE5
         bvmwMkjzacu5GiVH4hFmdaJKD9LCdYm2J6Y6jVOHHzSkAgDkr7jx22KRREwfOrxgQICQ
         D8sTsJhLHbBxjU3WEdnEOfeaMrcubkUDbzii/R54iX0p90GVHn1McQWCbLCqQExBaIhh
         dQBkCrpsdv2DOAkFni0dMLVPg0X275U2JWmvtlLsaxKTWsm+3dDvnc44W2RO4JLhRQUM
         IL5sNcaheppteRYwqHEF1dck/jjzUlGwz5LiujJsYns8Q/3lCSY8g3e2nRHzu/A9Kvvi
         u+eQ==
X-Gm-Message-State: ANhLgQ2rLfUAxG9rW+sshvZb5311lUsOLdtGTsTvbhRzOXRPMaxW2tqw
        AzsvEOS7QjVjTHtVPcdeMMn7S6RO
X-Google-Smtp-Source: ADFU+vt5uLC62wXbt6o6HCsNo6zZLWCbjPQpqjXhXl35S4FxwvCVWvtoGZDWGTIDHdoS4+FokZl8Tw==
X-Received: by 2002:a5d:6605:: with SMTP id n5mr9520045wru.303.1584820446422;
        Sat, 21 Mar 2020 12:54:06 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id y200sm14410883wmc.20.2020.03.21.12.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 12:54:05 -0700 (PDT)
Date:   Sat, 21 Mar 2020 20:54:04 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        David Heidelberg <david@ixit.cz>
Subject: Re: bluez: Export SDP "Remote audio volume control" item for HSP
 profile
Message-ID: <20200321195404.fvyku5hmcuqxt7sg@pali>
References: <20191212172944.hgt6se2qz2hpsbo2@pali>
 <CABBYNZKCovNDcAaMMeYZgKAAq-8oz+pcs6xmS3A_Qt-28aoEbQ@mail.gmail.com>
 <20191212230314.g5gt6rxkphzpwucd@pali>
 <20200209130243.u4kpbj3cwhbdqa56@pali>
 <20200320130159.cm2shncjg5qo6xgh@pali>
 <CABBYNZ+nuBOH8gu1EJ4iF_r8v53g3rvVMcCm_Kt=5SXijhQY7A@mail.gmail.com>
 <20200321184015.mtmb7zfk3jqcf6ya@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200321184015.mtmb7zfk3jqcf6ya@pali>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Saturday 21 March 2020 19:40:15 Pali Rohár wrote:
> On Friday 20 March 2020 10:48:02 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> > 
> > On Fri, Mar 20, 2020 at 6:02 AM Pali Rohár <pali.rohar@gmail.com> wrote:
> > >
> > > On Sunday 09 February 2020 14:02:43 Pali Rohár wrote:
> > > > On Friday 13 December 2019 00:03:14 Pali Rohár wrote:
> > > > > On Thursday 12 December 2019 21:42:27 Luiz Augusto von Dentz wrote:
> > > > > > Hi Pali,
> > > > > >
> > > > > > On Thu, Dec 12, 2019 at 7:31 PM Pali Rohár <pali.rohar@gmail.com> wrote:
> > > > > > >
> > > > > > > Hello!
> > > > > > >
> > > > > > > According to HSP 1.2 specification, section 4.7 Remote Audio Volume
> > > > > > > Control, Support for remote audio volume control is optional, so an
> > > > > > > implementation may support none, either, or both of the controls for
> > > > > > > microphone volume and speaker volume.
> > > > > > >
> > > > > > > According to HSP 1.2 specification, section 5.3 SDP Interoperability
> > > > > > > Requirements, bluetooth device with HSP profile announce via SDP "Remote
> > > > > > > audio volume control" field information if device itself supports volume
> > > > > > > control.
> > > > > > >
> > > > > > > But currently I did not found any way how to access "Remote audio volume
> > > > > > > control" SDP field in (pulseaudio) application as bluez does not export
> > > > > > > it.
> > > > > > >
> > > > > > > Can you please export this field? E.g. for HFP profile all optional
> > > > > > > features from SDP are passed to NewConnection() DBus method via
> > > > > > > fd_properties dictionary under Features key. Could you export that
> > > > > > > "Remote audio volume control" bit for HSP profile in Features key?
> > > > > > >
> > > > > > > And in same way, this needs to be handled also in RegisterProfile() DBus
> > > > > > > method.
> > > > > >
> > > > > > Do you have a use case in mind?
> > > > >
> > > > > Yes, checking in pulseaudio if remote side announce that supports remote
> > > > > volume control or not. And based on this switch to software volume
> > > > > level.
> > > >
> > > > Hello Luiz! Is it is possible to export this field?
> > >
> > > Hello, I have not got any answer to my question.
> > >
> > > So may I ask again how to retrieve SDP attribute 0x0302 "Remote audio
> > > volume control" for a remote bluetooth headset with HSP profile?
> > >
> > > It is really important as this attribute says if remote bluetooth
> > > headset supports volume control or not. In case it does not support, we
> > > need to switch to software volume control on host side.
> > >
> > > There is open pulseaudio bug that on some headsets it is not possible to
> > > control volume level and therefore pulseaudio needs to switch to
> > > software volume control.
> > >
> > > But without checking this SDP attribute 0x0302 this is not possible.
> > 
> > Not sure when I will have time to work on this one, btw can't you
> > actually detect this via some AT command, or the headset simple don't
> > respond to the AT command for volume control?

Hello Luiz! Headsets really do not respond to VGS and VGM command. Well
in direction from computer to headset it is not an AT command but
Unsolicited result code for which there is no reply.

So it is not possible to detect it as there is no AT command for it.

AT commands are sent in opposite direction, from headset to computer.
But in this case we want to change volume from computer to headset and
for it there is only "Unsolicited result code" which is without
response.

> Hello Luiz! I'm planing to add some "workaround" by detecting what
> happen when VGS or VGM commands are sent. But this is just a workaround
> and I would like to know how would proper solution would like.
> 
> Does it mean that currently it is really not possible to retrieve SDP
> attributes of remote device? And we need to wait until bluez daemon
> exports it via DBus API (fd_properties dictionary under Features key)?
> 

-- 
Pali Rohár
pali.rohar@gmail.com
