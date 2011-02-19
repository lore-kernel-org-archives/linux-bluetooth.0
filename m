Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
Date: Fri, 18 Feb 2011 22:29:34 -0300
Message-ID: <AANLkTi=zfNWfnW4C9=bbMb0Xn8E+tHEp_EmAz+z=j5AL@mail.gmail.com>
Subject: Re: [RFC v2 00/14] Store UUID-128 on host order
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

On Fri, Feb 18, 2011 at 7:29 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> It must NOT be included in the next release until proper testing.
>
> Any good soul wants to test it if I am not breaking SDP?

I did my own review (just by looking at source code, no actual
testing). We'd appreciate if more people can review and/or test these
patches. One idea would be to test on big endian systems, and compare
hcidump logs with/without these patches.

Note that it is not just a refactoring; It actually fixes endianness
issues with GATT.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
