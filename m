Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPoQQ-3oDme-hXBhF07tKAL90Cpd+mzoDukL+1kP2K2qV2jjZw@mail.gmail.com>
References: <1457384483-19894-1-git-send-email-dev@codyps.com>
	<CABBYNZK9AerksXPwTu7EXpL_BUbQ64JHiHMTdDWLk6cHvRQDSA@mail.gmail.com>
	<CAPoQQ-3oDme-hXBhF07tKAL90Cpd+mzoDukL+1kP2K2qV2jjZw@mail.gmail.com>
Date: Wed, 9 Mar 2016 11:35:13 +0200
Message-ID: <CABBYNZJXXN5JcLbf-J8Xqyzv3KjKdYaWooebFpnvd8TwJOt=2A@mail.gmail.com>
Subject: Re: [PATCH BlueZ] uuid: fix 1 byte stack overflow
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Cody P Schafer <dev@codyps.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Cody,

On Tue, Mar 8, 2016 at 6:00 PM, Cody P Schafer <dev@codyps.com> wrote:
> AddressSanitizer is part of newer gcc & clang versions.
>
> All I did was build bluez with:
>
> make CFLAGS=-fsanitize=address\ -fsanitize=undefined\ -ggdb3\ -Wall\
> -Wextra\ -Wno-unused-parameter\ -Wno-missing-field-initializers\
> -Werror LDFLAGS=-pthread -j10
>
> The LDFLAGS bit is to work around a bug in binutils, and the warnings
> could be omitted if desired. Debug info is needed for address
> sanitizer to give line numbers.

Alright, we will probably need to add those flags (perhaps with
--enable-sanitize) to the build so make check would catch this type of
errors.
