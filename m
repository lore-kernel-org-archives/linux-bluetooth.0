Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5517B933.1080809@cchtml.com>
References: <5517B933.1080809@cchtml.com>
Date: Sun, 29 Mar 2015 21:57:55 +0300
Message-ID: <CABBYNZ+VdZkU9y2TyH_6rsM_=8tVdGNrXUp9yX5NTAjy5k06bQ@mail.gmail.com>
Subject: Re: header change affects c++ projects
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michael Cronenworth <mike@cchtml.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Sun, Mar 29, 2015 at 11:34 AM, Michael Cronenworth <mike@cchtml.com> wrote:
> Hello,
>
> The move of "bswap_128()" in commit 232015aeefd1c945ccfaf9744e791c5888eafcf7
> breaks C++ projects. Specifically: The bswap_128() function is, without a
> cast, assigning a void* to a uint8_t*.

It will probably get applied, no reason to get neurotic on the weekend
no one said we would not take it, so please be patience.

> Can someone please review this commit? The message claims it is a "fix" but
> all I see is code copy and pasted along with a precision loss from uint128_t
> to uint8_t.

It is a fix to uuid: Add bt_uuid_to_le since the convention is to
define 128 bit UUIDs as big endian which then need to be swaped
regardless of endianess.

-- 
Luiz Augusto von Dentz
