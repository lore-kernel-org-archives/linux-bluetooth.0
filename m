Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] android/gatt: Fix handling advertising state
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAN_7+YbccmQce05h4A_TGQGgOToJhxx1B=xU=egf76zsfS8vXQ@mail.gmail.com>
Date: Wed, 14 May 2014 09:10:20 -0700
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Szymon Janc <szymon.janc@tieto.com>
Message-Id: <30C3CB2E-2C64-4E1D-8C9F-B4F83704BA8D@holtmann.org>
References: <1400066794-12621-1-git-send-email-lukasz.rymanowski@tieto.com> <D2E1C6A3-BB46-4C9D-8603-241B6CF69EBE@holtmann.org> <CAN_7+YbccmQce05h4A_TGQGgOToJhxx1B=xU=egf76zsfS8vXQ@mail.gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

>>> This patch fixes enabling advertising.
>>> It was not possible to enable it if we had server registered
>>> which is on listen_apps list but does not trigger advertising.
>> 
>> does this mean we always advertise when registering GATT server?
> No. We just put each server on the listen_apps queue and once remote
> device connects to us, this server gets connection callback.

this sounds all a bit weird. Did Android get this wrong. We can connect to a remote device and we can still receive GATT server exchange. It has really nothing to do with central or peripheral roles.

Regards

Marcel

