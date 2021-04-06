Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1949C433ED
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Apr 2021 08:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79C03613C0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Apr 2021 08:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbhDFIBI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Apr 2021 04:01:08 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:40858 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbhDFIBH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Apr 2021 04:01:07 -0400
Received: from mac-pro.holtmann.net (p4ff9fed5.dip0.t-ipconnect.de [79.249.254.213])
        by mail.holtmann.org (Postfix) with ESMTPSA id 81144CED1C;
        Tue,  6 Apr 2021 10:08:39 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [Bluez PATCH] btmgmt: Add support to enable LL privacy
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZLTU1t=UEsvxsu8F0kP8f5-Nvi_Xysy8ftg57j9Snu99w@mail.gmail.com>
Date:   Tue, 6 Apr 2021 10:00:56 +0200
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <588F99C8-E5B4-47D3-84C3-72F9E6FCC9EC@holtmann.org>
References: <20210405145802.27317-1-sathish.narasimman@intel.com>
 <CABBYNZLTU1t=UEsvxsu8F0kP8f5-Nvi_Xysy8ftg57j9Snu99w@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>> If the Bluetooth controller supports LL privacy this command will be
>> used to test the same.
>> "sudo btmgmt power off"
>> "sudo btmgmt llprivacy on"
>> "sudo btmgmt power on"
>> 
>> Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
>> ---
>> tools/btmgmt.c | 38 ++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 38 insertions(+)
>> 
>> diff --git a/tools/btmgmt.c b/tools/btmgmt.c
>> index 93d244ff8ec8..4a53c3768fe9 100644
>> --- a/tools/btmgmt.c
>> +++ b/tools/btmgmt.c
>> @@ -2261,6 +2261,42 @@ static void cmd_bredr(int argc, char **argv)
>>        cmd_setting(MGMT_OP_SET_BREDR, argc, argv);
>> }
>> 
>> +static void ll_rpa_resoln_rsp(uint8_t status, uint16_t len, const void *param,
>> +                             void *user_data)
>> +{
>> +       if (status != 0)
>> +               error("Could not set LL RPA resolution with status 0x%02x (%s)",
>> +                     status, mgmt_errstr(status));
>> +       else
>> +               print("LL RPA Resolution successfully set");
>> +
>> +       bt_shell_noninteractive_quit(EXIT_SUCCESS);
>> +}
>> +
>> +static void cmd_set_ll_rpa_resoln(int argc, char **argv)
>> +{
>> +       /* 15c0a148-c273-11ea-b3de-0242ac130004 */
>> +       static const uint8_t rpa_resolution_uuid[16] = {
>> +                               0x04, 0x00, 0x13, 0xac, 0x42, 0x02, 0xde, 0xb3,
>> +                               0xea, 0x11, 0x73, 0xc2, 0x48, 0xa1, 0xc0, 0x15,
>> +       };
>> +       struct mgmt_cp_set_exp_feature cp;
>> +       uint16_t index;
>> +
>> +       memset(&cp, 0, sizeof(cp));
>> +       memcpy(cp.uuid, rpa_resolution_uuid, 16);
>> +
>> +       index = mgmt_index;
>> +       if (index == MGMT_INDEX_NONE)
>> +               index = 0;
>> +
>> +       if (parse_setting(argc, argv, &cp.action) == false)
>> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
>> +
>> +       mgmt_send(mgmt, MGMT_OP_SET_EXP_FEATURE, index,
>> +                 sizeof(cp), &cp, ll_rpa_resoln_rsp, NULL, NULL);
>> +}
>> +
>> static void cmd_privacy(int argc, char **argv)
>> {
>>        struct mgmt_cp_set_privacy cp;
>> @@ -5243,6 +5279,8 @@ static const struct bt_shell_menu main_menu = {
>>                cmd_bredr,              "Toggle BR/EDR support",        },
>>        { "privacy",            "<on/off>",
>>                cmd_privacy,            "Toggle privacy support"        },
>> +       { "llprivacy",          "<on/off>",
>> +               cmd_set_ll_rpa_resoln,  "Toggle LL privacy support"     },
> 
> Let's have it as a parameter of privacy command <on/off/ll> so when a
> user enters ll it enables link-layer privacy.

please don’t. The privacy setting means that we start using RPAs.

Also what is wrong with exp-privacy command that I already added.

Regards

Marcel

