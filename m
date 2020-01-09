Return-Path: <SRS0=NtgA=26=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1CFC32771
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jan 2020 08:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D00B206ED
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jan 2020 08:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="W0TtAq36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgAIIjC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Jan 2020 03:39:02 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:44611 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728435AbgAIIjC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Jan 2020 03:39:02 -0500
Received: by mail-lf1-f43.google.com with SMTP id v201so4538643lfa.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jan 2020 00:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T8xlvjJZgwyPXo87q2jQsB1sAyOo6QsWZZbOVqbWpZg=;
        b=W0TtAq36nkdOq3KNGRFWfLi3xwUoLPrFRuo1u90Tf8e0jgduOoBVdaHQSImT+/iBW8
         tzsw1Fq6DhcmMkyRCM9J7vR/mq3QVnyu0bnz7pcnJ7o3GTaeo3I3gvo2z7l9uUafiRmS
         K/95cusb9wHh/h2177s64QIW/ugfY3eyvvY5E+LQ7O2rNRl8i9/wVdS/dqZp4nW4Onta
         Jr0lR8ACGYgszCY+k/ixuKC/9B4UkTGyUwi1lx63yreyDig8GCUa5LeqzT5CBkmkEp7c
         LnHxqTVG0KxtaxsMuakzZD0yoOGiFlLSfOGcIY/dACq+STc5JxK01EhdfhsQYHl7ZYFi
         Fe3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T8xlvjJZgwyPXo87q2jQsB1sAyOo6QsWZZbOVqbWpZg=;
        b=r5zI7wI6Q875hT+BeOKkfyrhb2moTHK+f3wtqIgan5zjTFoRQ2tWzv3qMbmpBiuPBr
         g95RDqdvAVMBfxi6bOo3FR54N8hhZ/RYsBQHvQQr+dqux6iQiDWRC4Oxy26ec9d1iOs7
         r3BTkm0onB02gmCAyvJ5s9gUKpU2FDkpQKIHi9mvyfCI1s9n3jf48M2WeNYU+i3Xm/sW
         jEYsjuwrBxmv9t5DrCtgOSZs0KCcSWafkwVZK1mVPBEdkfMYleHcFbLNc1hcrTgASCuK
         bwDtv/t8Hsn5ENRueCow/RFNH1ADozhwA//s965Uiraxw9cRYSvo00b5vQckB5PyLzLj
         Uefw==
X-Gm-Message-State: APjAAAXemyGs+moRnnikCcn1v3PkjKavSiaZ4PSzh2pxXaxqe+03ZSTU
        HTnPz5CSMAG/H+/Xk44Pj9tgnGO3p50=
X-Google-Smtp-Source: APXvYqxFx43uBlD9merM8t1vHhOf90cU2qe0NRHlW/2WR1ViOGtLA/QTTuI66gPx7pq3ocozGaa2RQ==
X-Received: by 2002:ac2:5088:: with SMTP id f8mr5531884lfm.163.1578559140140;
        Thu, 09 Jan 2020 00:39:00 -0800 (PST)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id b22sm2930456lji.99.2020.01.09.00.38.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 00:38:59 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 0/2] Fix types and names of beacon/import flags.
Date:   Thu,  9 Jan 2020 09:38:53 +0100
Message-Id: <20200109083855.16000-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patchset aims to make the API a bit more consistent.

Side question: at the moment none of the node properties emit
PropertiesChanged signal. I think this violates D-Bus spec, since all
properties are assumed to emit these signals by default [1] [2].

Unfortunately, at the moment ELL does not support "EmitsChangedSignal"
annotation, so I'd like to add this to ELL, annotate node
properties with:
    - Features: const
    - Beacon: true
    - BeaconFlags: true
    - IvIndex: true
    - SecondsSinceLastHeard: false (for performance reasons)
    - Addresses: const

And also emit PropertiesChanged where required.

Thoughts?


[1] https://dbus.freedesktop.org/doc/dbus-specification.html#standard-interfaces-properties

    Each property (or the parent interface) must be annotated with the
    org.freedesktop.DBus.Property.EmitsChangedSignal annotation to
    convey this (usually the default value true is sufficient meaning
    that the annotation does not need to be used). See the section
    called “Introspection Data Format” for details on this annotation.

[2] https://dbus.freedesktop.org/doc/dbus-specification.html#introspection-format

    org.freedesktop.DBus.Property.EmitsChangedSignal:
        true,invalidates,const,false	

    If set to false, the
    org.freedesktop.DBus.Properties.PropertiesChanged signal, see the
    section called “org.freedesktop.DBus.Properties” is not guaranteed
    to be emitted if the property changes.

    If set to const the property never changes value during the lifetime
    of the object it belongs to, and hence the signal is never emitted
    for it.

    If set to invalidates the signal is emitted but the value is not
    included in the signal.

    If set to true the signal is emitted with the value included.

    The value for the annotation defaults to true if the enclosing
    interface element does not specify the annotation. Otherwise it
    defaults to the value specified in the enclosing interface element.

    This annotation is intended to be used by code generators to
    implement client-side caching of property values. For all properties
    for which the annotation is set to const, invalidates or true the
    client may unconditionally cache the values as the properties don't
    change or notifications are generated for them if they do.

Michał Lowas-Rzechonek (2):
  mesh: Rename IVUpdate import flag to IvUpdate
  mesh: Change BeaconFlags property type to a dict

 doc/mesh-api.txt | 20 +++++++++++++++-----
 mesh/mesh.c      |  2 +-
 mesh/node.c      | 13 +++++++++++--
 3 files changed, 27 insertions(+), 8 deletions(-)

-- 
2.19.1

