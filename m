Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [RFC 1/2] shared/aes-cmac: Add support for AES-CMAC-128
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAMudyAvpA2aLoP62B4ZibdD+MFUpmJwDQN2Nuu574ze_LFu_LQ@mail.gmail.com>
Date: Tue, 13 May 2014 06:52:56 -0700
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <3C818E37-9A4E-402C-AAEC-1D6676A3DF1B@holtmann.org>
References: <1399977868-31937-1-git-send-email-lukasz.rymanowski@tieto.com> <1399977868-31937-2-git-send-email-lukasz.rymanowski@tieto.com> <0C9B7B6F-E3B6-453A-86B2-3ECE979A7796@holtmann.org> <CAMudyAvpA2aLoP62B4ZibdD+MFUpmJwDQN2Nuu574ze_LFu_LQ@mail.gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

>>> This patch adds handling AES-CMAC-128 signing as specified in the NIST
>>> Special Publication 800-38B
>>> ---
>>> src/shared/aes-cmac.c | 346 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>> src/shared/aes-cmac.h |  38 ++++++
>>> 2 files changed, 384 insertions(+)
>>> create mode 100644 src/shared/aes-cmac.c
>>> create mode 100644 src/shared/aes-cmac.h
>> 
>> I really like to see it included in src/shared/crypto.c. Lets try that one first. It is meant to provide the whole crypto toolbox for us.
> 
> I tried but it did not look good to me then.
> 
> Anyway, what I need to do is to add to struct bt_crypro a member which
> will contain aes-cmac session data (key, sub keys, sign_counter)
> I need to also mess a bit with bt_crypto_new and add there parameters
> needed to initialize AES-CMAC ?
> Is that a good way?

just initialize AES-CMAC unconditionally in bt_crypto_new. We do that for the random number generator as well.

Regards

Marcel

