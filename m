Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMv5GbeUSG45-S2_zKXXDmYJPZ9hhmsNgGEFJNy_c0KLjL83Ew@mail.gmail.com>
References: <1405718037-15401-1-git-send-email-armansito@chromium.org>
	<1405718037-15401-5-git-send-email-armansito@chromium.org>
	<CAMv5GbeUSG45-S2_zKXXDmYJPZ9hhmsNgGEFJNy_c0KLjL83Ew@mail.gmail.com>
Date: Mon, 21 Jul 2014 15:17:17 -0700
Message-ID: <CAHrH25SZ+wXi5kfoxOTFQLFhMXoO0VAwnFggbLg0ipvm2T262A@mail.gmail.com>
Subject: Re: [PATCH 04/11] shared/gatt: Implement "Discover Primary Service by
 UUID" procedure.
From: Arman Uguray <armansito@chromium.org>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

>>         if (src->type == BT_UUID16)
>>                 put_le16(src->value.u16, dst);
>> +       else if (src->type == BT_UUID32)
>> +               put_le32(src->value.u32, dst);
>
> Specification Core 4.1 says that 32bit UUIDS in GATT should be
> converted to 128bit. Please check it [Vol. 3] Part G, Section 2.5.4
>

You're right, thanks for catching that.
