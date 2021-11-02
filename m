Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462C6C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Nov 2021 16:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B0B460524
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Nov 2021 16:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbhKBQsL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Nov 2021 12:48:11 -0400
Received: from tropek.jajcus.net ([31.179.132.94]:46212 "EHLO
        tropek.jajcus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbhKBQr3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Nov 2021 12:47:29 -0400
Received: from [10.253.0.4] (tropek.jajcus.net [31.179.132.94])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by tropek.jajcus.net (Postfix) with ESMTPSA id 84AFC84F62;
        Tue,  2 Nov 2021 17:20:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jajcus.net; s=mail;
        t=1635870010; bh=eH6GF405Svn0dyssGrU8IqIDyNYqcQZSkJqTyLUaY2I=;
        h=To:Cc:References:From:Subject:Date:In-Reply-To:From;
        b=t9ia3wA4NvWOToYNSrnplNxtqv6NKbI4vt1LMZe5n7C+yNAJ71somoLFCIE0EFPI+
         aRv/kFYx9Wd6mOpua/0Gf32D5N+YSEBzbeza3b/HCMCKwuIlMVd8MAbGSFarZ45EVW
         tEMVgcs40zXKWkuGLwM7wGNH5BlqaUcz2Q9XjP0DmzKuM2L3J87EfS4ZMgFfAsFVjj
         7AZQrpi8oZ1mfLzAffKsbeqOaWpJWT0VrG6UwM0LZhz3r9K2aZEGAz0BApTeQSBtl+
         bg/c7/2Dx/kJuYf+mdjeDk4xH9jmgG5taiTHlVxc2rexnYle+/sHadaqe2JaJRn+fa
         W75ZNruPYJanQ==
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
References: <585f70ee-e8f0-dfbc-6d61-f5082a1c18aa@jajcus.net>
 <0CC57655-ABBE-49A9-88F2-92AE313B7968@holtmann.org>
From:   Jacek Konieczny <jajcus@jajcus.net>
Subject: Re: Is there a way to force legacy LE pairing for a device
Message-ID: <7493ca64-e4e5-49bb-0d11-719dc212a6bc@jajcus.net>
Date:   Tue, 2 Nov 2021 17:20:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <0CC57655-ABBE-49A9-88F2-92AE313B7968@holtmann.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On 11/2/21 9:43 AM, Marcel Holtmann wrote:
> you can use btmgmt tool from bluez.git to force Secure Connections off. I am not sure if that sticks when starting bluetoothd, but then you need to hack it out there.

Thank you! This works. I had to run 'btmgmt sc off' after starting
bluetoothd, before 'power on', but then I was able to pair with my
device. When paired MIDI over Bluetooth is working properly.

Even after I re-enable SC the connection with the already-paired device
works.

I think I can work with that.

> I am really not sure how your device can be a qualified Bluetooth device and fail here. The handling of the flags has actually proper test cases to ensure that this does’t happen.

That would not be a first time when a device is compatible with the
standard it is advertised with. Especially that for this one this is
extra feature hardly anyone uses and the manufacturer does not even
support their own software properly (the Android app just doesn't work)
and usually the USB interface would be rather used than BT, anyway.

What is interesting this amplifier has two different BT adapters. It can
function as a 'bluetooth speaker' and this seems to be working without
any issue. It is the 'regular Bluetooth', not LE. This one feature would
be probably enough to call this Bluetooth device.

The other function is amplifier remote control via MIDI over Bluetooth.
This seems to be a separate BLE interface and works as I described. It
does not even have any special 'pairing mode' (the 'speaker' function
requires pressing a button on the device) or pairing verification, so
anyone can pair with the amplifier at any time (unless already someone
else uses the BLE interface) and change its settings. It would be quite
an interesting attack if anyone used those devices on stage. Using SC or
not probably does not matter at this point at all.

Greets,
Jacek
