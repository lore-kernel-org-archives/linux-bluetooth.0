Return-Path: <SRS0=erFC=OG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7133C43441
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Nov 2018 21:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ECE3208E4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Nov 2018 21:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8brNMUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ECE3208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbeK1ISd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Nov 2018 03:18:33 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44830 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeK1ISd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Nov 2018 03:18:33 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so17684686lfe.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Nov 2018 13:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WzDCG80SAL/hczcxkWBHg+kV0y8RtZFNkQb7UBQicW0=;
        b=K8brNMUMcjokTr9fuINVjicRrDU8w2VUaqY5Q8+23u1D/steaO6z7QqmthiD4Uphta
         PUrCYpg+MYaIXDkFQUHbA2KhgucYQIBbE/EbtNWBvPPwlyYX3iPahknOBjbuwCJstfZ8
         vqhDg0fUauoJBYKjPhFdAsJcMbwCEwJMTwvzBBc+Q9g3VVQ/NTIexQesMzOq4GRKPlq2
         dvtkvAkw3KTRmd3B709fGK4vOesoDTwoRTdpBFpeGJ9wlQiIgRVYHq8yMQQIQV+IT9CR
         9pGB9ujmgmUL3yniyl20Sg/lbTe62L3J59RyFSIP9dT2pDDLKHfxEUAp+KvyDN4H4mWF
         9Zeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WzDCG80SAL/hczcxkWBHg+kV0y8RtZFNkQb7UBQicW0=;
        b=co9MnEuUBRAs6kAP+RJWTehKfZs55NBpz+aj12J1I9QuGZSD3FRvZUn67LR6BVQgQn
         E6STFvLP5Jdy6EqDHdDaDC+G15rfKQWNHnEf9kLEz0rhK+D1jsIIM7yEiOs5aScqQEQr
         jLipiesvZ+LO9Er2FnnSPqnQvvbniT182TZm1DdEJecVomzL4KDa7ds66D7l5Q6HHx6Q
         cumdn+Fsv1oWijU+f+xDz8zhJjDwqLSDOg/XqV+zjO+HxugiqrZ9ICHsl2JgwzdaBrnI
         0pf2y5H7nUcPQKk7z9sMLNv4570mY0mF0/RoH7VuzlRg/Mq1QgsorO6aQWj9X+wmOClJ
         JbLw==
X-Gm-Message-State: AA+aEWYk1/Pqdk0gwc32w4YKQZfzN11zl6CoTpwuQmaHwjowTJkVOtzi
        qlzcccvpwtS56Wd6K30X3RA=
X-Google-Smtp-Source: AFSGD/VXaTFsH1Pw/qO8uGkMDQvnODHJdAu8bqrRDzEk91t6XPqdFYmtnv1ipC5Pk3xHhEJ/bP84Rw==
X-Received: by 2002:a19:6806:: with SMTP id d6mr4790114lfc.48.1543353559124;
        Tue, 27 Nov 2018 13:19:19 -0800 (PST)
Received: from jhedberg-mac01.home (91-154-113-38.elisa-laajakaista.fi. [91.154.113.38])
        by smtp.gmail.com with ESMTPSA id y23-v6sm775574ljk.95.2018.11.27.13.19.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 13:19:18 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH 1/1 v2] Bluetooth: make the balance of judgement condition
 to fix a false report
From:   Johan Hedberg <johan.hedberg@gmail.com>
In-Reply-To: <1704c39f-c005-d0cc-9bab-c21e537a07be@gmail.com>
Date:   Tue, 27 Nov 2018 23:19:14 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <566C2A3E-8924-455C-93B1-B514A4CB0511@gmail.com>
References: <5A23C871-B30F-44C4-898B-C138EFDB4893@holtmann.org>
 <1542245517-150977-1-git-send-email-zumeng.chen@gmail.com>
 <00BD5234-6645-4E40-9B3C-859C147EEB7C@gmail.com>
 <3D63F92F-1BA5-415D-AED4-A38FB2E29C00@gmail.com>
 <1704c39f-c005-d0cc-9bab-c21e537a07be@gmail.com>
To:     Zumeng Chen <zumeng.chen@gmail.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Zumeng,


> On 27 Nov 2018, at 14.22, Zumeng Chen <zumeng.chen@gmail.com> wrote:
> There is a related kernel as shown in the below list
>=20
> https://bugzilla.kernel.org/show_bug.cgi?id=3D198699
>=20
> I didn't think my patch is to fix this one because I think we need to =
sort out
> the whole logic of CMD_COMPLETE. But my patch is good to fix the issue
> described by subject.

I=E2=80=99m still failing to see any major problem with command complete =
handling. This seems more related to sending HCI commands that do not =
complete in Command Complete (such as Inquiry or connection creation) =
through the hci_request framework together with hci_req_run_skb(). This =
could either happen by directly using the hci_req_sync() API, such as in =
the case of the legacy inquiry ioctl, or by some code using =
hci_cmd_sync() to send a command that does not complete in Command =
Complete. In these cases you end up with a Command Status with status =3D=3D=
 0, which the hci_request code interprets as completion of the request, =
but is unable to fetch any return parameters from it (which for these =
cases is fine).

Since what I've describe above is normal usage of the hci_req_sync() and =
hci_cmd_sync() APIs I still don=E2=80=99t see any other issue except =
that an error log was thrown rather than than (at most) a debug log. So =
I=E2=80=99d still go for the patch that I submitted earlier today.

Johan=
