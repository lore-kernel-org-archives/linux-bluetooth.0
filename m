Return-Path: <SRS0=CLw3=RR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F15C43381
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Mar 2019 07:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C003E217F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Mar 2019 07:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXd2lLkd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfCNHlI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Mar 2019 03:41:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38784 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfCNHlH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Mar 2019 03:41:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id n125so3264899pfn.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Mar 2019 00:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ru3B0FsREg8yMW/nkAU0LSCHIRGudbT97YYMLbvaWdM=;
        b=bXd2lLkd+F6TP1gV+3CI5rh0lxt9MzG2CiFJGVz7bL8kxDy/ZW9ihXXx3by5fPU3iR
         czSP15vZ04c6H1crW81TMnE4JK2XADsSvT3aPtF/OrHpdnbSQyd6eHbJEUdgQl0QQMmT
         XG+uWTJ268ugV+NFbPcKux7r6XXPaUKSVSS/BoYz9lM00yYKEZTfgt3oMM8ahpMVKRZ3
         i4e3v20xqhiZal30HN6WTq9a0Qh1rseIl2KMJHXMNGyNqOSl3PxeDwk5uj6Q/ELaEzRw
         IoIEaGX5l7sLgBJNPpwGSyNfk9gePUPKPr50tcOYa02367aXF/I+0HhP/YpnrpEhuKGo
         9TKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ru3B0FsREg8yMW/nkAU0LSCHIRGudbT97YYMLbvaWdM=;
        b=slZZ2PFpS9qKI6ptF650j+RRB6qvfCGLoAd3GI1lTvITxjF17mYDsZLJ+ckbQ6kt7C
         ro6Ua8HFJUHqro5RtBzPwIeFD1aeDZVR8KUQd8aHxHqyfECMl6XNC+Cw+psNL4+SE2v2
         SkudeFjhsUBA3c+9pW+qHOzPdUHjQ8ynXNCUfbEf0Jlf7D5ospUQS1H7xL9nauEUySBd
         a2p9E5fJcwT2ZT0WhPyL00OoCeKmGr0qnLy/kDyJAqLuao7RX4riEAjuWjxKwW65l8DU
         stlxxwTshhYqZkZdqyiFSsqnDo2/jXGAAUJpuZagL6LVuxrbAk6H6VmWVWMdSfxW2Igs
         yWqA==
X-Gm-Message-State: APjAAAWxMHQJNwwWmMxb5F2buo4jfvpckhRz9o8MJvGwanzM0a/GoxLo
        B1/EXEnObYgOTlDs1yjO9BQ=
X-Google-Smtp-Source: APXvYqzjq0T0FoTq1dij4VpsvRlt1evhiY8nkawnpVR2aryIYv/aZq6B0tEg4gvNjFo/jFhWub4NNQ==
X-Received: by 2002:a17:902:8f81:: with SMTP id z1mr50976937plo.265.1552549266847;
        Thu, 14 Mar 2019 00:41:06 -0700 (PDT)
Received: from flarsson-mobl2.ger.corp.intel.com ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id u26sm9033020pfh.42.2019.03.14.00.41.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 00:41:05 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH BlueZ] mesh: Add APIs for Provisioner and Config Client
From:   Johan Hedberg <johan.hedberg@gmail.com>
In-Reply-To: <20190313221526.16890-1-brian.gix@intel.com>
Date:   Thu, 14 Mar 2019 09:41:01 +0200
Cc:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Von Dentz <luiz.dentz@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C54E4ABE-6257-486E-965C-EAA5F13F3402@gmail.com>
References: <20190313221526.16890-1-brian.gix@intel.com>
To:     Brian Gix <brian.gix@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On 14 Mar 2019, at 0.15, Brian Gix <brian.gix@intel.com> wrote:
> +	uint64 token, array{byte}[16] device_key
> +			CreateNetwork(object app_root, array{byte}[16] =
uuid,
> +			array{byte}[16] net_key)
> +		This is the first method that an application calls to =
become

Minor: please be consistent with keeping an empty line between the =
function signature and its description. There are a few more places in =
this document with the same issue (which I won=E2=80=99t point out =
separately).

> +	array{byte} DecryptWithDeviceKey(array{byte}[16] key,
> +			array{byte}[13] nonce, array{byte} =
encrypted_data)

It seems inefficient to have a design requiring this kind of roundtrips =
between mesh and the application. Why can=E2=80=99t we have meshd manage =
the device key for remote devices (and also keep track of which =
application has access to them)? IMO we should keep the persistent =
storage requirements of the application to the bare minimum and put that =
burden mostly on the meshd side.

> +Mesh Provisioning Hierarchy
> +	void AddNode(array{byte}[16] uuid)

Wouldn=E2=80=99t =E2=80=9CProvision=E2=80=9D be a more matching name for =
this method?

> +Mesh Provisioner Hierarchy
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +Service		unique name
> +Interface	org.bluez.mesh.Provisioner1
> +Object path	freely definable
> +
> +	int8 rssi, array{byte} data ScanResult()

This looks backward - shouldn=E2=80=99t the parameters be input =
parameters and not return parameters? As return parameters this method =
doesn=E2=80=99t make any sense to me.

> +	void AddNodeComplete(array{byte}[16] uuid, uint16 unicast, uint8 =
count)

This would be ProvisioningComplete if you follow my earlier naming =
suggestion.

> +	void AddNodeFailed(array{byte}[16] uuid, string reason)

And ProvisioningFailed here.

Johan=
