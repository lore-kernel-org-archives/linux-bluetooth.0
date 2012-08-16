Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACUGKYMohmq0FDXk2DpmZfF_sPk_dfL7NEgN+jr9k+65D_r02A@mail.gmail.com>
References: <CACUGKYMjKcZZJsYi-SXCd1C=guWtKP3k=SBVPVe=+MR0R=pwHg@mail.gmail.com>
	<502C49F4.9060007@samsung.com>
	<CACUGKYOkxtCP_VgYtKWvSYHTb__m2rMCGujOAh6rKDXXYXLWZQ@mail.gmail.com>
	<CACUGKYOUh6G9zkifB98akXd_R8Axv6eh03-OCYnJyLNkkBTq3w@mail.gmail.com>
	<CAJdJm_PoC6CqojaroHPXy6sf-Sg+uS_DJZzm38Re6LDbUBmLHg@mail.gmail.com>
	<CACUGKYMohmq0FDXk2DpmZfF_sPk_dfL7NEgN+jr9k+65D_r02A@mail.gmail.com>
Date: Thu, 16 Aug 2012 11:57:46 -0400
Message-ID: <CAJdJm_OgdkmcXxFh_0pA3n+-RbPkWKB4ZZrsnDyndYrSGZ=rog@mail.gmail.com>
Subject: Re: Bluez 4.101
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: John Tobias <john.tobias.ph@gmail.com>
Cc: Chan-yeol Park <chanyeol.park@samsung.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Aug 16, 2012 at 11:38 AM, John Tobias <john.tobias.ph@gmail.com> wrote:
> Hi Anderson,
>
> Thanks for the info.
> May I know the difference between bluetooth.git and bluetooth-next.git repo?.

I may be wrong, but I think it is like this:

bluetooth-next.git contains what is going to the next kernel release
cycle. E.g. if we are on 3.6-rc1, what is currently on bluetooth-next
will probably enter upstream on 3.7. It may be less stable than
bluetooth.git.

bluetooth.git is for the current release cycle (i.e., will enter on 3.6).

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
