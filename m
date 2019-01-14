Return-Path: <SRS0=wTsk=PW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D33AC43387
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jan 2019 15:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8FB2087E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jan 2019 15:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfANPWH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:22:07 -0500
Received: from gangsto.cz ([213.239.215.77]:57962 "EHLO zimbra.gangsto.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbfANPWH (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Jan 2019 10:22:07 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.gangsto.cz (Postfix) with ESMTP id 865758357C
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jan 2019 16:22:05 +0100 (CET)
Received: from zimbra.gangsto.cz ([127.0.0.1])
        by localhost (zimbra.gangsto.cz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Jx-lPTqw3NjY for <linux-bluetooth@vger.kernel.org>;
        Mon, 14 Jan 2019 16:22:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.gangsto.cz (Postfix) with ESMTP id 015D68357D
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jan 2019 16:22:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at gangsto.cz
Received: from zimbra.gangsto.cz ([127.0.0.1])
        by localhost (zimbra.gangsto.cz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1kwFKHPOV3Xo for <linux-bluetooth@vger.kernel.org>;
        Mon, 14 Jan 2019 16:22:04 +0100 (CET)
Received: from zimbra.gangsto.cz (localhost [127.0.0.1])
        by zimbra.gangsto.cz (Postfix) with ESMTP id D080E8357C
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jan 2019 16:22:04 +0100 (CET)
Date:   Mon, 14 Jan 2019 16:22:04 +0100 (CET)
From:   Audun =?utf-8?Q?M=2E_Gangst=C3=B8?= <audun@gangsto.org>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Message-ID: <1512791786.3988.1547479324453.JavaMail.zimbra@gangsto.cz>
In-Reply-To: <756897232.3954.1547478487424.JavaMail.zimbra@gangsto.cz>
References: <756897232.3954.1547478487424.JavaMail.zimbra@gangsto.cz>
Subject: Bash-completion for bluetoothctl
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_3985_1064386150.1547479324451"
X-Originating-IP: [192.168.122.10]
X-Mailer: Zimbra 8.8.9_GA_3019 (ZimbraWebClient - GC71 (Linux)/8.8.9_GA_3019)
Thread-Topic: Bash-completion for bluetoothctl
Thread-Index: 8ba1wqm458v7GZaYSASiKAf46TpAa3FWxLpz
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

------=_Part_3985_1064386150.1547479324451
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,=20

I've made a simple bash-completion script for bluetoothctl.=20

I don't know what to do with it now, but I thought I'd share it in case som=
eone were interested.=20

Use it (or not) as you wish with no restrictions.=20

--=20
Regards,=20
Audun Gangst=C3=B8

------=_Part_3985_1064386150.1547479324451
Content-Type: application/x-shellscript; name=bluetoothctl-bash-completion.sh
Content-Disposition: attachment; filename=bluetoothctl-bash-completion.sh
Content-Transfer-Encoding: base64

X2JsdWV0b290aGN0bCgpCnsKCWxvY2FsIGN1cj0ke0NPTVBfV09SRFNbQ09NUF9DV09SRF19Cgls
b2NhbCBwcmV2PSR7Q09NUF9XT1JEU1tDT01QX0NXT1JELTFdfQoJCgkKCWlmIFtbICIkQ09NUF9D
V09SRCIgPT0gIjEiIF1dOyB0aGVuCgkJIyBQYXJzZSBoZWxwIGZvciBsaXN0IG9mIGNvbW1hbmRz
IGFuZCByZW1vdmUgYW5zaSBjb2xvcnMgKHRoYXQncyB0aGUgdWdseSBzZWQpCgkJQ09NUFJFUExZ
PSggJCggY29tcGdlbiAtVyAiJChibHVldG9vdGhjdGwgaGVscCB8Z3JlcCAnICAnIHwgc2VkICdz
L1x4MUJcW1swLTk7XSpbYS16QS1aXS8vZycgfCAgYXdrICd7cHJpbnQgJDF9JykiIC0tICRjdXIp
KQoJCXJldHVybgoJZmkKCWlmIFtbICIkQ09NUF9DV09SRCIgPT0gIjIiIF1dOyB0aGVuCgkJY2Fz
ZSAiJHByZXYiIGluCgkJCWluZm98cGFpcnx0cnVzdHx1bnRydXN0fGJsb2NrfHVuYmxvY2t8cmVt
b3ZlfGNvbm5lY3R8ZGlzY29ubmVjdCkKCQkJCSMgUmV0dXJuIGEgZGV2aWNlIHRvIGNvbXBsZXRl
CgkJCQlDT01QUkVQTFk9KCAkKCBjb21wZ2VuIC1XIFwKCQkJCQkiJChibHVldG9vdGhjdGwgZGV2
aWNlc3xhd2sgJ3twcmludCAkMn0nKSJcCgkJCQkJLS0gJGN1cikpCgkJCQkJOzsKCQkJc2hvd3xz
ZWxlY3QpCgkJCQkjIFJldHVybiBhIGNvbnRyb2xsZXIgYWRkcmVzcwoJCQkJQ09NUFJFUExZPSgg
JCggY29tcGdlbiAtVyBcCgkJCQkJIiQoYmx1ZXRvb3RoY3RsIGxpc3R8YXdrICd7cHJpbnQgJDJ9
JykiXAoJCQkJCS0tICRjdXIpKQoJCQkJCTs7CgkJCXBvd2VyfHBhaXJhYmxlfGRpc2NvdmVyYWJs
ZXxzY2FuKQoJCQkJQ09NUFJFUExZPSggJCggY29tcGdlbiAtVyAib24gb2ZmIiAtLSAkY3VyKSkK
CQkJCQk7OwoJCQlhZ2VudCkKCQkJCUNPTVBSRVBMWT0oICQoIGNvbXBnZW4gLVcgIm9uIG9mZiBj
YXBhYmlsaXR5IiAtLSAkY3VyKSkKCQkJCTs7CgkJCWFkdmVydGlzZSkKCQkJCUNPTVBSRVBMWT0o
ICQoIGNvbXBnZW4gLVcgIm9uIG9mZiB0eXBlIiAtLSAkY3VyKSkKCQkJCTs7CgkJZXNhYwoJZmkK
CWlmIFtbICR7Q09NUF9XT1JEU1sxXX0gPT0gIm1lbnUiIF1dOyB0aGVuCgkJaWYgW1sgIiRDT01Q
X0NXT1JEIiA9PSAiMiIgXV07IHRoZW4KCQkJIyBMaXN0IG91dCBzdWJtZW51ZXMKCQkJQ09NUFJF
UExZPSggJChjb21wZ2VuIC1XICIkKGJsdWV0b290aGN0bCBoZWxwIHxncmVwICdTdWJtZW51JyB8
IHNlZCAncy9ceDFCXFtbMC05O10qW2EtekEtWl0vL2cnIHwgIGF3ayAne3ByaW50ICQxfScpIiAt
LSAkY3VyKSkKCQkJcmV0dXJuCgkJZmkKCQlpZiBbWyAiJENPTVBfQ1dPUkQiID09ICIzIiBdXTsg
dGhlbgoJCQkjIFBhcnNlIHN1Ym1lbnUgYW5kIHJldHVybiBjb21tYW5kcy4KCQkJQ09NUFJFUExZ
PSggJCggY29tcGdlbiAtVyAiJChibHVldG9vdGhjdGwgbWVudSAkcHJldiB8Z3JlcCAnICAnIHwg
c2VkICdzL1x4MUJcW1swLTk7XSpbYS16QS1aXS8vZycgfCAgYXdrICd7cHJpbnQgJDF9JykiIC0t
ICRjdXIpKQoJCWZpCgkJCQkKCWZpCgkKCQp9Cgpjb21wbGV0ZSAtRiBfYmx1ZXRvb3RoY3RsIGJs
dWV0b290aGN0bAo=
------=_Part_3985_1064386150.1547479324451--
