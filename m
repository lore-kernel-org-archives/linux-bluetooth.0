Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3ECEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 May 2022 22:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiEWW2h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 May 2022 18:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiEWW2g (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 May 2022 18:28:36 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BAF7DE2F
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 May 2022 15:28:35 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id nk9-20020a17090b194900b001df2fcdc165so506894pjb.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 May 2022 15:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=4tgSXRbyfiUubChzxKJ/M2AvX5PKjAuiVPNHMDuyWXw=;
        b=e+6YtQY0D4EK7ncPkoQz0e8eDExV7q7Dij+wzTBC6cF1jYh9Q9/+TuoDJLvK4ENi/Z
         arHeXQ4MSyMdxmnLDqdnKx81wuqNA+MKIbjwyQi4+xFwGsAX1iYIIyKZTQl5bLL8timn
         uUufAEIumEI5AkZkrEl0ic6K6QSEmG+yQvsjLDspux5WhW/0Ne1PrG1F47a9RchJLPfU
         f+uVNuOy6TjqjZEHrZe0a36BVJmIO+Tma/AlT4VW987QmU/u9gRbvdRCZiEdrdfziH7A
         zJw4bvrgAnn1SQB1uyrZZWC+4BL69yy/HB2LWK9UMvdn0GtS4Vi941jiFQXOFsw51Jb1
         1eDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=4tgSXRbyfiUubChzxKJ/M2AvX5PKjAuiVPNHMDuyWXw=;
        b=6oePWYwxI60ZC/G/eY8+zodqh7Ah0W8GyCeCArconNepcWTczmWQFa3XNLiZCrzn+q
         ZPXwMoMsUG1J+VZPUuLMlQK88FhS/AjcIIBKuCemdodfAWOhWC2KeOlNyQn0NKg9Pn9a
         vWAyaFVf1YA9N7b2QL8UpTkGEnTqbzBxVXsA8s9zNdvbM7GEERPqiDSoRQbmsVA+f5q6
         FifAKJ4EIM9z1PcuIWUGPQw+Kmb2QOz6XqzLdY2NkYYKwalOYrNiKPhIENMimstOQUSm
         dWJVVT02UkOwpKceGqs1XoRVv4Qujao/DRtA0e9IRGuCPAAt9ARM/pbQcjujgWNDN9Vf
         zLhg==
X-Gm-Message-State: AOAM5320YQcBgvi6f21oMlmKcfgPTBvcxcNxiocMqMCkAgACZ9Z4bI2v
        x0aYQ721n16QMjAP34FpAxN2jQ==
X-Google-Smtp-Source: ABdhPJzDrkMUqcEevYwEWyIVnPaERz3SkIUv7jA+udrj1/wZS9YzxSQpMoJDYS+slMKsrHcMmwqOLw==
X-Received: by 2002:a17:90b:17c6:b0:1e0:28bf:d429 with SMTP id me6-20020a17090b17c600b001e028bfd429mr1201566pjb.239.1653344914766;
        Mon, 23 May 2022 15:28:34 -0700 (PDT)
Received: from hermes.local (204-195-112-199.wavecable.com. [204.195.112.199])
        by smtp.gmail.com with ESMTPSA id o62-20020a62cd41000000b0051850716942sm7899743pfg.140.2022.05.23.15.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 15:28:34 -0700 (PDT)
Date:   Mon, 23 May 2022 15:28:32 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Fw: [Bug 216018] New: Bluetooth: strlen in append_eir_data_to_buf
 causes calling process to freeze when short/longname does not have double
 NUL termination.
Message-ID: <20220523152832.199b93bf@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org



Begin forwarded message:

Date: Mon, 23 May 2022 15:32:38 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 216018] New: Bluetooth: strlen in append_eir_data_to_buf causes calling process to freeze when short/longname does not have double NUL termination.


https://bugzilla.kernel.org/show_bug.cgi?id=216018

            Bug ID: 216018
           Summary: Bluetooth: strlen in append_eir_data_to_buf causes
                    calling process to freeze when short/longname does not
                    have double NUL termination.
           Product: Networking
           Version: 2.5
    Kernel Version: 5.17.6-1-MANJARO #1
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: tomu1@verifone.com
        Regression: No

Created attachment 301019
  --> https://bugzilla.kernel.org/attachment.cgi?id=301019&action=edit  
Program to cause strlen Kernel Bug

The process I use to set the bluetooth short/longname via HCI freezes with a
kernel bug.
I have investigated this problem and have possibly found the issue.

When writing the bluetooth localname to the kernel via HCI, the userspace is
required to
write the command to the HCI socket in the following way
(https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/mgmt-api.txt):


"
Command Code:           0x000F
        Controller Index:       <controller id>
        Command Parameters:     Name (249 Octets)
                                Short_Name (11 Octets)
        Return Parameters:      Name (249 Octets)
                                Short_Name (11 Octets))

[...]

The values of name and short name will be remembered when
        switching the controller off and back on again. So the name
        and short name only have to be set once when a new controller
        is found and will stay until removed.                           
"

It is requested that both Name and Short_Name are zero terminated.

When this command is sent via the HCI socket eventually set_local_name is
called in the kernel:

static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
                          u16 len)
{
        struct mgmt_cp_set_local_name *cp = data;

The structures which are important here are hci_dev and mgmt_cp_set_local_name:

struct hci_dev (excerpt):
The relevant struct is defined as such:
        __u8            dev_name[HCI_MAX_NAME_LENGTH];
        __u8            short_name[HCI_MAX_SHORT_NAME_LENGTH];

The length macros are defined as such:
#define HCI_MAX_NAME_LENGTH             248
#define HCI_MAX_SHORT_NAME_LENGTH       10

struct mgmt_cp_set_local_name {
        __u8    name[MGMT_MAX_NAME_LENGTH];
        __u8    short_name[MGMT_MAX_SHORT_NAME_LENGTH];
} __packed;

Its length macros are the following:

/* Reserve one extra byte for names in management messages so that they
 * are always guaranteed to be nul-terminated */
#define MGMT_MAX_NAME_LENGTH            (HCI_MAX_NAME_LENGTH + 1)
#define MGMT_MAX_SHORT_NAME_LENGTH      (HCI_MAX_SHORT_NAME_LENGTH + 1)

When set_local_name (net/bluetooth/mgmt.c) is called an memcpy is used to
transfer
the names:

memcpy(hdev->short_name, cp->short_name, sizeof(hdev->short_name));
if (!hdev_is_powered(hdev)) {
                memcpy(hdev->dev_name, cp->name, sizeof(hdev->dev_name));

This would not be a problem in of itself,
however when ext_info_changed is called in the same function (and possibly
elsewhere), it internally uses append_eir_data_to_buf, which uses 
strlen to determine the length of the device/shortname:

static u16 append_eir_data_to_buf(struct hci_dev *hdev, u8 *eir)
...
name_len = strlen(hdev->dev_name);
....
name_len = strlen(hdev->short_name);

As such, when the userspace gives a name which does not have 2 NUL bytes
at the end of long(dev)name and shortname, then the strlen will search
over the size of the buffer, as internal structure does not have a NUL
byte, which, sadly, causes my started hci process
to completely freeze (unrecoverable) due to kernel hardening
kicking in.

An easy wasy to reproduce this issue is by executing the attached program.
Please note blueZ and all of these Bluetooth grabbing services need to be
disabled and the controller itself must be powered off.

A temporary workaround is to terminate the sent names with two NUL
bytes.

It would be very kind of you to take a look at this issue.

Thank you for your time,
Tom Unbehau

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.
