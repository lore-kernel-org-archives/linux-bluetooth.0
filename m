Return-Path: <SRS0=gL6M=UJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C61C282DD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jun 2019 12:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BBC720679
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jun 2019 12:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvYOR2Yw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389313AbfFJMfX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Jun 2019 08:35:23 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34687 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389373AbfFJMfW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Jun 2019 08:35:22 -0400
Received: by mail-wm1-f67.google.com with SMTP id w9so8940073wmd.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jun 2019 05:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Sbn/8+5QyKIK6ySC7nDI++0T2ueY/TsYg3uPmygMp0Q=;
        b=kvYOR2YwG7zj3JF8eL4Au9oFOgU2DWE3FlmlNM+qOPbIBQZbp9MkOYCTQQHkvAAS3/
         SM6GFDoblWxz2ruAQHkGPbdifvY23jXvJRO1yAu6NO/7+DFF9Li4tRM9lmu95+nko4Zf
         zVgUt5Xo9OF+OUKx39MCIFK1WzCiNPxOnXnObq8uQdsHoMCd7lMjyJX0jGeU8z/7aHYN
         nBwTyAgRkZiOnpm2rHQEnXz8ax4ygcIadtJnMoBcOXeLuAtAopEApcT2ot7BkoEf8wjl
         GzShWzyOOhQP5h1vo+QPs6kRdYFPp5MD6T/3RXWD+3EDyf/e3ROY3kYo9sSGG4PZB+mc
         eyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Sbn/8+5QyKIK6ySC7nDI++0T2ueY/TsYg3uPmygMp0Q=;
        b=fZtPhqhd26YXeO//q1xliFn9qvygsF/CIKxYowLlSd8HX1wsJSTtTJLzckAl55YOXU
         B13YvjsyCtmMJIU1DrZV2OXGOwqniGRbz9XmUyxKfhwKaY3TMnHsQW2/iWYTPlSv+WyX
         eAtQAuFht17dUOaz7Ir7CGr8lPoVnjjDzHmuD+NKQMregv1GJPD6gB8zaH9T5p0AGNjc
         c8dB6n2O/0jQpcpeysvFHZy7HZO/HJj/DaXvYb0pOIJCEERTRgDG2eM8QnMqL8XUj9q9
         VAaYQyFcHZuJIao4l6LdaQ2k1MU0Elb5teEaQGQ65AW3d8l5tH8UNGLUX51voo28bWy1
         0LoQ==
X-Gm-Message-State: APjAAAXeSFb6Bb+HQR+8Q/T9dxuH3btnRPOaUgx+vNm+2rekhZ3CxS8B
        V+QyVN2hDq+Er0n/Vyv19IM=
X-Google-Smtp-Source: APXvYqz++z5W/73ny0ZIKO31Fv38pwiOEoZkc6EytmEPhBhEDTJKjHP4QggdnllgoV9D6RbK20VP5w==
X-Received: by 2002:a1c:4d6:: with SMTP id 205mr12288575wme.148.1560170119773;
        Mon, 10 Jun 2019 05:35:19 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id v15sm10622961wrt.25.2019.06.10.05.35.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 05:35:19 -0700 (PDT)
Date:   Mon, 10 Jun 2019 14:35:18 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3 6/6] a2dp: Reword LastUsed
Message-ID: <20190610123518.iytoko5ep7iwk7fw@pali>
References: <20190506124310.19151-1-luiz.dentz@gmail.com>
 <20190506124310.19151-6-luiz.dentz@gmail.com>
 <CABBYNZJ4+Be+sAXVAL_96qov5Go3BpRwmJtkdOVXC4apfL2K9A@mail.gmail.com>
 <20190506130225.smlwgw5cgvhdb35v@pali>
 <20190507085255.zplj5ddopl3z5n2v@pali>
 <CABBYNZJz1jXF6DtTerwZz4cpKYpzDP7TyO1fjnYTyEJ026M3LQ@mail.gmail.com>
 <20190507185740.ywubjwgm7mer7txf@pali>
 <20190607130434.lw5vfapnkflp65cq@pali>
 <CABBYNZJyviu4CRjS616nakNkGZjQkwDto8=pmWdX8TFiNCD05Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZJyviu4CRjS616nakNkGZjQkwDto8=pmWdX8TFiNCD05Q@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Friday 07 June 2019 18:18:04 Luiz Augusto von Dentz wrote:
> Hi Pali,
> 
> On Fri, Jun 7, 2019 at 4:04 PM Pali Rohár <pali.rohar@gmail.com> wrote:
> >
> > On Tuesday 07 May 2019 20:57:40 Pali Rohár wrote:
> > > On Tuesday 07 May 2019 13:13:17 Luiz Augusto von Dentz wrote:
> > > > Hi Pali,
> > > >
> > > > On Tue, May 7, 2019 at 11:52 AM Pali Rohár <pali.rohar@gmail.com> wrote:
> > > > >
> > > > > On Monday 06 May 2019 15:02:25 Pali Rohár wrote:
> > > > > > On Monday 06 May 2019 15:46:03 Luiz Augusto von Dentz wrote:
> > > > > > > Hi Pali,
> > > > > > >
> > > > > > > I hope this fixes the problems you have been seeing, it should at
> > > > > > > least take care of the issues with wrong order of SelectConfiguration
> > > > > > > and restoring the exact same endpoint used last time.
> > > > > >
> > > > > > Hi Luiz! Great, this should make bluez to be more deterministic.
> > > > >
> > > > > Hi! Now I looked at it and in cache file I see:
> > > > >
> > > > > LastUsed=04:01
> > > > >
> > > > > What would happen when A2DP application (e.g. pulseaudio) register DBus
> > > > > endpoints in different order? Or e.g. do not register some endpoints due
> > > > > to missing codec librayr (aptX).
> > > > >
> > > > > I guess that in this case LastUsed information stops working...
> > > >
> > > > It would most likely fail at SelectConfiguration and then try with the
> > > > other endpoints.
> > >
> > > Yes, that is truth. My point is just about validity of LastUsed value.
> > >
> > > > >
> > > > > Should not be there stored rather dbus endpoint name identifier?
> > > >
> > > > Originally I tried to avoid having the local endpoints because of this
> > > > problem, but now that SelectConfiguration can fail it shouldn't really
> > > > be a problem. At least with the seid if you have a system that didn't
> > > > changed the order or number of endpoints it will keep working as
> > > > expected,
> > >
> > > But this may happen. And such thing is allowed. Any application,
> > > including unprivileged can register own new endpoint to bluez. It is not
> > > specific to pulseaudio. And in my opinion central bluetooth daemon which
> > > expose such functionality should be robust and be prepared that
> > > application on "other side of dbus IPC" does not have to be well
> > > behaved.
> > >
> > > > if we choose to encode the D-Bus connection, etc, as soon as
> > > > PA is restarted, the system is rebooted, etc, the D-Bus connection may
> > > > have changed making the stored values in LastUsed invalid.
> > >
> > > That is truth.
> > >
> > > My idea was to encode just dbus path of local dbus endpoint. We can say
> > > (in IPC API) that client application should preserve dbus path for one
> > > same endpoint between dbus daemon / computer restarts. Because otherwise
> > > functionality of "choose last used endpoint" would not work.
> > >
> > > This is less strict requirement and current one (that registration order
> > > of all existing applications in system must be same across reboots),
> > > less error prone and still should be easily implemented.
> >
> > So what about this my idea? Is there anything wrong with such thing?
> 
> That makes the assumption that the path doesn't ever change which is
> something we never required for the endpoints, besides can be clashes
> if the same path is used in which case the stored value would be
> ambiguous, so I prefer to just have the endpoint id, if we are so
> eager to detect endpoint changes we can save some hash/unique id
> generated but I think it is a bit overkill if this is working as it
> currently is and we can always fallback if we cannot recover the last
> used, anyway this is not even supported by the spec since it has no
> guarantees regarding peers endpoints uniqueness.

My main objection against endpoint id is that it is less stable then
application dbus path. Endpoint id depends on ordering which is defined
by all application which registers to dbus. And so it does not depend on
application itself. On the other hand endpoint dbus path is fully under
application control, so independently of other applications, dbus path
can be stable -- if application make it stable.

> > > > Anyway
> > > > chances are the LastUsed is only invalidated if you update PA, in
> > >
> > > Or once we include support for dynamic codec loading (based on encoder
> > > library presence in system), installation of any irrelevant application
> > > may bring a new supported codec and therefore a new endpoint. So codecs
> > > can become in any order...
> > >
> > > Or another example, when different application (not PA) register also
> > > some endpoint.
> > >
> > > > which case there could be new endpoints or a change in their order and
> > > > package can also provide a script to clear the LastUsed if that
> > > > happens, but then again LastUsed setting does not actually store the
> > > > configuration just the endpoint so SelectConfiguration has control
> > > > over the configuration.
> > >
> > > Yes, whole thing is only about initial codec selection. In the worst
> > > case user would have pre-selected different codec as which was last
> > > used.
> > >
> > > But I think that storing dbus path of endpoint as described above should
> > > be more reliable solution.
> > >
> > > Applications (e.g. PA) talking to bluetooth daemon does not register or
> > > request directly SEID. Instead they register their dbus path and dbus
> > > connection and bluetooth daemon later allocates SEID for that path.
> > >
> >
> > --
> > Pali Rohár
> > pali.rohar@gmail.com

-- 
Pali Rohár
pali.rohar@gmail.com
