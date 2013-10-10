Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 1/2] Bluetooth: Remove unneeded val variable when setting SSP
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAJdJm_Ne5rQ2G8_Je_en1kr9dxw76G_qW9gsm0WvH2On9x3dPw@mail.gmail.com>
Date: Thu, 10 Oct 2013 13:06:12 +0200
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <E21E9874-2D39-4F71-8D2E-F9EBA1A1F313@holtmann.org>
References: <1381399691-42391-1-git-send-email-marcel@holtmann.org> <CAJdJm_Ne5rQ2G8_Je_en1kr9dxw76G_qW9gsm0WvH2On9x3dPw@mail.gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

>> The variable val in the set_ssp() function of the management interface
>> is not needed. Just use cp->val directly since its input values have
>> already been validated.
>> [...]
>> -       if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags) == val) {
>> +       if (!!cp->val == test_bit(HCI_SSP_ENABLED, &hdev->dev_flags)) {
> 
> In this case, the "!!" trick is unnecessary as the only allowed values
> are 0x00 and 0x01 (I believe this has been removed in other similar
> cases).

it has not been removed. That is why I changed it and made it similar to the other case.

Regards

Marcel

