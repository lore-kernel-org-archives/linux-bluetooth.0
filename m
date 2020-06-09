Return-Path: <SRS0=V72R=7W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25000C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 21:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDE2E20737
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 21:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="n+hLPPcE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgFIVZd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Jun 2020 17:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFIVZc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Jun 2020 17:25:32 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E858C05BD1E
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2020 14:25:32 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id e4so26972659ljn.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2020 14:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oh20Gu011TTYQA4lVRUxSMUTBW0G3IQUbkaHag5Vhb8=;
        b=n+hLPPcEPT7B66fK//yz8872j9i3ByxuvWDur5lklEMfIUmygLZFj115euAlY/q8Oc
         N2+i3ahGwz1XRVO/uajkBGoNgMaPoReIlfMqwtojTsv8Sgek37tH1LbMU+NUTUITi1+Z
         My/Fj8vnMYca1H7Sukx6uFCDuL7a54vRANt5nnpSGy5gbM+rWavZWaIgCUta5Rno8EWJ
         OlTtbcw+Gypld8HebNAhdw3KN5/yOYPpLc9NmuAIDSdZr2JelNxyeFNcppHAMvZEfP8l
         6oPPONgI/GcZMW1POZIpLqxkSOAwCg3fXUMwLrR0fYnSu5jsSnaIw5DmSxV/fAwu9xvv
         D+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oh20Gu011TTYQA4lVRUxSMUTBW0G3IQUbkaHag5Vhb8=;
        b=E0oeOhAzMtcp2Vr8aj4GLrQyVPo7EAp5Er46LR0xpJaJrOB/JNrs2Z/fEVaRtMStDB
         ISEu2JikNcUgynMfgn2ZljPrWfcKsz8bOU57SLRR35iS0UhNNwkRh9EibMuDy6qKMJfa
         OnaWIrUYXLT9S0hJjVzl9+kxpajPMnWkpa5bMh2B3TPGfUHL15B9Ij6eQ/jiIA6Xm0CM
         84PAdy4vLf8FkN8JfgkCsqdlo6aJ3Pr3IRrpE990Eu4RNeX4Ac/fNQDkAgAZ223gi5UC
         eqGYX9WkvC+zT2Y53v9w5aTulhpsuq30RlJL+pLUz0TwK1mPzJtDAPANjn4Hj5BHIk7+
         HCcQ==
X-Gm-Message-State: AOAM532bylyFv+kP3qgPotIgnISDYIHFIJpK/dcs8DIfqhSj1dyulgA3
        SE5wyLlz6q5u5EpX5P/g7FxR+tUu0PVsa7CJ/hcWFw==
X-Google-Smtp-Source: ABdhPJxtiSFiqyqXQUwYB+PnfQ9QsfJvWu/UYL88zyOrOzTp4mV13eFlzcVBgA+TPSfFYH8p9DymnctQ1yIFtf0Ssqk=
X-Received: by 2002:a2e:7006:: with SMTP id l6mr113458ljc.453.1591737931057;
 Tue, 09 Jun 2020 14:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200608180241.BlueZ.v1.1.Ibf8331f6c835d53fe7ca978de962f93981573d9a@changeid>
 <CACumGOKqrBQJzYt_ayW6KRmu9QKCCPYiojdozvGwO3yTR-2Jyg@mail.gmail.com>
In-Reply-To: <CACumGOKqrBQJzYt_ayW6KRmu9QKCCPYiojdozvGwO3yTR-2Jyg@mail.gmail.com>
From:   "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Date:   Tue, 9 Jun 2020 14:25:19 -0700
Message-ID: <CACumGOKyAfdgP6t4PnNBzmVmFayV4b3gPOjux3aGg_de2T104g@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1] adapter: Fix the unref and reset of
 watch_client's members
To:     Miao-chen Chou <mcchou@chromium.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Michael Sun <michaelfsun@google.com>,
        Alain Michaud <alainm@chromium.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,


On Mon, Jun 8, 2020 at 6:11 PM Von Dentz, Luiz <luiz.von.dentz@intel.com> wrote:
>
> Hi Miao,
>
> On Mon, Jun 8, 2020 at 6:03 PM Miao-chen Chou <mcchou@chromium.org> wrote:
>>
>> This properly handles the unref of client->msg in
>> stop_discovery_complete() and the reset of it. This also handles the unref
>> of client->msg, the reset of client->watch and the reset of client->msg in
>> start_discovery_complete().
>>
>> The following test was performed:
>> (1) Intentionally changed the MGMT status other than MGMT_STATUS_SUCCESS
>> in stop_discovery_complete() and start_discovery_complete() and built
>> bluetoothd.
>> (2) In bluetoothctl console, issued scan on/scan off to invoke
>> StartDiscovery and verified that new discovery requests can be processed.
>>
>> Reviewed-by: Alain Michaud <alainm@chromium.org>
>> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
>> ---
>>
>>  src/adapter.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/src/adapter.c b/src/adapter.c
>> index 76acfea70..0857a3115 100644
>> --- a/src/adapter.c
>> +++ b/src/adapter.c
>> @@ -1652,6 +1652,9 @@ fail:
>>                 reply = btd_error_busy(client->msg);
>>                 g_dbus_send_message(dbus_conn, reply);
>>                 g_dbus_remove_watch(dbus_conn, client->watch);
>
>
> We shouldn't be removing the watch directly since the client may have registered filters so we let discovery_remove do it by calling discovery_free if necessary.
>
>>
>> +               client->watch = 0;
>> +               dbus_message_unref(client->msg);
>> +               client->msg = NULL;
>>                 discovery_remove(client, false);
>>                 return;
>>         }
>> @@ -1926,6 +1929,8 @@ static void stop_discovery_complete(uint8_t status, uint16_t length,
>>                 if (client->msg) {
>>                         reply = btd_error_busy(client->msg);
>>                         g_dbus_send_message(dbus_conn, reply);
>> +                       dbus_message_unref(client->msg);
>> +                       client->msg = NULL;
>>                 }
>>                 goto done;
>>         }
>> --
>> 2.26.2
>
>
> Ive sent similar fixes upstream, let me attach them here just in case.

Any comments on these changes, I would like to push them as soon as possible.
